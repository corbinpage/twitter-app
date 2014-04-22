class Word < ActiveRecord::Base
  has_many    :word_tweets
  has_many    :tweets, through: :word_tweets
  belongs_to  :word_type

  def self.recent_sad_words
    joins(:tweets).where(text: 'twubbles')
      .where('tweets.created_at > ?',Time.now - 10.seconds)
      .group('words.text')
      .count
      .map{|k,v| [{'name'=> k,'size'=> v}]}
      .flatten
  end
end
