require 'rails_helper'

describe Player do
  before do
    @player = FactoryGirl.create(:player, total_chips: 100) 
    @game = FactoryGirl.create(:game, player_id: @player.id, level: "Beginner", id: 1, player_bet: 0) 
  end

  subject { @player }

  it { should respond_to(:total_chips) }

  it "resets chips do" do
    @player.reset_chips_to_100 
    expect(@player.total_chips).to eql(100)
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

  describe "#broke?" do
    it "not yet" do
      @game.player_bet = 50

      @player.total_chips = 0
      @game.save
      @player.save
      expect(@player.broke?).to eq(false) 
    end

    it "has chips" do
      @game.player_bet = 0
      @player.total_chips = 100
      expect(@player.broke?).to eq(false) 
    end

    it "yep.." do
      @game.player_bet = 0
      @player.total_chips = 0
      expect(@player.broke?).to eq(true) 
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
