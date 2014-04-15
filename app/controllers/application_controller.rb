class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Home Page - Splash page and About page for the App
  def home
  end
  # -------------------

  # HivePulse Page - One HTML for initial page load and then JSON updates
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
  # -------------------

  # Twibbles Page - One HTML for initial page load and then JSON updates
  def beverage
    @jsonbevs = {name: 'bevs',children: beverage_counts = WordType.joins(:tweets).where(text: 'beverages').where('tweets.created_at > ?',Time.now - 10.seconds).group('words.text').count.map{|k,v| [{'name'=> k,'size'=> v}]}.flatten}.to_json.html_safe
    respond_to do |f|
      f.json { render :json => @jsonbevs }
      f.html
    end
  end
  # -------------------

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

  def showreel
    @mentions = WordTweet.get_tech_tweets
    #binding.pry
    respond_to do |f|
      f.csv { render text: to_csv(@mentions) }
      f.json { render :json => @mentions.to_json.html_safe }
      f.html
    end
  end

  def stocks
    render 'stocks.csv'
  end

  private
  def to_csv(array)
    column_names = ["name", "date", "mentions"]

    CSV.generate do |csv|
      csv << column_names
      array.each do |company_data|
        csv << company_data
        # csv << word_tweet.attributes.values_at(*column_names)
      end
    end
  end

end
