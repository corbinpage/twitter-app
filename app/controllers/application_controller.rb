class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home

  end

  def update
    if params[:after].nil? # First time the page loads
      @tweet = tweet.last
    else
      tweet_array = Tweet.where("id > ?", params[:after].to_i).order(created_at: :desc).limit(1)
      @tweet = tweet_array.empty? ? {id: -1} : tweet_array.first
    end
    render :json => @tweet
  end

  def realtime
  end

  def about
  end

  def heatmap
        render 'heatmap'
  end

end
