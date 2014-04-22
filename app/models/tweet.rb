class Tweet < ActiveRecord::Base
  include Twitter::Extractor
  belongs_to :scan
  has_many :word_tweets, dependent: :destroy
  has_many :words, through: :word_tweets

  STREAM_API_SECRETS = {
    nyc: '',
    twubbles: '_2',
    languages: '_3',
    tech_companies: '_4'
  }

  def self.new_from_twitter(scan_id, twitter_object)
    new(text: twitter_object.full_text,
        tweet_time: twitter_object.created_at,
        twitter_id: twitter_object.id,
        scan_id: scan_id)
  end

  def self.initialize_streaming_twitter_client(stream)
    client = Twitter::Streaming::Client.new do |config|
      secret = STREAM_API_SECRETS[stream]
      config.consumer_key        = Rails.application.secrets.send("twitter_api_key#{secret}")
      config.consumer_secret     = Rails.application.secrets.send("twitter_api_key_secret#{secret}")
      config.access_token        = Rails.application.secrets.send("twitter_user_api_key#{secret}")
      config.access_token_secret = Rails.application.secrets.send("twitter_user_api_key_secret#{secret}")
    end
  end

  def self.initialize_streaming_twitter_client_nyc
    initialize_streaming_twitter_client(:nyc)
  end

  def self.initialize_streaming_twitter_client_twubbles
    initialize_streaming_twitter_client(:twubbles)
  end

  def self.initialize_streaming_twitter_client_languages
    initialize_streaming_twitter_client(:languages)
  end

  def self.initialize_streaming_twitter_client_tech_companies
    initialize_streaming_twitter_client(:tech_companies)
  end

  def score_sentimentality(sentiment_analyzer = Sentimental.new)
    self.sentiment_summary = sentiment_analyzer.get_sentiment(self.text)
    self.sentiment_score = sentiment_analyzer.get_score(self.text)
  end

  def record_geolocation(twitter_object)
    if twitter_object.geo?
      self.lat = twitter_object.geo.coordinates[0]
      self.lng = twitter_object.geo.coordinates[1]
      self.has_geo = true
    else
      self.has_geo = false
    end
  end

  def scan_for_keywords(category)
    case category.to_s
    when 'twubbles'
      add_topics_from_category(twubble_topics, category)
    when 'tech_companies'
      add_topics_from_category(tech_company_topics, category)
    else
      return nil
    end
    
  end

  def twubble_topics
    WordType::TWUBBLE_TOPICS.select do |topic| 
      self.text.downcase.include? topic
    end
  end

  def tech_company_topics
    WordType::TECH_COMPANY_TOPICS.select do |topic| 
      self.text.downcase.include? topic
    end
  end

  def add_topics_from_category(topics, category)
    topics.each do |term|
      
      unless word_obj = Word.find_by(text: term)
        word_type_obj = WordType.find_or_create_by(text: category)
        word_obj = Word.create(text: term, word_type_id: word_type_obj.id)
      end

      self.words << word_obj
    end
  end
end