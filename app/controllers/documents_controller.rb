class DocumentsController < ApplicationController
  def new
    @document = current_user.documents.build
  end

  def create
    @document = current_user.documents.build(doc_params)
    if @document.save
      flash[:yeah] = "Successfully added a new document in the vault"
      redirect_to @document
    else
      flash[:nasty] = "Error adding the document"
      render 'new'
    end
  end

def show
  @document = Document.find(params[:id])
end

def department
  @department = Document.where("department = ?", "Training")
end
# def market
#   @department = Document.where("department = ?", "Marketing")
# end

# depf compute
#   @department = Document.where("department = ?", "Computing")
# end

# def account
#   @department = Document.where("department = ?", "Accounting")
# end
# def operation
#   @department = Document.where("department = ?", "Operations")
# end
def index
  @documents = Document.all
end

  private
def doc_params
  params.require(:document).permit(:title, :link, :tag, :department, :content)
end
      
end
