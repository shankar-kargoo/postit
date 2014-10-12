class PostsController < ApplicationController
  
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show ]
  before_action :require_creator, only: [:edit, :update]


  def index
  	@posts = Post.all.sort_by{|x| x.total_votes}.reverse
    respond_to do |format|
      format.html
      format.json {render json: @posts}
      format.xml {render xml: @posts}
    end
  end

  def show
    @comment = Comment.new
    respond_to do |format|
      format.html
      format.json {render json: @post}
      format.xml {render xml: @post}
    end
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user #User.first # TODO: Change once we add authenticationand know who the user is.
    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      @post.errors
      render :new
    end
  end
  
  def edit

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

  def vote

    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: @post)

    respond_to do |format|
      format.html {
        if @vote.valid?
          flash[:notice] = 'Your vote was counted'
          redirect_to :back
         else
          flash[:error] = 'Your can only vote on this post once'
          redirect_to :back
          end
        }
        format.js 
    end 
  end


  private

  def post_params
     params.require(:post).permit(:url, :title, :description, :slug, category_ids: [] )
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def require_creator
    access_denied unless logged_in? and (current_user == @post.creator || current_user.admin?)
  end

end















