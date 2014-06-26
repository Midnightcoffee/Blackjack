require 'rails_helper'

describe Game do
  before do 
    @game = FactoryGirl.create(:game)

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
      expect(Game.legal_bet_range(20, "Beginner")).to equal(true)
    end

    it "Intermediate" do
      #FIXME how to reference subject?
      expect(Game.legal_bet_range(75, "Intermediate")).to equal(true)
    end

    it "High Roller" do
      #FIXME how to reference subject?
      expect(Game.legal_bet_range(10000, "High Roller")).to equal(true)
    end
  end

  describe "UnSuccessful Bet" do
    describe "Beginner" do
    #FIXME wording...
      it "should be to high" do
        expect(Game.legal_bet_range(51, "Beginner")).to equal(false)
      end

      it "should be to low" do
        expect(Game.legal_bet_range(0, "Beginner")).to equal(false)
      end
    end

    describe "Intermediate" do
    #FIXME wording...
      it "should be to high" do
        expect(Game.legal_bet_range(49, "Intermediate")).to equal(false)
      end

      it "should be to low" do
        expect(Game.legal_bet_range(101, "Intermediate")).to equal(false)
      end
    end

    describe "High Roller" do
    #FIXME wording...

      it "should be to low" do
        expect(Game.legal_bet_range(99, "High Roller")).to equal(false)
      end
    end

  end



end
