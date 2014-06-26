require 'factory_girl_rails'


@player = FactoryGirl.create(:player)
Game.levels.each do |level|
  FactoryGirl.create(:game, player_id: @player.id, level: level)
end


