class CommentsController < ApplicationController
  def new
    tweet = Tweet.find(params[:tweet_id])
    @comment = tweet.comments.build
  end

  def create
    tweet = Tweet.find(params[:tweet_id])
    @comment = tweet.comments.build(comment_params)
    if @comment.save
      redirect_to tweet_path(tweet), notice: 'コメントを追加'
    else
      flash.now[:error] = 'コメントできませんでした'
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end