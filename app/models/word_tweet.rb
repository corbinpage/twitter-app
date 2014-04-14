class WordTweet < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :word
end
