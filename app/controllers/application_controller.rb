class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include LoginsHelper
  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:nasty] = "Login in first Bunch!!"
      redirect_to login_path
    end
  end

end
