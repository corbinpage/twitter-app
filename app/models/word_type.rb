class WordType < ActiveRecord::Base
  has_many :words
  has_many :tweets, through: :words
end
