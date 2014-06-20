require 'rails_helper'

describe Player do
  # TODO: use factory girl and why do i have to do it before
  before do
    @player = Player.new(total_chips: 100) 
  end


  subject { @player }

  it { should respond_to(:total_chips) }

  it "should be the only one allowed" do
    Player.create()
    puts Player.all
    expect(Player.count).to eql(1) 
  end

  it "shouldn't be able to have an id other then 1" do
    @player.id = 2
    @player.save!
    expect(@player.id).to eql(1)
  end
  
  it "shouldn't have 0 total chips" do
    @player.total_chips = 0
    expect(@player.total_chips).to eql(100)
  end
end
