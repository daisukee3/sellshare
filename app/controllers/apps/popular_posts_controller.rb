class Apps::PopularPostsController < Apps::ApplicationController
  def show
    user_ids = current_user.followings.pluck(:id)
    @tweets = Tweet.where(user_id: user_ids)
    
    # tweet_like_count = @tweet.joins(:likes).group(:tweet_id).count
    # tweet_liked_ids = Hash[tweet_like_count.sort_by{ |_, v| v }.reverse].keys
    # @tweet_rankings= Tweet.find(tweet_liked_ids)
  end
end
