class LoginsController < ApplicationController
  def new
  end
  def create 
    user = User.find_by(name: params[:login][:name])
    if user && user.authenticate(params[:login][:password])
       if user.activated? 
        log_in user 
        params[:login][:remember_me]== '1' ? remember(user) : forget(user)
        flash[:yeah]= "Welcome back"
        redirect_back_or user
       else
         flash[:nasty] = "Account not activated"
         redirect_to root_url
       end
    else
      flash[:nasty] = "Invalid Creditials Name and username does not match!!"
      render 'new'
    end
  end


  def destroy
    logout if logged_in?
    redirect_to root_url
  end
end
