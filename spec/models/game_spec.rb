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
  it { should respond_to(:min_bet) }
  it { should respond_to(:max_bet) }
  it { should respond_to(:message) }


  describe "#within_range?" do
    context "High Roller" do
      #FIXME should be using let
      before do
        @game.id = 3
        @game.level = "High Roller"
        @game.min_bet = 100
        @game.max_bet = nil

      end

      it "is never to high" do
        @bet = 10000000
        expect(@game.within_range? @bet).to be true 
      end

      it "too low" do
        @bet = 99
        expect(@game.within_range? @bet).to be false
      end
      
    end
    context "Intermediate" do
      before do
        @game.id = 2
        @game.level = "Intermediate"
        @game.min_bet = 50
        @game.max_bet = 100
      end

      it "too high" do
        @bet = 10000000
        expect(@game.within_range? @bet).to be false
      end

      it "too low" do
        @bet = 49
        expect(@game.within_range? @bet).to be false
      end

      it "acceptable" do
        @bet = 51
        expect(@game.within_range? @bet).to be true
      end
      
    end
    context "Beginner" do
      before do
        @game.id = 1
        @game.level = "Beginner"
        @game.min_bet = 1
        @game.max_bet = 50
      end

      it "too high" do
        @bet = 51
        expect(@game.within_range? @bet).to be false
      end

      it "too low" do
        @bet = 0
        expect(@game.within_range? @bet).to be false
      end

      it "acceptable" do
        @bet = 1
        expect(@game.within_range? @bet).to be true
      end
      
    end
      
  end

  
  # describe "Successful Bet" do
  #   #FIXME wording...
  #   it "Beginner" do
  #     #FIXME how to reference subject?
  #     @game.level = "Beginner"
  #     expect(@game.within_range?(20)).to equal(true)
  #   end

  #   it "Intermediate" do
  #     #FIXME how to reference subject?
  #     @game.level = "Intermediate"
  #     expect(@game.within_range?(75)).to equal(true)
  #   end

  #   it "High Roller" do
  #     #FIXME how to reference subject?
  #     @game.level = "High Roller"
  #     expect(@game.within_range?(10000)).to equal(true)
  #   end
  # end

  # describe "UnSuccessful Bet" do
  #   describe "Beginner" do
  #   #FIXME wording...
  #     it "should be to high" do
  #       @game.level = "Beginner"
  #       @game.
  #       expect(@game.within_range?(51)).to equal(false)
  #     end

  #     it "should be to low" do
  #       @game.level = "Beginner"
  #       expect(@game.within_range?(0)).to equal(false)
  #     end
  #   end

  #   describe "Intermediate" do
  #   #FIXME wording...
  #     it "should be to high" do
  #       @game.level = "Intermediate"
  #       expect(@game.within_range?(49)).to equal(false)
  #     end

  #     it "should be to low" do
  #     @game.level = "Intermediate"
  #       expect(@game.within_range?(101)).to equal(false)
  #     end
  #   end

  #   describe "High Roller" do
  #     before do
  #       @game.level = "High Roller"
  #     end

  #     it "should be to low" do
  #       @game.level = "High Roller"
  #       expect(@game.within_range?(99)).to equal(false)
  #     end

  #     it "should never to be to high" do
  #       @game.level = "High Roller"
  #       expect(@game.within_range?(1000000000)).to equal(true)
  #     end
    # end
  # end

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

  describe "#player_hit" do
    it "successful" do
      @game.deck_sleeve = "Diamond,Ace|Heart,Ace|Heart,10|Spade,Ace|Spade,10"
      @game.player_hit
      #TODO: mockbust
      expect(@game.player_hand).to eq("Spade,10|")
      expect(@game.deck_sleeve).to eq("Diamond,Ace|Heart,Ace|Heart,10|Spade,Ace|")
    end

    it "busts" do
      @game.deck_sleeve = "Spade,9|Diamond,10|"
      @game.player_hand = "Spade,10|Heart,10|" 
      @game.player_hit
      #TODO: mock bust
      expect(@game.player_hand).to eq("Spade,10|Heart,10|Diamond,10|")
      expect(@game.player_bet).to eq(0)
      expect(@game.deck_sleeve).to eq("Spade,9|")
    end
    
  end

  describe "#Create_deck" do
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
      hand = "Spade,Jack|Diamond,Ace|"
      expect(@game.hand_value hand).to eq(21)   
    end

    it "10,10,7" do
      hand = "Spade,10|Diamond,10|Spade,7|"
      expect(@game.hand_value hand).to eq(27)   
    end

    it "largest hand possible" do
      hand = "Spade,Ace|Heart,Ace|Club,Ace|Diamond,Ace|Club,2|Heart,2|Diamond,2|Spade,2|Spade,3|Heart,3|Diamond,3|"
      expect(@game.hand_value hand).to eq(21)   
    end
    
  end

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

  describe "#busts" do
    it "over" do
      expect(@game.bust?(22)).to eq(true)
    end

    it "under" do
      expect(@game.bust?(21)).to eq(false)
    end
  end
end
