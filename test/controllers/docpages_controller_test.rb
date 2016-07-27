require 'test_helper'

class DocpagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get docpages_home_url
    assert_response :success
  end

  test "should get about" do
    get docpages_about_url
    assert_response :success
  end

  test "should get support" do
    get docpages_support_url
    assert_response :success
  end

end
