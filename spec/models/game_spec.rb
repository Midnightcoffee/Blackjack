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

end
