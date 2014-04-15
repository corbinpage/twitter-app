class Scan < ActiveRecord::Base
  has_many :tweets, :dependent => :destroy

  BEVERAGE_TOPICS = ["coffee","tea","beer","wine", "red bull","coca-cola", "whiskey", "gatorade", "orangina", "fanta"]
  LANGUAGE_TOPICS = ["ruby", "php", "java", "python", "javascript"]
  TECH_COMPANY_TOPICS = ["google","apple","microsoft","facebook","amazon"]
  VENTURE_CAPITAL_TOPICS = ["union square"]

  def run_twitter_stream_nyc
    @client = Tweet.initialize_streaming_twitter_client_nyc

    locations = [-74,40,-73,41] #NYC Coordinates
    @client.filter(:locations => locations.join(",")) do |object|
      if object.is_a?(Twitter::Tweet)
        puts object.text
        begin
          new_tweet = parse_and_save_tweet(object)
        rescue
        end
      end
    end
  end

  def run_twitter_stream_beverages
    @client = Tweet.initialize_streaming_twitter_client_beverages

    topics = BEVERAGE_TOPICS
    locations = [-74,40,-73,41] #NYC Coordinates
    @client.filter(:locations => locations.join(","),:track => topics.join(",")) do |object|
      if object.is_a?(Twitter::Tweet)
        puts object.text
        begin
          new_tweet = parse_and_save_tweet(object)
        rescue
        end
      end
    end
  end

  def run_twitter_stream_languages
    @client = Tweet.initialize_streaming_twitter_client_languages

    topics = LANGUAGE_TOPICS
    locations = [-74,40,-73,41] #NYC Coordinates
    @client.filter(:locations => locations.join(","),:track => topics.join(",")) do |object|
      if object.is_a?(Twitter::Tweet)
        puts object.text
        begin
          new_tweet = parse_and_save_tweet(object)
        rescue
        end
      end
    end
  end

  def run_twitter_stream_tech_companies
    @client = Tweet.initialize_streaming_twitter_client_tech_companies

    topics = TECH_COMPANY_TOPICS
    locations = [-74,40,-73,41] #NYC Coordinates
    @client.filter(:locations => locations.join(","),:track => topics.join(",")) do |object|
      if object.is_a?(Twitter::Tweet)
        puts object.text
        begin
          new_tweet = parse_and_save_tweet(object)
        rescue
        end
      end
    end
  end


  def parse_and_save_tweet(twitter_object)
    return if twitter_object.nil?

    sentiment_analyzer = Sentimental.new

    # Create Tweet Objects
    new_tweet = Tweet.new(text: twitter_object.full_text,
                          tweet_time: twitter_object.created_at,
                          twitter_id: twitter_object.id,
                          scan_id: self.id)

    # Set geolocation if applicable
    new_tweet.has_geo = twitter_object.geo? ? new_tweet.record_geolocation(twitter_object.geo) : false

    # Scan for Sentimentality
    new_tweet.score_sentimentality(sentiment_analyzer)

    # Scan for Obscenities
    #new_tweet.count_obscenities

    # Scan for Hashtags, Mentions, and Links
    #new_tweet.start_twitter_text_scan
 
    # Scan for any keywords
    new_tweet.scan_for_keywords(self.category) unless self.category == 'nyc'

    new_tweet.save
    new_tweet
  end

end
