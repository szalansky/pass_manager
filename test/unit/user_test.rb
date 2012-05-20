require 'test_helper'

class UserTest < ActiveSupport::TestCase

  fixtures :users, :passwords
  
  def setup
    @user = User.new
    @user.email = "pat@example.com"
    @existing_user = users(:existing)
  end

  test "should validation pass with password meeting guidelines" do
     @user.password = "a!aBB1PAs2sW@ORD"
     assert @user.valid?
  end

  test "should validation fail with too long password" do
     @user.password = "aaBB12!@PASSWORDPASSWORDPASSWORDPASSWORDPASSWORDPASSWORD"
     assert !@user.valid?
  end

  test "should validation fail with password having too few small letters" do
     @user.password = "aABB12!@"
     assert !@user.valid?
  end

  test "should validation fail with password having too few big letters" do
     @user.password = "aabB12!@"
     assert !@user.valid?
  end

  test "should validation fail with password having too few digits" do
     @user.password = "aaBB1@!@PASSWORD"
     assert !@user.valid?
  end

  test "should validation fail with password having too few special characters" do
     @user.password = "aaBB121@PASSWORD"
     assert !@user.valid?
  end

  test "should password created 14days 1hour ago be expired" do
    @user.password_updated_at = DateTime.now - 14.days - 1.hours
    assert @user.password_expired?
  end

  test "should not password 7days ago be expired" do
    @user.password_updated_at = DateTime.now - 7.days
    assert !@user.password_expired?
  end

  test "should validation fail with password listed as used" do
    @existing_user.password = "kkBB12!@"
    assert !@existing_user.valid?
  end
end
