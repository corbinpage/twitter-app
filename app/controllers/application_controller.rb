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

  # Twubbles Page - One HTML for initial page load and then JSON updates
  def twubbles
    @json = {name: 'twubbles',children: twubbles_counts = 
        WordType.joins(:tweets).where(text: 'twubbles').
        where('tweets.created_at > ?',Time.now - 10.seconds).
        group('words.text').count.map{|k,v| [{'name'=> k,'size'=> v}]}.
        flatten}.to_json.html_safe
    @tweet_text  = WordTweet.joins(:tweet)
                            .joins(word: :word_type)
                            .select('tweets.text as tweet_text','tweets.sentiment_score as tweet_score')
                            .where("word_Types.text ='twubbles'")
                            .where('word_tweets.created_at > ?',Time.now - 1.hour)
                            .order('tweets.sentiment_score')
                            .map{|x|[x.tweet_text,x.tweet_score]}
    @sad_tweets = @tweet_text.first(@tweet_text.count/10).sample(5).map{|x| x[0]}
        
    respond_to do |f|
      f.json { render :json => @json }
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

  def techochamber
    @mentions = WordTweet.get_tech_tweets
    #binding.pry
    respond_to do |f|
      f.csv { render text: to_csv(@mentions) }
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
