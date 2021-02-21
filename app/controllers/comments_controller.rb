class CommentsController < ApplicationController
  def new
    tweet = Tweet.find(params[:tweet_id])
    @comment = tweet.comments.build
  end
end