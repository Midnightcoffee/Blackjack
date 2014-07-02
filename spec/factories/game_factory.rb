FactoryGirl.define do
  factory :game do
    player_id 1
    level "Beginner"
    player_bet 0
    player_hand ""
    dealer_hand ""
    deck_sleeve "Diamond,Jack|Heart,5|Heart,7|Diamond,Ace|Heart,Ace|Heart,9|Spade,Ace|Spade,10|Heart,7|Spade,2|Spade,4|Spade,10|Heart,9|Heart,8|Heart,7|Heart,6|Heart,5|Club,5|Diamond,10|Diamond,5|Diamond,Jack|"
    message "Place bet to play!"
    min_bet 1
    max_bet 50
  end
end
