class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:notice] = "Your account has been created."
      session[:user_id] = @user.id #(setting the current session user to the newly created user)
      redirect_to posts_path
    else
      @user.errors
      render :new
    end
  end

  def edit
  end

  def update
  end

  private
  def user_params
   params.require(:user).permit(:username, :password, :phone, :time_zone)
  end

end
