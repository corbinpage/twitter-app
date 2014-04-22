class Word < ActiveRecord::Base
  has_many    :word_tweets
  has_many    :tweets, through: :word_tweets
  belongs_to  :word_type

  def self.recent_sad_words
    joins(:word_type)
      .joins(:word_tweets)
      .where("word_types.text = 'twubbles'")
      .where('word_tweets.created_at > ?',Time.now - 10.seconds)
      .group('words.text')
      .count
      .map{|k,v| [{'name'=> k,'size'=> v}]}
      .flatten
  end
end
