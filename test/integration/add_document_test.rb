require 'test_helper'

class AddDocumentTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:cess)
  end

  test "Unsuccessful document addition" do
    log_in_as(@user, remember_me: '1')
    get new_document_path
    assert_template 'documents/new'
    assert_no_difference 'Document.count' do
      post documents_path params: {
        document: { title: "", tag: "", link:"",
                    department: "", content: ""

      }
      }
    end
    assert_not flash.empty?
    assert_template 'documents/new'
    # assert_select "ul", "have"
  end

  test "the adding a new document" do
    log_in_as(@user, remember_me: '1')
    get new_document_path
    assert_template 'documents/new'
   assert_difference 'Document.count', 1 do
    post documents_path params: {
      document: {
        title: "fgfhsgsjjs", link: "hdshdgfjdh", tag: "ghdhgdg", 
        department: "Training", content: "the earth is round you know i know that and i dont believe it why dont i see the
        moon in my room, crazy right? like why would it be there"

      }
    }
  end
  follow_redirect!
  assert_template 'documents/show'
  assert_not flash.empty?
end
end
