class Tweet < ActiveRecord::Base
  include Twitter::Extractor
  belongs_to :scan
  has_many :word_tweets, dependent: :destroy
  has_many :words, through: :word_tweets

  def self.initialize_streaming_twitter_client
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_KEY_SECRET']
      config.access_token        = ENV['TWITTER_USER_API_KEY']
      config.access_token_secret = ENV['TWITTER_USER_API_KEY_SECRET']
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
