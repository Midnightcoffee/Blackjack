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

  describe "#hit" do
    it "successful" do
      @game.deck_sleeve = "Diamond,Ace|Heart,Ace|Heart,10|Spade,Ace|Spade,10"
      @game.hit "player"
      #TODO: mock bust
      expect(@game.player_hand).to eq("Spade,10|")
      expect(@game.deck_sleeve).to eq("Diamond,Ace|Heart,Ace|Heart,10|Spade,Ace|")
    end

    it "#busts" do
      @game.deck_sleeve = "Spade,9|Diamond,10|"
      @game.player_hand = "Spade,10|Heart,10|" 
      @game.hit "player"
      #TODO: mock bust
      #TODO: mock bust
      expect(@game.player_hand).to eq("")
      expect(@game.player_bet).to eq(0)
      expect(@game.deck_sleeve).to eq("Spade,9|")
    end
    
  end


  #TODO hit when game not in play

  describe "#stand" do
    before do 
    end
    it "player wins" do 
      @game.player_hand = "Spade,10|Spade,Ace|" 
      @game.dealer_hand = "Heart,Ace|Heart,9|" 
      @game.player_bet = 30
      @player.total_chips = 70
      @game.save
      @player.save
      #TODO: hold only makes sense like this with one player
      @game.stand "player"
      @player.reload
      expect(@player.total_chips).to eq(130)

    end

    it "player loses" do 
      #FIXME: put in before block
      @game.player_hand = "Spade,9|Spade,Ace|" 
      @game.dealer_hand = "Heart,Ace|Heart,10|" 
      @game.player_bet = 30
      @player.total_chips = 70
      @game.save
      @player.save
      #TODO: hold only makes sense like this with one player
      @game.stand "player"
      @player.reload
      expect(@player.total_chips).to eq(70)
    end
    
  end 

end
