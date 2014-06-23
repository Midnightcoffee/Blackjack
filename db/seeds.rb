require 'factory_girl_rails'


@player = FactoryGirl.create(:player)
['Beginner', 'Intermediate', 'High Roller'].each do |level|
  FactoryGirl.create(:game, player_id: @player.id, level: level)
end


