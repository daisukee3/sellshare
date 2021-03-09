class FollowsController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:account_id])
    @followers = user.followers
  end

  def show
    user = User.find(params[:account_id])
    follow_status = current_user.has_followed?(user)
    render json: { hasFollow: follow_status }
  end

  def create
    user = User.find(params[:account_id])
    current_user.follow!(user)
    user.create_notification_follow!(current_user)
    render json: { status: 'ok' }
  end
end
