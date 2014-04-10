class Beverage < ActiveRecord::Base
  has_many :beverage_tweets
  has_many :tweets, through: :beverage_tweets
end
