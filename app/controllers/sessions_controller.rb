class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        user.send_pin_to_twilio      
        redirect_to pin_path
      else
        session[:user_id] = user.id
        flash[:notice] = 'Welcome, You logged in!'
        redirect_to posts_path
      end
    else 
      flash[:error] = "There's something wrong with your username or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You logged out!'
    redirect_to root_path
  end

  def pin 
    access_denied if session[:two_factor].nil?
    if request.post?
      user = User.find_by pin: params[:pin]
      if user
        session[:two_factor] = nil
        user.remove_pin!
        session[:user_id] = user.id
        flash[:notice] = 'Welcome, You logged in!'
        redirect_to posts_path
      else
        flash[:error] ="Sorry something is wrong with your pin number."
        redirect_to pin_path
      end
    end
  end

end