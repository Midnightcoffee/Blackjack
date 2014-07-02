require 'rails_helper'


describe Api::V1::GamesController do

  #FIXME: use a parent folder to load in values for all controllers
  before do
    @player = FactoryGirl.create(:player, total_chips: 100, id: 1)
    @game = FactoryGirl.create(:game, player_id: @player.id, level: "Beginner", player_bet: 20) 
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
      expect(games_response.length).to eql(3)
    end

    #TODO: other levels
    it "responds with array containing 'Beginner' level" do
      #TODO: make dynamic
      get :index, :player_id => @player.id
      games_response = json(response.body)
      expect(games_response[0][:level]).to eql("Beginner")
    end

  end

  describe "Get 'show'" do
    it "responds with success" do
      #TODO: make dynamic, put index in a before do block
      get :show, :player_id => @player.id, :id => @game.id
      expect(response).to be_success
    end

    it "Beginner" do
      get :show, :player_id => @player.id, :id => @game.id
      game_response = json(response.body)
      expect(game_response[:level]).to eql("Beginner")
    end

    it "player_bet" do
      get :show, :player_id => @player.id, :id => @game.id
      game_response = json(response.body)
      expect(game_response[:player_bet]).to eql(20)
    end

    #TODO: other levels
    it "Won't contain deck_sleeve" do
      #TODO: make dynamic
      get :show, :player_id => @player.id, :id => @game.id
      game_response = json(response.body)
      expect(game_response[:deck_sleeve]).to eql(nil)
    end

  end

  describe "Get 'levels'" do
    #TODO: break into have and don't have?
    it "responds with success" do
      #TODO: make dynamic, put index in a before do block
      get :levels
      expect(response).to be_success
    end

    it "Beginner" do
      get :levels
      levels_response = json(response.body)
      expect(levels_response[0][:level]).to eql("Beginner")
    end

    it "has player_bet" do
      get :levels
      levels_response = json(response.body)
      expect(levels_response[0][:player_bet]).to eql(20)
    end

    it "Intermediate" do
      get :levels
      levels_response = json(response.body)
      expect(levels_response[1][:level]).to eql("Intermediate")
    end

    it "doesn't have player_bet" do
      get :levels
      levels_response = json(response.body)
      expect(levels_response[1][:player_bet]).to eql(0)
    end

    it "Won't contain deck_sleeve" do
      #TODO: make dynamic
      get :levels
      levels_response = json(response.body)
      expect(levels_response[0][:deck_sleeve]).to eql(nil)
    end

  end

end
