class Apps::TimelinesController < Apps::ApplicationController
  def show
    user_ids = current_user.followings.pluck(:id)
    @tweets = Tweet.where(user_id: user_ids).page(params[:page]).per(5).order(created_at: :desc)
  end
end
