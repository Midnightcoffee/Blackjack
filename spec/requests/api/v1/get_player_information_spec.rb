require 'rails_helper'

describe "Players Api" do


  describe "Get /players/#" do

    it "sends chip stack" do
      @player = FactoryGirl.create(:player)

      get "/api/v1/players/#{@player.id}"

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['total_chips']).to eq(@player.total_chips)
    end
  end
end
