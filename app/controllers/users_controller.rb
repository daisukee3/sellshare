class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to root_path, notice: '削除完了'
  end

end