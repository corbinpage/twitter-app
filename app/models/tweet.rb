class Tweet < ActiveRecord::Base
  include Twitter::Extractor
  belongs_to :scan
  has_many :word_tweets, dependent: :destroy
  has_many :words, through: :word_tweets

  def self.initialize_streaming_twitter_client
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key
      config.consumer_secret     = Rails.application.secrets.twitter_api_key_secret
      config.access_token        = Rails.application.secrets.twitter_user_api_key
      config.access_token_secret = Rails.application.secrets.twitter_user_api_key_secret
    end
  end

  def self.initialize_streaming_twitter_client_nyc
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key
      config.consumer_secret     = Rails.application.secrets.twitter_api_key_secret
      config.access_token        = Rails.application.secrets.twitter_user_api_key
      config.access_token_secret = Rails.application.secrets.twitter_user_api_key_secret
    end
  end

  def self.initialize_streaming_twitter_client_twubbles
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key_2
      config.consumer_secret     = Rails.application.secrets.twitter_api_key_secret_2
      config.access_token        = Rails.application.secrets.twitter_user_api_key_2
      config.access_token_secret = Rails.application.secrets.twitter_user_api_key_secret_2
    end
  end

  # def self.initialize_streaming_twitter_client_beverages
  #   client = Twitter::Streaming::Client.new do |config|
  #     config.consumer_key        = Rails.application.secrets.twitter_api_key_2
  #     config.consumer_secret     = Rails.application.secrets.twitter_api_key_secret_2
  #     config.access_token        = Rails.application.secrets.twitter_user_api_key_2
  #     config.access_token_secret = Rails.application.secrets.twitter_user_api_key_secret_2
  #   end
  # end

  def self.initialize_streaming_twitter_client_languages
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key_3
      config.consumer_secret     = Rails.application.secrets.twitter_api_key_secret_3
      config.access_token        = Rails.application.secrets.twitter_user_api_key_3
      config.access_token_secret = Rails.application.secrets.twitter_user_api_key_secret_3
    end
  end

  def self.initialize_streaming_twitter_client_tech_companies
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key_4
      config.consumer_secret     = Rails.application.secrets.twitter_api_key_secret_4
      config.access_token        = Rails.application.secrets.twitter_user_api_key_4
      config.access_token_secret = Rails.application.secrets.twitter_user_api_key_secret_4
    end
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

  def scan_for_keywords(category)
    case category
    when 'beverages'
      topics = Scan::BEVERAGE_TOPICS
    when 'twubbles'
      topics = Scan::TWUBBLE_TOPICS
    when 'languages'
      topics = Scan::LANGUAGE_TOPICS 
    when 'tech_companies'
      topics = Scan::TECH_COMPANY_TOPICS
    end

    topics.each do |term|
      if self.text.downcase.include? term
        word_obj = Word.find_by(text: term)
        if word_obj.nil?
          word_type_obj = WordType.find_or_create_by(text: category)
          word_obj = Word.create(text: term, word_type_id: word_type_obj.id)
        end

        self.words.push(word_obj)
      end
    end
  end

end
