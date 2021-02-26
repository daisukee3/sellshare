class Apps::FavoritesController < Apps::ApplicationController
  def index
    @tweets = current_user.favorite_tweets
  end
end
