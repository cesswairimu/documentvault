class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:yeah] = "Account activated!"
      redirect_to user
    else
      flash[:nasty] = "Invalid activation link"
      redirect_to root_url
    end
  end

end
