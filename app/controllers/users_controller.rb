class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.admin?
      @user.destroy
      redirect_to root_path, notice: 'ユーザーを削除しました'
    elsif current_user?(@user)
      @user.destroy
      redirect_to root_path, notice: '自分のアカウントを削除しました'
    else
      flash[:danger] = "他人のアカウントは削除できません"
      redirect_to root_path
    end
  end

end