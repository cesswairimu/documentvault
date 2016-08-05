require 'test_helper'

class UsersJoinTest < ActionDispatch::IntegrationTest
  test "unsuccessful joining" do
    get join_path
    assert_no_difference 'User.count' do
      post users_path, params:{
        user: {
          name: "cessy", email: "the badoney", password: "law", 
          password_confirmation: "lawrence"
        }
      }
    end
    assert_template 'users/new'
  end
  
  test "Successful join to the app" do
    get join_path
    assert_difference 'User.count', 1 do
      post users_path, params:{
        user: {
          name: "Renny", email: "kuku@gmail.com", password:"terrence",
          password_confirmation: "terrence"
        }
      }
    end
    follow_redirect!
    # assert_template 'users/show'
    # assert_not flash.empty?
  end

end
