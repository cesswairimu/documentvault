class DocumentsController < ApplicationController
  add_breadcrumb "Documents", :documents_path
  before_action :logged_in_user
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
    @documents= Document.where("department= @document.title")
    add_breadcrumb @document.department, documents_path(department: @document.department)
    add_breadcrumb @document.title, @document
  end
  def edit
    @document = Document.find(params[:id])
  end
  def update
    @document = Document.find(params[:id])
    if
      @document.update_attributes(doc_params)
      flash[:yeah] = "Successful Edit!!"
      redirect_to @document
    else
      flash[:nasty] = "Error editing document!!!"
      render 'edit'
    end

  end
  def index
    if params[:department]
      @documents = Document.where("department = ?", params[:department])
    elsif
      params[:search] 
      @documents = Document.search(params[:search]).order("id")
    else
      @documents = Document.all
    end
  end
  def destroy
    @document = Document.find(params[:id]).destroy
    flash[:info] =  "You have deleted #{@document.title}"
    redirect_to user_path
  end

  private
  def doc_params
    params.require(:document).permit(:title, :link, :tag, :department, :content)
  end

end
