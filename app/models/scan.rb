class Scan < ActiveRecord::Base
  has_many :tweets, :dependent => :destroy

  NYC_COORDS = [-74,40,-73,41] #NYC Coordinates
  NYC_LOCATION = NYC_COORDS.join(",")
  TRACK_TWUBBLES = WordType::TWUBBLE_TOPICS.join(",")
  TRACK_TECH_COMPANIES = WordType::TECH_COMPANY_TOPICS.join(",")

  def run_twitter_stream_nyc
    @client = Tweet.initialize_streaming_twitter_client(:nyc)
    start_stream(:nyc, @client, locations: NYC_LOCATION)
  end

  def run_twitter_stream_twubbles
    @client = Tweet.initialize_streaming_twitter_client(:twubbles)
    start_stream(:twubbles, @client, locations: NYC_LOCATION, track: TRACK_TWUBBLES)
  end

  def run_twitter_stream_tech_companies
    @client = Tweet.initialize_streaming_twitter_client(:tech_companies)
    start_stream(:tech_companies, @client, locations: NYC_LOCATION, track: TRACK_TECH_COMPANIES)
  end

  def start_stream(stream, client, filter)
    client.filter(filter) do |tweet|
      if tweet.is_a?(Twitter::Tweet)
        puts "Tweet from #{stream}: #{tweet.id}"
        safely_parse_tweet(tweet)
      end
    end
  end

  def safely_parse_tweet(tweet)
    begin
      parse_and_save_tweet(tweet)
    rescue
    end
  end

  def parse_and_save_tweet(twitter_object)
    return if twitter_object.nil?

    new_tweet = Tweet.new_from_twitter(self.id, twitter_object)
    new_tweet.record_geolocation(twitter_object)
    new_tweet.score_sentimentality
    new_tweet.scan_for_keywords(self.category) unless self.category == 'nyc'

    new_tweet.save
    return new_tweet
  end

end
