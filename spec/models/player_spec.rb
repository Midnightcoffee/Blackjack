require 'rails_helper'

describe Player do
  # TODO: use factory girl and why do i have to do it before
  before do
    @player = Player.new(total_chips: 100) 
  end


  subject { @player }

  it { should respond_to(:total_chips) }

end
