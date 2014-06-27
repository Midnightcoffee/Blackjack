require 'rails_helper'

describe Game do
  before do
    @player = Player.new(total_chips: 100) 
    @game = Game.new(player_id: @player.id, level: "Beginner", id: 1, player_bet: 0) 
  end

  subject { @game }

  it { should respond_to(:player_id) }
  it { should respond_to(:player_hand) }
  it { should respond_to(:player_bet) }
  it { should respond_to(:dealer_hand) }
  it { should respond_to(:deck_sleeve) }


  describe "Successful Bet" do
    #FIXME wording...
    it "Beginner" do
      #FIXME how to reference subject?
      @game.level = "Beginner"
      expect(@game.within_range?(20)).to equal(true)
    end

    it "Intermediate" do
      #FIXME how to reference subject?
      @game.level = "Intermediate"
      expect(@game.within_range?(75)).to equal(true)
    end

    it "High Roller" do
      #FIXME how to reference subject?
      @game.level = "High Roller"
      expect(@game.within_range?(10000)).to equal(true)
    end
  end

  describe "UnSuccessful Bet" do
    describe "Beginner" do
    #FIXME wording...
      it "should be to high" do
        @game.level = "Beginner"
        expect(@game.within_range?(51)).to equal(false)
      end

      it "should be to low" do
        @game.level = "Beginner"
        expect(@game.within_range?(0)).to equal(false)
      end
    end

    describe "Intermediate" do
    #FIXME wording...
      it "should be to high" do
        @game.level = "Intermediate"
        expect(@game.within_range?(49)).to equal(false)
      end

      it "should be to low" do
      @game.level = "Intermediate"
        expect(@game.within_range?(101)).to equal(false)
      end
    end

    describe "High Roller" do
    #FIXME wording...

      it "should be to low" do
        @game.level = "High Roller"
        expect(@game.within_range?(99)).to equal(false)
      end

      it "should never to be to high" do
        @game.level = "High Roller"
        expect(@game.within_range?(1000000000)).to equal(true)
      end
    end
  end

  describe "Deck" do
    # describe "deal" do
    #   @game.deck_sleeve = "Spade,Ace Spade,10 Heart,Ace Heart,10"
    #   @game.deal

    #   expect(@game.player_hand).to eq("Heart,Ace Heart,10")
    #   expect(@game.dealer_hand).to eq("Spade,Ace Spade,10")
    #end

    describe "hit" do
      #
      #@game.deck_sleeve = "Spade,Ace Spade,10 Heart,Ace Heart,10"
      # @game.hit @player
      # expect(@game.player_hand).to eq("Heart,10")
    end
    
  end

end
