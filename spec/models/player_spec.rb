require 'rails_helper'

describe Player do
  before do
    @player = FactoryGirl.create(:player, total_chips: 100) 
    @game = FactoryGirl.create(:game, player_id: @player.id, level: "Beginner", id: 1, player_bet: 0) 
  end

  subject { @player }

  it { should respond_to(:total_chips) }

  describe "#reset_chips_to_100" do
    context "no outstanding bets" do
      it "when reach 0 chips" do
        @game.player_bet = 0
        @game.save
        @player.total_chips = 0
        @player.reset_chips_to_100
        expect(@player.total_chips).to eql(100)
      end
    end

    context "outstanding bets" do
      it "when reach 0 chips" do
        @game.player_bet = 50
        @game.save
        @player.total_chips = 0
        @player.reset_chips_to_100
        expect(@player.total_chips).to eql(0)
      end
    end
  end

  describe "#no_outstanding_bets" do
    it "current bet" do
      @game.player_bet = 50
      @game.save
      expect(@player.no_outstanding_bets?).to eq(false)  
    end

    it "NO current bet" do
      @game.player_bet = 0
      expect(@player.no_outstanding_bets?).to eq(true)  
    end
    
  end


  describe "#enough_chips?" do
    it "should have enough chips" do
      @player.total_chips = 100
      @bet = 30
      expect(@player.enough_chips? @bet).to equal(true)
    end

    it "shouldn't have enough chips" do
      @player.total_chips = 20
      @bet = 30
      expect(@player.enough_chips? @bet).to equal(false)
    end
  end
end
