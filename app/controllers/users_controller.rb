class UsersController < ApplicationController
  def new
  @user = User.new
  end

  def create
    @user = User.new(join_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def join_params
    params.require(:user).permit( :name, :email, :password, :password_confirmation )
  end
end
