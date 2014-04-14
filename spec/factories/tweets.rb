FactoryGirl.define do
  factory :tweet do
    sequence(:text) { |n| "My text #{n}"}
    sequence(:twitter_id) { |n| "#{n}#{n}#{n}" }
    tweet_time Time.now
    sequence(:score) { |n| n }
    sequence(:scan_id) { |n| n }
    sequence(:sentiment_score) { |n| (n.to_f)/3.14 }
    sentiment_summary { ['positive', 'negative', 'neutral'].sample }
    html { "t.co/#{twitter_id}".downcase }
    sequence(:created_at) { |n| Time.now - n.minutes }
    updated_at { |t| t.created_at }
    has_geo true
    lat 40.47
    lng -73.94
    country "United States"
  end
end