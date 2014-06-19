require 'rails_helper'

#FIXME: how should I include business logic in rpsec tests?
describe "Game Api" do
  FactoryGirl.create(:game)

  describe "Put /game/1" do

    describe "if making a bet" do

      describe "successful bet" do

        it "responds with current bet amount" do

          get '/api/v1/game'
          
          # TODO: mock stub Game with an amount

          expect(response).to be_success
          json = JSON.parse(response.body)
          #TODO: test game amount

        end
      end
    end
  end
end
