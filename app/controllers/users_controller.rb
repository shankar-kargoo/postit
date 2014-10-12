class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :vote]

  def show   
  end

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
    if @user.update(user_params)
      flash[:notice] = "Your Profile was updated."
      redirect_to posts_path
    else
      @user.errors
      render :edit      
    end
  end

  private
  def user_params
   params.require(:user).permit(:username, :password, :phone, :time_zone, :slug)
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end
end