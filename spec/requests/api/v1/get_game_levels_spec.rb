require 'rails_helper'

# FIXME: possible roll into game controller spec?
describe "Games Api" do
  
  #FIXME roll into rails_helper? use a for each method?
  before do
    @player = FactoryGirl.create(:player, :total_chips => 100) 
    FactoryGirl.create(:game, :id => 1, :player_id => @player.id, :level => "Beginner")  
    FactoryGirl.create(:game, :id => 2, :player_id => @player.id, :level => "Intermediate")  
    FactoryGirl.create(:game, :id => 3, :player_id => @player.id, :level => "High Roller")  
  end

  describe "Get /games/levels" do
    it "sends all game levels" do

      get "/api/v1/games/levels"

      expect(response).to be_success
      levels_response = json(response.body)
      level = levels_response[0]
      expect(level[:level]).to eq('Beginner')
      expect(level[:id]).to eq(1)
    end
  end
end
