class Framework < ActiveRecord::Base
  has_many :framework_tweets
  has_many :tweets, through: :framework_tweets
end
