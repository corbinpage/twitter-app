require 'spec_helper'

describe Tweet do

	it "has fields" do
		tweet = create(:tweet)
		expect(tweet.text).to be_an_instance_of(String)
	end

	it "can have words" do
		tweet = create(:tweet, :text => "Woe is me!")
		tweet.scan_for_keywords("twubbles")
		expect(tweet.words.first.text).to eq("woe")
	end

  describe "#self.initialize_streaming_twitter_client_nyc" do
    it "creates a twitter streaming client" do
      client = Tweet.initialize_streaming_twitter_client_nyc
      expect(client).to be_an_instance_of(Twitter::Streaming::Client)
    end
  end

  describe "#self.initialize_streaming_twitter_client_twubbles" do
    it "creates a twitter streaming client" do
      client = Tweet.initialize_streaming_twitter_client_twubbles
      expect(client).to be_an_instance_of(Twitter::Streaming::Client)
    end
  end

  describe "#self.initialize_streaming_twitter_client_languages" do
    it "creates a twitter streaming client" do
      client = Tweet.initialize_streaming_twitter_client_languages
      expect(client).to be_an_instance_of(Twitter::Streaming::Client)
    end
  end

  describe "#self.initialize_streaming_twitter_client_tech_companies" do
    it "creates a twitter streaming client" do
      client = Tweet.initialize_streaming_twitter_client_tech_companies
      expect(client).to be_an_instance_of(Twitter::Streaming::Client)
    end
  end

  describe "#scan_for_keywords" do
    it "can find twubbles keywords" do
      twubbled_tweet = create(:tweet, text: "singin the blues")
      blues = create(:word, text: "blues")
      twubbled_tweet.scan_for_keywords(:twubbles)
      expect(twubbled_tweet.words).to include(blues)
    end

    it "can find tech company keywords" do
      techy_tweet = create(:tweet, text: "google it")
      google = create(:word, text: "google")
      techy_tweet.scan_for_keywords(:tech_companies)
      expect(techy_tweet.words).to include(google)
    end

    it "can make new keywords if they are not yet defined" do
      twubbled_tweet = create(:tweet, text: "singin the blues")
      twubbled_tweet.scan_for_keywords(:twubbles)
      blues = Word.find_by(text: "blues")
      expect(twubbled_tweet.words).to include(blues)
    end
  end

  describe "#score_sentimentality" do
    it "sets the sentiment score for a tweet" do
      sad_tweet = Tweet.create(text: "woe is me")
      expect(sad_tweet.sentiment_score).to eq nil
      sad_tweet.score_sentimentality
      expect(sad_tweet.sentiment_score).to eq -0.5
    end

    it "sets the sentiment summary for a tweet" do
      sad_tweet = Tweet.create(text: "life is great!")
      expect(sad_tweet.sentiment_summary).to eq nil
      sad_tweet.score_sentimentality
      expect(sad_tweet.sentiment_summary).to eq :positive
    end
  end

  describe "#record_geolocation" do
    it "adds lat and lng to a tweet" do
      nyc_tweet = create(:tweet, lat: nil, lng: nil)
      twitter_geo = mock_model("TwitterGeo", coordinates: [40, -73])
      twitter_tweet = mock_model("TwitterTweet", geo?: true, geo: twitter_geo)
      nyc_tweet.record_geolocation(twitter_tweet)
      expect(nyc_tweet.lat).to eq 40
      expect(nyc_tweet.lng).to eq -73
    end
  end
end