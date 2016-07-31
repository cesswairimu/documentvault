require 'test_helper'

class AddDocumentTest < ActionDispatch::IntegrationTest
def setup
  @current_user = users(:cess)
end

   test "the adding a new document" do
     assert_not  @current_user.nil?
     get new_document_path
     post documents_path params: {
       document: {
         title: "fgfhsgsjjs", link: "hdshdgfjdh", tag: "ghdhgdg", 
         department: "Training", content: "the earth is round you know i know that and i dont believe it why dont i see the
         moon in my room, crazy right? like why would it be there"

       }
     }
       assert_template 'documents/show'
       assert_not flash.empty?
  end
end
