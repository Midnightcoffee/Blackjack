require 'rails_helper'

describe Player do
  before do
    @player = Player.new(total_chips: 100) 
    @game = Game.new(player_id: @player.id, level: "Beginner", id: 1, player_bet: 0) 
  end

  subject { @player }

  it { should respond_to(:total_chips) }

  it "when reach 0 chips" do
    @player.total_chips = 0
    @player.save
    expect(@player.total_chips).to eql(100)
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
