
require 'rails_helper'

RSpec.describe "get game bet", :type => :request do
  before do
    @player = FactoryGirl.create(:player, :id => 1, :total_chips => 100)
    @game = FactoryGirl.create(:game, 
                               :id => 1,
                               :player_id => @player.id, 
                               :level => "Beginner",
                               :player_bet => 0)  
  end

  describe "put player/#/games/#" do
    describe "Successful bet" do
      before do
        @params = {:game_id => @game.id, :player_bet => 20, :player_id => @player.id}.to_json 
        put "/api/v1/players/#{@player.id}/games/#{@game.id}/bet", @params, 
          { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      end

      it "responds with success" do
        #FIXME put params into a before do block? put them in a context. look into context.
        expect(response).to be_success
      end

      it "responds with 201" do
        expect(response.status).to eql(201)
      end

      it "responds with json" do
        expect(response.content_type).to eql(Mime::JSON)
      end

      it "player_hand matches database" do
        game_response = json(response.body)
        @game.reload
        expect(game_response[:player_hand]).to eql(@game.player_hand)
      end
    end
  end
end
