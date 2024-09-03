require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "normalizing email" do
    user = User.create! email: "TOTO@email.com    ", password: "password"
    assert_equal "toto@email.com", user.email
  end
end
