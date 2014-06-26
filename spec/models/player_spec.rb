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

  describe "Successful Bet" do
    it "should save bet" do
      @bet = 30
      expect(@player.bet(@game, @bet)).to equal(true)
      expect(@game.player_bet).to equal(@bet)
    end

    it "should deduct from total_chips" do
      @bet = 30
      @before_total_chips = @player.total_chips
      expect(@player.bet(@game, @bet)).to equal(true)
      expect(@player.total_chips).to equal(@before_total_chips - @bet)
    end
  end

  describe "UnSuccessful Bet" do
    describe "not enough total chips" do
      #TODO this is the wrong wording but not sure why
      it "should not save bet" do
        @bet = 200
        expect(@player.bet(@game, @bet)).to eql(false)
        expect(@game.player_bet).to equal(0)
      end
    end
  end
end
