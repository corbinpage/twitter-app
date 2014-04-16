class WordTweet < ActiveRecord::Base

  belongs_to :tweet
  belongs_to :word

  def self.get_tech_tweets
  	self.joins(word: :word_type).
  	select("words.text as company, word_tweets.created_at as date,count(word_tweets.id) as mentions").
  	where("word_Types.text ='tech_companies'").
  	group('company,date').map{|x|[x.company,x.date,x.mentions]}
  end

  # def extract_company_data
  # 	[self.company, self.date, self.mentions]
  # end

end
