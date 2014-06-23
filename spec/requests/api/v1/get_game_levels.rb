require 'rails_helper'

# FIXME: possible roll into game controller spec?
describe "Games Api" do
  
  #FIXME roll into rails_helper? use a for each method?
  before do
    @player = FactoryGirl.create(:player, :total_chips => 100) 
    FactoryGirl.create(:game, :player_id => @player.id, :level => "Beginner")  
    FactoryGirl.create(:game, :player_id => @player.id, :level => "Intermediate")  
    FactoryGirl.create(:game, :player_id => @player.id, :level => "High Roller")  
  end

  describe "Get /games/levels" do
    it "sends all game levels" do

      get "/api/v1/games/levels"

      expect(response).to be_success
      json = JSON.parse(response.body)
      game = json[0]
      expect(game['level']).to eq('Beginner')
      expect(game['id']).to eq(1)
    end
  end
end
