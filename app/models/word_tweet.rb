class WordTweet < ActiveRecord::Base

  belongs_to :tweet
  belongs_to :word

  # def self.last_10k
  #   self.order('word_tweets.id DESC').limit(10000)
  # end

  def self.tech_tweets
  	self.joins(word: :word_type).
  	select("words.text as company, to_char(word_tweets.created_at, 'DD-MM-YYYY HH12:MI') as date,count(word_tweets.id) as mentions").
    limit(1000).
    order('date DESC').
  	where("word_types.text ='tech_companies'").
  	group('company,date').map{|x|[x.company, x.date, x.mentions]}
  end

end