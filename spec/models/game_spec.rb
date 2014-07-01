require 'rails_helper'

describe Game do
  before do
    #TODO factory girl?
    @player = FactoryGirl.create(:player, total_chips: 100, id: 1) 
    @game = FactoryGirl.create(:game, 
                     player_id: @player.id, 
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
      expect(@game.player_hand).to eq("")
      expect(@game.player_bet).to eq(0)
      expect(@game.deck_sleeve).to eq("Spade,9|")
    end
    
  end


  #TODO hit when game not in play

  #TODO: do i even need stand method?
  # describe "#stand" do
  #   before do 
  #   end
  #   it "player wins" do 
  #     @game.player_hand = "Spade,10|Spade,Ace|" 
  #     @game.dealer_hand = "Heart,Ace|Heart,9|" 
  #     @game.player_bet = 30
  #     @player.total_chips = 70
  #     @game.save
  #     @player.save
  #     #TODO:stand only makes sense like this with one player
  #     @game.stand
  #     @player.reload
  #     expect(@player.total_chips).to eq(130)

  #   end

  #   it "player loses" do 
  #     #FIXME: put in before block
  #     @game.player_hand = "Spade,9|Spade,Ace|" 
  #     @game.dealer_hand = "Heart,Ace|Heart,10|" 
  #     @game.player_bet = 30
  #     @player.total_chips = 70
  #     @game.save
  #     @player.save
  #     #TODO: hold only makes sense like this with one player
  #     @game.stand "player"
  #     @player.reload
  #     expect(@player.total_chips).to eq(70)
  #   end
    
  # end 

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

  #TODO: in between game over and new game state needed
  # describe "dealer_play" do
  #   it "hits on 16" do
  #     @game.deck_sleeve = "Heart,8|"
  #     @game.dealer_hand = "Heart,10|Heart,6|"
  #     @game.dealer_play
  #     expect(@game.dealer_hand).to eq("Heart,10|Heart,6|Heart,8|")
  #   end

  #   it "stays on 17" do
  #     @game.deck_sleeve = "Heart,8|"
  #     @game.dealer_hand = "Heart,10|Heart,7|"
  #     @game.dealer_play
  #     expect(@game.dealer_hand).to eq("Heart,10|Heart,7|")
  #   end

  # end

  describe "#find_winner" do

    it "dealer wins" do
      #TODO: mock hand value
      @player.total_chips = 90
      @player.save
      @game.player_bet = 10
      @game.dealer_hand = "Heart,10|Heart,Ace|"
      @game.player_hand = "Spade,2|Spade,3|"
      @game.find_winner
      @game.reload
      @player.reload
      #TOOD: mock  deal
      expect(@game.player_bet).to eq(0)
      expect(@player.total_chips).to eq(90) 
    end

    it "dealer loses" do
      #TODO: mock hand value
      @player.total_chips = 90
      @player.save
      @game.player_bet = 10
      @game.player_hand = "Heart,10|Heart,Ace|"
      @game.dealer_hand = "Spade,2|Spade,3|"
      @game.find_winner
      @game.reload
      @player.reload
      expect(@game.player_bet).to eq(0)
      expect(@player.total_chips).to eq(110) 
    end

    it "dealer busts" do
      #TODO: mock hand value
      @player.total_chips = 90
      @player.save
      @game.player_bet = 10
      @game.player_hand = "Heart,10|Heart,Ace|"
      @game.dealer_hand = "Spade,10|Spade,10|Heart,10|"
      @game.find_winner
      @game.reload
      @player.reload
      expect(@game.player_bet).to eq(0)
      expect(@player.total_chips).to eq(110) 
    end

    it "push" do
      #TODO: mock hand value
      @player.total_chips = 90
      @player.save
      @game.player_bet = 10
      @game.player_hand = "Heart,2|Heart,3|"
      @game.dealer_hand = "Spade,2|Spade,3|"
      @game.find_winner
      @game.reload
      @player.reload
      expect(@game.player_bet).to eq(0)
      expect(@player.total_chips).to eq(100) 
    end
  end
end
