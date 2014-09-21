class PostsController < ApplicationController

  def index
  	@posts = Post.all
  end
  
  def show
 		@post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "Your Post has been updated."
      redirect_to posts_path
    else
      @post.errors
      render :edit      
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      @post.errors
      render :new
    end
  end

private

def post_params
   params.require(:post).permit!
end

end