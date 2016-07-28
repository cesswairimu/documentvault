class DocumentsController < ApplicationController
  def new
    @document = Document.new
  end

  def create
    @document = Document.new(doc_params)
    if @document.save
      flash[:yeah] = "Successfully added a new document in the vault"
      redirect_to root_url
    else
      flash[:nasty] = "Error adding the document"
      render 'new'
    end
  end

def show
end

def index
  @documents = Document.all
end

  private
def doc_params
  params.require(:document).permit(:title, :link, :tag, :department)
end
      
end
