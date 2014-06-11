require 'rails_helper'

# TODO: better description

describe Api::V1::LevelsController do

  describe "Get /levels" do
    it 'sends a list of levels' do

      get '/api/v1/levels'

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['levels'].length).to eq(1)   
    end
  end
end
