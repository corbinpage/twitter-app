class Tweet < ActiveRecord::Base
  include Twitter::Extractor
  belongs_to :scan
  has_many :beverage_tweets
  has_many :beverages, through: :beverage_tweets
  # has_many :word_tweets
  # has_many :words, through: :word_tweets
  # has_many :mention_tweets
  # has_many :mentions, through: :mention_tweets
  # has_many :hashtag_tweets
  # has_many :hashtags, through: :hashtag_tweets
  # has_many :link_tweets
  # has_many :links, through: :link_tweets

  def self.initialize_streaming_twitter_client
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_KEY_SECRET']
      config.access_token        = ENV['TWITTER_USER_API_KEY']
      config.access_token_secret = ENV['TWITTER_USER_API_KEY_SECRET']
    end
  end

  def count_obscenities
    dirty_words = Obscenity.offensive(self.text)
    if(dirty_words.count > 0)
      self.score = dirty_words.count
      self.get_tweet_html
      dirty_words.each do |w|
        self.words.push(Word.find_or_create_by(text: w))
      end
    else
      self.score = 0
    end
    return self.score
  end

  def score_sentimentality(sentiment_analyzer)
    self.sentiment_summary = sentiment_analyzer.get_sentiment(self.text)
    self.sentiment_score = sentiment_analyzer.get_score(self.text)
  end

  def record_geolocation(geo)
    self.lat = geo.coordinates[0]
    self.lng = geo.coordinates[1]
    # self.country = get_country_name(self.lat, self.lng)
    true
  end

  # def get_country_name(lat, lng)
  #   search_string = "#{lat},#{lng}"
  #   search_results = Geocoder.search(search_string).first.data['address_components']
  #   country = search_results.select do |country_data|
  #     country_data['types'].first=='country'
  #   end
  #     country.first['long_name']
  # end

  def start_twitter_text_scan
    # Extract Mentions
    extract_mentioned_screen_names(self.text).each do |w|
      self.mentions.push(Mention.find_or_create_by(text: w))
    end

    # Extract Links
    extract_urls(self.text).each do |w|
      self.links.push(Link.find_or_create_by(text: w))
    end

    # Extract Hashtags
    extract_hashtags(self.text).each do |w|
      self.hashtags.push(Hashtag.find_or_create_by(text: w))
    end
  end

  def obscenity_count
    self.obscenities.count
  end

  def risque_string=(name_arr)
    @risque_string = name_arr.join(', ')
  end

  def risque_string
    @risque_string
  end

  def get_tweet_html
    begin
      tweet = Tweet.client.oembed(self.twitter_id)
      self.html = tweet.html.gsub(/<script(.*?)$/,'') # Trims everything after the s cript tag
      puts "Tweet scanned"
    rescue
      puts "Tweet scan fail"
    end
  end

  def scan_for_beverages
    Scan::TWITTER_NYC_BEVERAGE_TOPICS.each do |bev_text|
      if self.text.include? bev_text
        bev = Beverage.find_or_create_by(text: bev_text)
        self.beverages.push(bev)
      end
    end
  end

  def scan_for_frameworks
    Scan::FRAMEWORK_TOPICS.each do |framework|
      if self.text.include? framework
        framework_obj = Framework.find_or_create_by(text: framework)
        self.frameworks.push(framework_obj)
      end
    end
  end

end
