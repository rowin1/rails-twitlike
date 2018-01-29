require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example user", email: "user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

end