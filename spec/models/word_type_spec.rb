require 'spec_helper'

describe WordType do
  it "has many words" do
    word_type = create(:word_type)
    word_type.words << create(:word)
    expect(word_type.words.count).to eq 1
  end

  it "has many tweets" do
    word = create(:word)
    word.tweets << create(:tweet)
    word.tweets << create(:tweet)

    word_type = create(:word_type)
    word_type.words << word 
    
    expect(word_type.tweets.count).to eq 2
  end
end
