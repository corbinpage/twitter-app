class CreateBeverageTweets < ActiveRecord::Migration
  def change
    create_table :beverage_tweets do |t|
      t.references :beverage, index: true
      t.references :tweet, index: true

      t.timestamps
    end
  end
end
