class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in? # makes these controller methods also avaliable in view templates also. 

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id] #memoization hence ||= is used.
  end
  
  def logged_in?
  	!!current_user # !! is used to convert current_user into a boolian.
  end

  def require_user
    if !logged_in?
      flash[:notice] = "Must be logged in to perform this action"
      redirect_to root_path
    end
  end
  
  def require_admin
    access_denied unless logged_in? and current_user.admin?
  end

  def access_denied
   flash[:error] = "only admin can perform this action"
   redirect_to root_path
  end
end
