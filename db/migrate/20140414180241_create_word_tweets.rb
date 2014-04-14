class CreateWordTweets < ActiveRecord::Migration
  def change
    create_table :word_tweets do |t|
      t.references :tweet, index: true
      t.references :word, index: true

      t.timestamps
    end
  end
end
