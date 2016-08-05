class PasswordResetsController < ApplicationController
  before_action :check_expiration, only: [:edit, :update]
  before_action :find_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_digest
      flash[:info] = "You been mailed reset instructions"
      redirect_to root_url
    else
      flash[:nasty] = "Email address not found... use an email you used to sign up"
      render 'new'
    end
  end

  def edit
  end

  def update
    if password_blank?
      flash[:nasty] = "Password cannot be blank?"
      render 'edit'
    elsif @user.update_attributes(join_params)
      log_in @user
      flash[:yeah] = "Password changed successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def join_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  def password_blank?
    params[:user][:password].blank?
  end

  def find_user
    @user = User.find_by(email: params[:email])
  end
  def valid_user
    unless (@user && @user.activated? &&
            @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset link expired!!!!"
      redirect_to new_password_reset_url
    end
  end


end
