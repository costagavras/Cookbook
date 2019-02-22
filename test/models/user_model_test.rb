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

  test "username should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

# factories

  test "factory user must be valid" do
    user = build(:user)
    assert user.valid?
  end

  test "user is invalid without the first name" do
    user = build(:user)
    user.name = nil
    refute user.valid?
  end

  test "user is invalid if password confirmation doesn't match" do
    user = build(:user)
    user.password_confirmation = "234"
    refute user.valid?
  end

  test "user should be unique" do
    user = create(:user)
    user2 = build(:user)
    refute user2.valid?
  end

end
