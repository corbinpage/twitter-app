# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :framework_tweet, :class => 'FrameworkTweets' do
    tweet nil
    framework nil
  end
end
