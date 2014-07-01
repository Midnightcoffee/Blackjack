require 'rails_helper'

RSpec.describe "put player/1/games/1/stand", :type => :request do
  before do
    @player = FactoryGirl.create(:player, :id => 1, :total_chips => 100)
    @game = FactoryGirl.create(:game, 
                               :id => 1,
                               :player_id => @player.id, 
                               :level => "Beginner",
                               :player_bet => 30)  
  end

  describe "Successful" do
    before do
      put "/api/v1/players/#{@player.id}/games/#{@game.id}/stand", 
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
    end

    it "responds with success" do
      #FIXME put params into a before do block? put them in a context. look into context.
      expect(response).to be_success
    end

    it "responds with 201" do
      #FIXME: is this the right status code?
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

    it "player hand" do
      game_response = json(response.body)
      @game.reload
      expect(game_response[:player_hand]).to eql("")
    end

    it "dealer hand" do
      game_response = json(response.body)
      @game.reload
      expect(game_response[:dealer_hand]).to eql("Diamond,Jack|Diamond,5|Diamond,10|")
    end

    it "player bet" do
      game_response = json(response.body)
      @game.reload
      expect(game_response[:player_bet]).to eql(0)
    end
  end
end
