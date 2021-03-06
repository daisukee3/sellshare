class Apps::PopularPostsController < Apps::ApplicationController
  def show
    @tweets = Tweet.limit(5)
    tweet_like_count = @tweets.joins(:likes).group(:tweet_id).count
    tweet_liked_ids = Hash[tweet_like_count.sort_by{ |_, v| v }.reverse].keys
    @tweet_rankings= Tweet.find(tweet_liked_ids)
  end
end
