class PostsController < ApplicationController

before_action :set_post, only: [:show, :edit, :update]

  def index
  	@posts = Post.all
  end

  def show
    #  @post = Post.find(params[:id]) refer before actions
    @comment = Comment.new
  end
  
  def new
    @post = Post.new
  end

  def create

    @post = Post.new(post_params)
    @post.creator = User.first # TODO: Change once we add authenticationand know who the user is.
    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      @post.errors
      render :new
    end
  end
  
  def edit
  #  @post = Post.find(params[:id]) refer before actions
  end

  def update

  #  @post = Post.find(params[:id]) refer before actions
    if @post.update(post_params)
      flash[:notice] = "Your Post has been updated."
      redirect_to posts_path
    else
      @post.errors
      render :edit      
    end
  end

private

def post_params
   params.require(:post).permit(:url, :title, :description, category_ids: [])
end

def set_post
  @post = Post.find(params[:id])
end

end