require 'rails_helper'

#TODO: why do files load with this syntax vs expected way below...
# RSpec.describe Player, :type => :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
#
describe Player do
  before { @player = Player.new(total_chips: 0) }

  subject { @player }

  it { should respond_to(:total_chips) }

end
