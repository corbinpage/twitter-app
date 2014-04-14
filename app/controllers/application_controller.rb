class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    render :index
  end

  def heatmap
    render 'heatmap'
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

  def experiment
    tweet_array = Tweet.where("id > ?", params[:after].to_i).order(created_at: :desc).limit(1)
    @tweet = tweet_array.empty? ? {id: -1} : tweet_array.first
    render :json => @tweet
  end

  def beverage
    @jsonbevs = {name: 'bevs',children: Beverage.joins(:beverage_tweets).limit(50).group('beverages.text').count.map{|k,v| [{'name'=> k,'size'=> v}]}.flatten}.to_json.html_safe
    respond_to do |f|
      f.json { render :json => @jsonbevs }
      f.html
    end
    # Beverage.joins(:beverage_tweets).group('beverages.text').count
  end

  def jsonbev

  end

  def frameworks

  end

  def frameworks_update
    data_hash = {id: 1}
    language_counts = WordType.joins(words: :word_tweets)
                              .where("word_Types.text ='languages'")
                              .where('word_tweets.created_at > ?',Time.now - 1.minutes)
                              .group('words.text')
                              .count
    language_counts.each {|k,v| data_hash[k.downcase.to_sym] = v}

    render :json => data_hash
  end

  def clearbev
    BeverageTweet.delete_all

    respond_to do |f|
      f.js
    end
  end
end
