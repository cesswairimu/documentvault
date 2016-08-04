require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:cess)
  end
  test "Login with incorrect information" do
    get login_path
    assert_template 'logins/new'
    post logins_path, params:{
      login: { 
        name: "",
        password: "" 
      }
    }
    assert_template 'logins/new'
    assert_not flash.empty?
  end

  test "Login with correct information" do
    get login_path
    assert_template 'logins/new'
    post login_path, params:{
      login:{
        name: "cess", password: "password"
      }
    }
    follow_redirect!
    assert_template 'users/show'
    # assert_select "a[href=?]", login_path, count: 0
    # assert_select "a[href=?]", logout_path
    # assert_select "a[href=?]", user_path(@user)
    # assert_select "a[href=?]", new_document_path
    # assert_select "a[href=?]", documents_path
    assert_not flash.empty?
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end
  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
