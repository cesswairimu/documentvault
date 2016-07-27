class UsersController < ApplicationController
  def new
  @user = User.new
  end

  def create
    @user = User.new(join_params)
    if @user.save
      flash[:yeah] = "Welcome to Document Vault Cheeers!! have fun"
      redirect_to @user
    else
      render 'new'
    end
  end
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(join_params)
   if @user.save
     redirect_to @user
   else 
     render 'edit'
   end
  end

  private
  def join_params
    params.require(:user).permit( :name, :email, :password, :password_confirmation )
  end
end
