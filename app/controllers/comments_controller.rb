class CommentsController < ApplicationController

  before_action :require_user

  def create
  	@post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:comment))
    @comment.post = @post
    @comment.creator = current_user #User.find(1) # TODO to be fixed later after we implement authentication.
    # @comment = @post.comments.build(params.require(:comment).permit(:comment)) This will consolidate above 2 lines into 1. basically adds the comment to the array of comments to that post.
		if @comment.save
			flash[:notice] = 'Your comment was added'
			redirect_to post_path(@post)
		else
			render 'posts/show'
		end
  end

  def vote
    comment = Comment.find(params[:id])
    vote = Vote.create(vote: params[:vote], creator: current_user, voteable: comment)
    if vote.valid?
      flash[:notice] = 'Your vote was counted'
      redirect_to :back
    else
      flash[:error] = 'Your can only vote on this comment once'
      redirect_to :back
    end

  end
end
