class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    tweet = Tweet.find(params[:tweet_id])
    tweet.likes.create(user_id: current_user.id)
    redirect_to tweet_path(tweet)
  end
end