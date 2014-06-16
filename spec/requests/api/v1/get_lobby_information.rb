require 'rails_helper'

describe "Lobby Api" do
  FactoryGirl.create(:player)

  describe "Get /lobby" do


        
    it "sends a levels and players chip stack" do

      get '/api/v1/lobby'

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['level']).to eq('Beginner')
      expect(json['total_chips']).to eq(100)
    end
  end
end
