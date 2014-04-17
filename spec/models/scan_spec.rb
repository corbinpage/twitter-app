require 'spec_helper'
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

		it 'breaks' do
			raise "not today"
		end
		
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
	
end