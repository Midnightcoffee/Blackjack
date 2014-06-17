require 'rails_helper'

describe "Lobby Api" do
  FactoryGirl.create(:game)

  describe "Get /game" do

    it "sends game state information" do

      get '/api/v1/game'

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['player_hand']).to be_truthy
      #TODO logic for bet might be better off somewhere else
    end
  end
end
