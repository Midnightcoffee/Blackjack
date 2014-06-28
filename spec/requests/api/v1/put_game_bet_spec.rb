require 'rails_helper'

#FIXME: how should I include business logic in rpsec tests?
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

        @game.reload
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
      
      it "responds with the amount the player put" do
        #FIXME factor out?
        game_response = json(response.body)
        @game.reload
        expect(game_response[:player_bet]).to eql(20)
      end

      it "responds with the same amount as the players_bet in database" do
        game_response = json(response.body)
        @game.reload
        expect(game_response[:player_bet]).to eql(@game.player_bet)
      end

      it "responds with player_hand" do
        game_response = json(response.body)
        @game.reload
        expect(game_response[:player_hand]).to eql(@game.player_hand)
      end
    end

    describe "Un-Successful bet" do
      before do
        @params = {:game_id => @game.id, :player_bet => 200, :player_id => @player.id}.to_json  
        put "/api/v1/players/#{@player.id}/games/#{@game.id}/bet", @params, 
          { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      end
      #TODO break up tests
      describe "player doesn't have enough chips" do

        it "responds with 403 status" do
          #TODO refactor out params into before block for un-Successful bet
          expect(response.status).to eql(403)
        end

        it "responds with Json" do
          expect(response.content_type).to eql(Mime::JSON)
        end

        it "responds with TODO: nil in player_bet" do
          #TODO: what should it equal?
          game_response = json(response.body)
          @game.reload
          expect(game_response[:player_bet]).to eql(nil)
        end
      end
    end
  end
end
