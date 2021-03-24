class CommentsController < ApplicationController

  # def index
  #   tweet = Tweet.find(params[:tweet_id])
  #   comments = tweet.comments
  #   render json: comments, include: { user: [ :profile] }
  # end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save!

    @tweet.create_notification_comment!(current_user, @comment.id)

    render :index
    # render json: @comment, include: { user: [ :profile] }
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
