#require 'factory_girl_rails'


# @player = FactoryGirl.create(:player, total_chips: 100, id: 1)
# FactoryGirl.create(:game, player_id: @player.id, level: "Beginner", min_bet: 1, max_bet: 50)
# FactoryGirl.create(:game, player_id: @player.id, level: "Intermediate", min_bet: 50, max_bet: 100)
# FactoryGirl.create(:game, player_id: @player.id, level: "High Roller", min_bet: 100, max_bet: nil)

@player = Player.create(id: 1, total_chips: 100, level: 1)
Game.create(player_id: player_bet: 0, @player.id, level: "Beginner", min_bet: 1, max_bet: 50, deck_sleeve: "Diamond,Jack|Heart,5|Heart,7|Diamond,Ace|Heart,Ace|Heart,9|Spade,Ace|Spade,10|Heart,7|Spade,2|Spade,4|Spade,10|Heart,9|Heart,8|Heart,7|Heart,6|Heart,5|Club,5|Diamond,10|Diamond,5|Diamond,Jack|")
Game.create(player_id: player_bet: 0, @player.id, level: "Intermediate", min_bet: 50, max_bet: 100, deck_sleeve: "Diamond,Jack|Heart,5|Heart,7|Diamond,Ace|Heart,Ace|Heart,9|Spade,Ace|Spade,10|Heart,7|Spade,2|Spade,4|Spade,10|Heart,9|Heart,8|Heart,7|Heart,6|Heart,5|Club,5|Diamond,10|Diamond,5|Diamond,Jack|")
Game.create(player_id: player_bet: 0, @player.id, level: "High Roller", min_bet: 100, max_bet: nil, deck_sleeve: "Diamond,Jack|Heart,5|Heart,7|Diamond,Ace|Heart,Ace|Heart,9|Spade,Ace|Spade,10|Heart,7|Spade,2|Spade,4|Spade,10|Heart,9|Heart,8|Heart,7|Heart,6|Heart,5|Club,5|Diamond,10|Diamond,5|Diamond,Jack|")


