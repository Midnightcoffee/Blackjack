require 'rails_helper'


describe Api::V1::GamesController do

  #FIXME: use a parent folder to load in values for all controllers
  before do
    @player = FactoryGirl.create(:player, total_chips: 100)
    FactoryGirl.create(:game, player_id: @player.id, level: "Beginner") 
    FactoryGirl.create(:game, player_id: @player.id, level: "Intermediate") 
    FactoryGirl.create(:game, player_id: @player.id, level: "High Roller") 
  end

  describe "Get 'index'" do
    it "responds with success" do
      #TODO: make dynamic, put index in a before do block
      get :index, :player_id => @player.id
      expect(response).to be_success
    end

    it "responds with an array of games" do
      #TODO: make dynamic
      get :index, :player_id => @player.id
      games_response = json(response.body)
      expect(games_response.length).to eq(3)
    end

    #TODO: other levels
    it "responds with array containing 'Beginner' level" do
      #TODO: make dynamic
      get :index, :player_id => @player.id
      games_response = json(response.body)
      expect(games_response[0][:level]).to eq("Beginner")
    end
  end
end
