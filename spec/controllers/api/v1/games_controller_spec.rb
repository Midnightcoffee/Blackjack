require 'rails_helper'


describe Api::V1::GamesController do

  #FIXME: use a parent folder to load in values for all controllers
  before do
    @player = FactoryGirl.create(:player, total_chips: 100)
    FactoryGirl.create(:game, player_id: @player.id, level: "Beginner") 
    FactoryGirl.create(:game, player_id: @player.id, level: "Intermediate") 
  end

  describe "Get 'index'" do
    it "returns success" do
      #TODO: make dynamic, put index in a before do block
      get :index, :player_id => @player.id
      expect(response).to be_success
    end

    it "contains an array of games" do
      #TODO: make dynamic
      get :index, :player_id => @player.id
      games = JSON.parse(response.body)
      expect(games.length).to eq(2)
    end

    it "the first game level is Beginner" do
      #TODO: make dynamic
      get :index, :player_id => @player.id
      games = JSON.parse(response.body)
      expect(games[0]["level"]).to eq("Beginner")
    end
  end
end
