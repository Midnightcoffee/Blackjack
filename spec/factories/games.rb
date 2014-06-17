# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    player_id 1
    player_bet 10
    player_hand "Spade,10|Spade, Ace"
    dealer_hand "Heart, Ace|Heart, 10"
    deck_sleeve "TODO"
  end
end
