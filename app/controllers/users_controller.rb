class UsersController < ApplicationController

  def index
    @users = User.all.page(params[:page]).per(10)
  end

end