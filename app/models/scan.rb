class Scan < ActiveRecord::Base
  has_many :tweets, :dependent => :destroy

  TWITTER_NYC_BEVERAGE_TOPICS = ["coffee","tea","beer","wine", "red bull","coca-cola", "whiskey", "gatorade", "orangina", "fanta"]
  FRAMEWORK_TOPICS = ["Ruby on Rails","Node.js","jQuery","PHP"]


  def run_twitter_stream_nyc_beverages
    @client = Tweet.initialize_streaming_twitter_client

    # Old Code, saving as examples
    # topics = ["newyork","coffee","tea"]
    # @client.filter(:track => topics.join(",")) do |object|

    topics = TWITTER_NYC_BEVERAGE_TOPICS
    locations = [-74,40,-73,41] #NYC Coordinates
    @client.filter(:locations => locations.join(","),:track => topics.join(",")) do |object|
      if object.is_a?(Twitter::Tweet)
        new_tweet = parse_and_save_tweet(object)
      end
    end
  end
  handle_asynchronously :run_twitter_stream_nyc_beverages

  def run_twitter_stream_nyc
    @client = Tweet.initialize_streaming_twitter_client

    locations = [-74,40,-73,41] #NYC Coordinates
    @client.filter(:locations => locations.join(",")) do |object|
      if object.is_a?(Twitter::Tweet)
        new_tweet = parse_and_save_tweet(object)
      end
    end
  end
  handle_asynchronously :run_twitter_stream_nyc

  def run_twitter_stream_frameworks
    @client = Tweet.initialize_streaming_twitter_client

    topics = FRAMEWORK_TOPICS
    @client.filter(:track => topics.join(",")) do |object|
      if object.is_a?(Twitter::Tweet)
        new_tweet = parse_and_save_tweet(object)
      end
    end
  end
  handle_asynchronously :run_twitter_stream_frameworks


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

    # Find popular links - instagram, twitpic
    # Find all people mentioned
    # Common words used

    if self.category == "nyc_beverages"
      new_tweet.scan_for_beverages
    end

    if self.category == "frameworks"
      new_tweet.scan_for_frameworks
    end

    new_tweet.save
    new_tweet
  end

end
