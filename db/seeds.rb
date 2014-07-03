#require 'factory_girl_rails'


# @player = FactoryGirl.create(:player, total_chips: 100, id: 1)
# FactoryGirl.create(:game, player_id: @player.id, level: "Beginner", min_bet: 1, max_bet: 50)
# FactoryGirl.create(:game, player_id: @player.id, level: "Intermediate", min_bet: 50, max_bet: 100)
# FactoryGirl.create(:game, player_id: @player.id, level: "High Roller", min_bet: 100, max_bet: nil)

@player = Player.create(id: 1, total_chips: 100)
Game.create(player_id: @player.id, level: "Beginner", min_bet: 1, max_bet: 50, deck_sleeve: "Heart,Ace|")
Game.create(player_id: @player.id, level: "Intermediate", min_bet: 50, max_bet: 100,deck_sleeve: "Heart,Ace|")
Game.create(player_id: @player.id, level: "High Roller", min_bet: 100, max_bet: nil,deck_sleeve: "Heart,Ace|")


