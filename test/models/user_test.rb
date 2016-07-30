require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Cess", email: "cess@gmail.com", password: "terrence", password_confirmation: "terrence")
  end

 test "name should be present" do
   @user.name = " "
     assert_not @user.valid?
   end
 test "email should be present" do
   @user.email =""
     assert_not @user.valid?
 end

 test "name should have maximum length" do
   @user.name = "a" * 21
   assert_not @user.valid?
 end

 test "email should not be more than 30 xters" do
   @user.email = "c" * 31
   assert_not @user.valid?
 end

 test "password should have minimum length" do
   @user.password = @user.password_confirmation = "a" * 3
   assert_not @user.valid?
 end
 test "email validation should accept valid addresses" do
   valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
   first.last@foo.jp alice+bob@baz.cn]
   valid_addresses.each do |valid_address|
     @user.email = valid_address
     assert @user.valid?, "#{valid_address.inspect} should be valid"
   end
 end
end
