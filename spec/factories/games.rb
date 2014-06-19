# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    player_id 1
    level "MyString"
    player_bet 1
    player_hand "MyString"
    dealer_hand "MyString"
    deck_sleeve "MyText"
  end
end
