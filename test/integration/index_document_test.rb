require 'test_helper'

class EditTest < ActionDispatch::IntegrationTest
  def setup
   @user = users(:cess)
  end
  test "should show all the documents" do 
log_in_as(@user)
get documents_path
assert_template 'documents/index'
end

end
