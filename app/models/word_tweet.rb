class WordTweet < ActiveRecord::Base

  belongs_to :tweet
  belongs_to :word

  def self.tech_tweets
  	self.joins(word: :word_type).
    	select("words.text as company, to_char(word_tweets.created_at, 'DD-MM-YYYY HH12:MI') as date,count(word_tweets.id) as mentions").
      limit(1000).
      order('date DESC').
    	where("word_types.text ='tech_companies'").
    	group('company,date').map{|x|[x.company, x.date, x.mentions]}
  end

  def self.recent_sad_tweets
    self.joins(:tweet)
      .joins(word: :word_type)
      .where("word_Types.text ='twubbles'")
      .where('word_tweets.created_at > ?',Time.now - 1.hour)
      .where('tweets.sentiment_score < ?',0)
      .limit(5)
      .order("RANDOM()")
      .pluck('tweets.text')
  end

end