require 'spec_helper'

describe Tweet do

	it "has fields" do
		tweet = create(:tweet)
		expect(tweet.text).to be_an_instance_of(String)
	end

	it "can have words" do
		tweet = create(:tweet, :text => "Woe is me!")
		tweet.scan_for_keywords("twubbles")
		expect(tweet.words.first.text).to eq("woe")
	end


end
