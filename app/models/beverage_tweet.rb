class BeverageTweet < ActiveRecord::Base
  belongs_to :beverage
  belongs_to :tweet
end
