class TweetsController < ApplicationController

  before_action 'move_to_index', except: 'index'

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new

  end

  def create
    Tweet.create(tweets_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.user.id == current_user.id
      tweet.destroy
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if current_user == tweet.id
      tweet.update(update_params)
    end
  end

  private
  def tweets_params
    prm = params.permit(:name, :image, :text)
    prm[:user_id] = current_user.id
    return(prm)
  end

  def move_to_index
      redirect_to action: :index unless user_signed_in?
  end

  def update_params
    params.permit(:text, :image)
  end

end
