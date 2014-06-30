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

  describe "Create deck_sleeve" do
    before do
      @game.create_deck
    end

    it "should have 312 card" do
      #312 = 52 cards * 6 decks
      expect(@game.deck_sleeve.count("|")).to eq(312) 
    end

    it "should have 72 spade cards" do
      #TODO: explain through cards?
      #78 = 13 cards of a suit * 6
      expect(@game.deck_sleeve.scan(/Spade/).count).to eq(78) 
    end 
  end

  describe "#card_value" do
    it "Ace" do
      card = "Spade,Ace"
      expect(@game.card_value card).to eq([1,11])  
    end

    it "King" do
      card = "Spade,King"
      expect(@game.card_value card).to eq([10]) 
    end

    it "2" do
      card = "Spade,2"
      expect(@game.card_value card).to eq([2]) 
    end
  end

  describe "#hand_value" do
    it "Ace,Ace,Ace" do
      hand = "Spade,Ace|Diamond,Ace|Heart,Ace|"
      expect(@game.hand_value hand).to eq(13)   
    end
    it "Ace,Jack" do
      #TODO: special blackjack?
      hand = "Spade,Jack|Diamond,Ace|"
      expect(@game.hand_value hand).to eq(21)   
    end

    it "10,10,7" do
      #TODO: special blackjack?
      hand = "Spade,10|Diamond,10|Spade,7|"
      expect(@game.hand_value hand).to eq(27)   
    end

    it "largest hand possible" do
      #TODO: special blackjack?
      hand = "Spade,Ace|Heart,Ace|Club,Ace|Diamond,Ace|Club,2|Heart,2|Diamond,2|Spade,2|Spade,3|Heart,3|Diamond,3|"
      expect(@game.hand_value hand).to eq(21)   
    end
    
  end


end
