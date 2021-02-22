class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweets = current_user.favorite_tweets
  end
end
