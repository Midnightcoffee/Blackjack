require 'rails_helper'

#FIXME: how should I include business logic in rpsec tests?
describe "Game Api" do
  before do
    @player = FactoryGirl.create(:player, :total_chips => 100)
    @game = FactoryGirl.create(:game, :player_id => @player.id, :level => "Beginner")  
  end

  #Show
  describe "Get player/#/games/#" do

    #TODO: break into separate tests
    it "responds with game information" do

      get "/api/v1/players/#{@player.id}/games/#{@game.id}"
      expect(response).to be_success
      game_response = json(response.body)
      #FIXME: add other information
      expect(game_response[:level]).to eql("Beginner")
    end
  end

  #TODO: test for invalid game and invalid player.

  #Index
  describe "Get player/1/games/" do

    #TODO break into separate tests
    it "responds with array of player's games" do

      get "/api/v1/players/#{@player.id}/games/"
      expect(response).to be_success
      games_response = json(response.body)
      expect(games_response.count).to eql(@player.games.count)
    end
  end
end
