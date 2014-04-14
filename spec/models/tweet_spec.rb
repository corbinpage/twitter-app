require 'spec_helper'

describe Tweet do
	context "has beverage in text" do
  	it "can identify beverage tweets" do
  		tweet = create(:tweet, :text => "Beer!")
  		beverage_list = Scan::TWITTER_NYC_BEVERAGE_TOPICS
  		tweet.scan_for_beverages(beverage_list)
  		beer = Beverage.find_by(text: "beer")
  		expect(tweet.beverages).to include(beer)
  	end
  end

	context "does not have beverage in text" do

	end

end
