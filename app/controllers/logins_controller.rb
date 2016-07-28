class LoginsController < ApplicationController
  def new
  end
  def create 
    user = User.find_by(name: params[:login][:name])
    if user && user.authenticate(params[:login][:password])
      flash[:yeah]= "Welcome back"
      log_in user 
      redirect_to user
      remember user
    else
      flash[:nasty] = "Check your email and password Bunch"
      render 'new'
    end
  end
  

  def destroy
    logout if logged_in?
    redirect_to root_url
  end
end
