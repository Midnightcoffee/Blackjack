require 'rails_helper'

describe Player do
  before do
    @player = Player.new(total_chips: 0) 
  end


  subject { @player }

  it { should respond_to(:total_chips) }

end
