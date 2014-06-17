require 'rails_helper'

describe Game do
  # TODO: use factory girl and why do i have to do it before
  let(:player) { FactoryGirl.create(:player) }
  before do 
    #TODO: maybe no the best way...
    @game = Game.new()
  end

  subject { @game }

  it { should respond_to(:player_id) }
  it { should respond_to(:player_hand) }
  it { should respond_to(:player_bet) }
  it { should respond_to(:dealer_hand) }
  it { should respond_to(:deck_sleeve) }
    
end
