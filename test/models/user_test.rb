require 'test_helper'

class UserTest < ActiveSupport::TestCase

#unit tests

  test "a user with no attributes is not valid" do
    user = User.new
    assert_not user.save #saved user with no attributes
    assert !User.new.valid?
  end

  def setup
    @user = User.new(name: "Pincus", password: "Swincus",
      password_confirmation: "Swincus")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = "   "
    assert_not @user.valid?
  end

  test "password should be confirmed" do
    @user.password = "hello"
    @user.password_confirmation = "ciao"
    assert_not @user.valid?
  end

end
