require 'spec_helper'

# feature 'External request' do
#   it 'queries' do
#     uri = URI('https://api.twitter.com/1.1/search/tweets.json?q=%whiskey')

#     response = Net::HTTP.get(uri)

#     expect(response).to be_an_instance_of(String)
#   end
# end

describe Scan do
	let(:tweet) { mock_model(Tweet) }

	describe 'generates an object that ...' do

		it 'is a tweet' do
			tweet = mock_model("Tweet")
			tweet.class.name.should eq("Tweet")
		end

		it 'is valid by default' do
			tweet.should be_valid
		end

		it 'is not a new record by default' do
			tweet.should_not be_new_record
		end

		it 'can be converted to a new record' do
			tweet.as_new_record.should be_new_record
		end

		it 'sets :id to nil on destroy' do
			tweet.destroy
			tweet.id.should be_nil
		end

	end

	it 'will not save nil objects' do
		twitter_object = nil
	end

	describe "#parse_and_save_tweet" do
		context 'when there is geolocation data' do
		  it "can parse and save a tweet from twitter" do
		  	geolocation = mock_model("TwitterGeo", coordinates: [40, -73])
		  	geo_tweet_characteristics = {
					full_text: "from the geo stream!", 
					created_at: Time.now,
					id: 10,
				  geo?: true,
					geo: geolocation
				}

		  	tweet_from_stream = mock_model("TwitterTweet",geo_tweet_characteristics)
		  	subject.parse_and_save_tweet(tweet_from_stream)
		  	expect(Tweet.find_by(text: "from the geo stream!")).to_not be_nil
		  end	
		end

		context 'when there is NOT geolocation data' do
		  it "can parse and save a tweet from twitter" do
		  	non_geo_tweet_characteristics = {
					full_text: "from the regular stream!", 
					created_at: Time.now,
					id: 10,
 					geo?: false
 				}

		  	tweet_from_stream = mock_model("TwitterTweet",non_geo_tweet_characteristics)
		  	subject.parse_and_save_tweet(tweet_from_stream)
		  	expect(Tweet.find_by(text: "from the regular stream!")).to_not be_nil
		  end
		end
	end
	
end