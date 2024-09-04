module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
  end

  private

  def require_authentication
    resume_session || request_authentication
  end

  def resume_session
    if session = find_session_by_cookie
      set_current_session session
    end
  end

  def find_session_by_cookie
    if token = cookies.signed[:session_token]
      Session.find_signed(token)
    end
  end

  def request_authentication
    redirect_to new_session_url
  end

  def start_new_session_for(user)
    user.sessions.create!.tap do |session|
      cookies.signed.permanent[:session_token] = { value: session.signed_id, httponly: true, same_site: :lax }
    end
  end

  def set_current_session(session)
    Current.session = session
  end

  def end_current_session
    Current.session.destroy!
    cookies.delete(:session_token)
  end
end
