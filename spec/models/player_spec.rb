require 'rails_helper'

describe Player do
  # TODO: use factory girl and why do i have to do it before
  before do
    @player = Player.new(total_chips: 100) 
  end


  subject { @player }

  it { should respond_to(:total_chips) }

  it "should be the only one allowed" do
    #TODO does this actual work?
    Player.create()
    expect(Player.count).to eql(1)
    
  end

end
