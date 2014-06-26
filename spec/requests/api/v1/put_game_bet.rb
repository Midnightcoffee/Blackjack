require 'rails_helper'

#FIXME: how should I include business logic in rpsec tests?
describe "Game Api" do
  before do
    @player = FactoryGirl.create(:player, :total_chips => 100)
    @game = FactoryGirl.create(:game, 
                               :player_id => @player.id, 
                               :level => "Beginner",
                               :player_bet => 0)  

  end

  describe "put player/#/games/#" do
    describe "Successful bet" do
      it "responds with game state information" do

        params = {:game_id => @game.id, :bet => 20, :player_id => @player.id}.to_json
        put "/api/v1/players/#{@player.id}/games/#{@game.id}/bet", params, 
          { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }


        expect(response).to be_success
        expect(response.status).to eql(201)
        expect(response.content_type).to eql(Mime::JSON)

        game = JSON.parse(response.body)
        #TODO serialize

        expect(game['player_bet']).to eql(20)
        expect(@game.player_bet).to eql(20)


      end
    end

    describe "Un-Successful bet" do
      describe "player doesn't have enough chips" do

        it "responds with error message" do
          params = {:game_id => @game.id, :bet => 200, :player_id => @player.id}.to_json
          put "/api/v1/players/#{@player.id}/games/#{@game.id}/bet", params, 
            { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

          expect(response.status).to eql(403)
          expect(response.content_type).to eql(Mime::JSON)

          game = JSON.parse(response.body)

          #TODO serialize
          expect(game['error']).to eql("Not enough chips")
          expect(@game.player_bet).to eql(0)
        end

      end
    end
  end
end
