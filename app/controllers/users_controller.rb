class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :show ]
  before_action :correct_user, only: [:edit, :update]
  def new
  @user = User.new
  end

  def create
    @user = User.new(join_params)
    if @user.save
      flash[:yeah] = "Welcome to the application "
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end
  def show
    @user = User.find(params[:id])
    @documents = @user.documents
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(join_params)
      flash[:yeah] = "Profile has been updated!!"
      redirect_to @user
    else 
      render 'edit'
    end
  end

  private
  def join_params
    params.require(:user).permit( :name, :email, :password, :password_confirmation )
  end

 
  def correct_user
    @user = User.find(params[:id])
    redirect_to (root_url) unless @user == current_user
  end
end
