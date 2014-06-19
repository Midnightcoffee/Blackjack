require 'rails_helper'

describe "GameLevels Api" do
  describe "Get /game_levels" do
    it "sends all game levels" do

      get "/api/v1/game_levels"

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['game_levels']).to eq(['Beginner', 'Intermediate', 'High Roller'])
    end
  end
end
