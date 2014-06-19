require 'rails_helper'

describe "ChooseGameLevels Api" do
  describe "Get /choose_game_levels" do
    describe "Successful join" do
      before(:each) do
        #FIXME: NOT rolling back
        # @game = FactoryGirl.create(:game)
        # This shouldnt work how to get a clean database each time?
        # @player = FactoryGirl.create(:player)
        # @game = FactoryGirl.create(:game, :player_id => @player.id)
        @player = Player.create()
        @
        game = Game.create(:player_id => @player.id)
      end

      it "Beginner" do

        patch "/api/v1/choose_game_levels/#{@game.id}", {:level => "Beginner"}
        expect(response).to be_success
        expect(@game.level).to eql("Beginner")
      end

      it "Intermediate" do
        patch "/api/v1/choose_game_levels/#{@game.id}", {:level => "Intermediate"}
        expect(response).to be_success
        expect(@game.level).to eql("Intermediate")
      end

      it "High Roller" do
        patch "/api/v1/choose_game_levels/#{@game.id}", {:level => "High Roller"}
        expect(response).to be_success
        expect(@game.level).to eql("High Roller")
      end
    end
  end
end
