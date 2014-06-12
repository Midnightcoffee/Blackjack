require 'rails_helper'

describe "Lobby Api" do

  describe "Get /lobby" do


    it "sends a levels and players chip stack" do

      get '/api/v1/lobby'

      expect(response).to be_success
      json = JSON.parse(response.body)
      json['levels'] = 'Beginner'
      json['totalChips'] = '0'
    end
  end
end
