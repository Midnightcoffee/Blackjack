require 'rails_helper'

#FIXME: how should I include business logic in rpsec tests?
describe "Game Api" do
  before do
    @player = FactoryGirl.create(:player, :total_chips => 100)
    @game = FactoryGirl.create(:game, :player_id => @player.id, :level => "Beginner")  
  end



  #TODO: how to do this?

  #Show
  describe "Get player/#/games/#" do

    it "responds with game level" do

      get "/api/v1/players/#{@player.id}/games/#{@game.id}"
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['level']).to eql("Beginner")

    end
  end

    #
  describe "Get player/1/games/" do

    it "responds with game level" do

      get "/api/v1/players/#{@player.id}/games/"
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eql(@player.games.count)

    end
  end
    # describe "if making a bet" do

    #   describe "successful bet" do

    #     it "responds with current bet amount" do


    #     get "/api/v1/players/#{@player.id}/games/#{@game.id}/bet"
          
    #       expect(response).to be_success
    #       json = JSON.parse(response.body)
    #     end
    #   end
    # end
end
