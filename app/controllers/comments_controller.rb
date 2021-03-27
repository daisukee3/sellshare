class CommentsController < ApplicationController

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      @tweet.create_notification_comment!(current_user, @comment.id)
      render :index
    else
      render :index
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user.admin?
      @comment.destroy!
      render :index
    elsif current_user
      @comment.destroy! 
      render :index
    else
      render :index
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
