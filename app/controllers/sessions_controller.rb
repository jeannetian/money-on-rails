class SessionsController < ApplicationController
  skip_before_action :require_authentication, only: [ :new, :create ]

  def new
  end

  def create
    if user = User.authenticate_by(session_params)
      start_new_session_for user
      redirect_to root_path
    else
      flash[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    end_current_session
    redirect_to root_path
  end

  private
    def session_params
      params.permit(:email, :password)
    end
end
