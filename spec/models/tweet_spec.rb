require 'spec_helper'

describe Tweet do

	it "has fields" do
		tweet = create(:tweet)
		expect(tweet.text).to be_an_instance_of(String)
	end

	it "can have words" do
		tweet = create(:tweet, :text => "beer!")
		tweet.scan_for_keywords("beverages")
		expect(tweet.words.first.text).to eq("beer")
	end


end
