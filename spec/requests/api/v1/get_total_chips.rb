require 'rails_helper'

describe "TotalChips Api" do


  describe "Get /total_chips" do


    it "sends players chip stack" do
      #TODO: how to move this to a higher scope
      @player = FactoryGirl.create(:player)

      get "/api/v1/total_chips/#{@player.id}"

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['total_chips']).to eq(@player.total_chips)
    end
  end
end
