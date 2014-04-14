require_relative '../feature_helper'

describe "Homepage" do
  it 'returns a 200' do
    visit '/' do
    	it { should respond_with 200 }
    end
  end

 # describe "update" do
 # 	it 'adds a tweet if none exists' do
 # 		# FactoryGirl.create_list(:tweet, 10)

 # 		tweet = create(:tweet)
 # 		expect()
 # 	end
 # end
end