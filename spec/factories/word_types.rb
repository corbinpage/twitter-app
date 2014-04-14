# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :word_type do
    text "MyString"
    index "MyText"
  end
end
