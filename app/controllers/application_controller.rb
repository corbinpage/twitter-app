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
      @tweet = Tweet.last
    else
      tweet_array = Tweet.where("id > ?", params[:after].to_i).order(created_at: :desc).limit(1)
      @tweet = tweet_array.empty? ? {id: -1} : tweet_array.first
      binding.pry
    end
    render :json => @tweet
  end
  # -------------------

  # Twubbles Page - One HTML for initial page load and then JSON updates
  def twubbles
    tweet_text = WordTweet.recent_sad_tweets
    @sad_tweets = tweet_text.sample(5).map{|x| x[0]}
    respond_to do |f|
      f.json { render :json => twubbles_json(@sad_tweets) }
      f.html
    end
  end  

  # -------------------

  def techochamber
    logger.info "made it to controller action"
    respond_to do |f|
      f.csv { render text: to_csv(get_mentions) }
      f.json { render :json => @mentions.to_json.html_safe }
      f.html
    end
  end

  def testshowreel
    render 'test_showreel'
  end

  def stocks
    render 'stocks.csv'
  end

  private
  def twubbles_json(sad_tweets)
    {
      name: 'twubbles',
      children: twubbles_counts = Word.recent_sad_words,
      sad_tweets: sad_tweets
    }.to_json.html_safe    
  end

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

  def truncate_last_minute(mentions_array)
    mentions_array[0..-6]
  end

  def get_mentions
    truncate_last_minute(WordTweet.tech_tweets)
  end

end
