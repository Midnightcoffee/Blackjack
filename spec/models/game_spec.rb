require 'rails_helper'

describe Game do
  before do
    #TODO factory girl?
    @player = Player.new(total_chips: 100, id: 1) 
    @game = Game.new(player_id: 
                     @player.id, 
                     level: "Beginner", 
                     id: 1, 
                     player_bet: 0,
                     player_hand: "",
                     dealer_hand: "",
                     deck_sleeve: "Diamond,Ace|Heart,Ace|Heart,10|Spade,Ace|Spade,10|")
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

  describe "#Deal" do
    before do
      @game.deck_sleeve = "Diamond,Ace|Heart,Ace|Heart,10|Spade,Ace|Spade,10"
      @game.deal
    end
    #FIXME shorter syntax suger?
    it "players_hand" do
      expect(@game.player_hand).to eq("Spade,10|Spade,Ace|") 
    end
    it "dealers_hand" do
      expect(@game.dealer_hand).to eq("Heart,10|")
    end

    it "remaining_deck" do
      expect(@game.deck_sleeve).to eq("Diamond,Ace|Heart,Ace|")
    end
    
  end

  it "#hit" do
     @game.hit "player"
     expect(@game.player_hand).to eq("Spade,10|")
     expect(@game.deck_sleeve).to eq("Diamond,Ace|Heart,Ace|Heart,10|Spade,Ace|")
  end
end
