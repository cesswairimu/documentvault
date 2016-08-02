class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :show ]
  before_action :correct_user, only: [:edit, :update]
  def new
  @user = User.new
  end

  def create
    @user = User.new(join_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Check you email to get the fun started "
      # redirect_to @user
      # log_in @user
      # render 'show'
      redirect_to root_url
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

  def logged_in_user
    unless logged_in?
      store_location
      flash[:nasty] = "Login in first Bunch!!"
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to (root_url) unless @user == current_user
  end
end
