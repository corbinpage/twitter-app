class Scan < ActiveRecord::Base
  has_many :tweets, :dependent => :destroy

  def run_twitter_stream
    @client = Tweet.initialize_streaming_twitter_client

    # Old Code, svaing as examples 
    # topics = ["newyork","coffee","tea"]
    # @client.filter(:track => topics.join(",")) do |object|

    locations = [-74,40,-73,41] #NYC Coordinates
    i = 0
    @client.filter(:locations => locations.join(",")) do |object|
      if object.is_a?(Twitter::Tweet)
        puts i.to_s + " - " + object.text
        new_tweet = parse_and_save_tweet(object)
        i += 1
      end
      # break if i >= 20
    end
  end
  handle_asynchronously :run_twitter_stream

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

    new_tweet.save
    new_tweet
  end

end
