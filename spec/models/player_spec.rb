require 'rails_helper'

describe Player do
  before do
    @player = Player.new(total_chips: 100) 
  end

  subject { @player }

  it { should respond_to(:total_chips) }

  it "when reach 0 chips" do
    @player.total_chips = 0
    @player.save
    expect(@player.total_chips).to eql(100)
  end
end
