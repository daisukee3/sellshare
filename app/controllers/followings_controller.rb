class FollowingsController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:account_id])
    @followings = user.followings.page(params[:page]).per(10)
  end

end
