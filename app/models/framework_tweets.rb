class FrameworkTweets < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :framework
end
