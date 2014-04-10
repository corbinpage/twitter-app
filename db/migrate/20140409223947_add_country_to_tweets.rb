class AddCountryToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :country, :string
  end
end
