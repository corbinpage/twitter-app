class CreateFrameworkTweets < ActiveRecord::Migration
  def change
    create_table :framework_tweets do |t|
      t.references :tweet, index: true
      t.references :framework, index: true

      t.timestamps
    end
  end
end
