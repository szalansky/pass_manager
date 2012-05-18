require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new
    @user.email = "pat@example.com"
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
end
