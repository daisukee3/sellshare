class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update, :destroy]
  before_action :set_my_tweet, only: [:edit, :update]
  before_action :set_tweet, only: [:show]

  def index
    @tweets = Tweet.all
    @tweets = Tweet.page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @comment = Comment.new
    #新着順で表示
    @comments = @tweet.comments
  end

  def new
    @tweet = current_user.tweets.build
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to tweets_path(@tweet), notice: '保存完了'
    else
      flash.now[:error] = '保存失敗'
      render :new
    end

  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweets_path(@tweet), notice: '更新完了'
    else
      flash.now[:error] = '更新失敗'
      render :edit
    end

  end

  def destroy
    @tweet = Tweet.find(params[:id])
    if current_user.admin?
      @tweet.destroy!
      redirect_to tweets_path, notice: 'ユーザーの投稿を削除完了'
    elsif current_user
      @tweet.destroy!
      redirect_to tweets_path, notice: '削除完了'
    else
      flash[:danger] = "他人の投稿は削除できません"
      redirect_to tweets_path
    end
  end

  def search
    @search_word = params[:q][:content_cont] if params[:q]
    @q = Tweet.page(params[:page]).per(10).ransack(params[:q])
    @tweets = @q.result(distinct: true)
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content, :eyecatch, images: [])
  end

  def set_my_tweet
    @tweet = current_user.tweets.find(params[:id])
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
