class SomeMoreIndexes < ActiveRecord::Migration
  def change
    add_index :word_tweets, :created_at
    add_index :words, :word_type_id
    add_index :tweets, :sentiment_score
  end
end
