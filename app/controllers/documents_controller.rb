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
      flash.now[:nasty] = "Error adding the document"
      render 'new'
    end
  end

def show
  @document = Document.find(params[:id])
end

def index
  @documents = Document.all
end

  private
def doc_params
  params.require(:document).permit(:title, :link, :tag, :department)
end
      
end
