require 'rails_helper'

describe "Levels Api" do

  describe "Get /levels" do
    it 'sends a list of levels' do

      get '/api/v1/levels'

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.length).to eq(1)
    end
  end
end
