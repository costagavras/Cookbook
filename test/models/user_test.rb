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

  # test "username can be mixed case" do
  #   mixed_case_name = "pinCus"
  #   @user.name = mixed_case_name
  #   @user.save
  #   assert_equal mixed_case_name.downcase, @user.reload.name
  # end


end
