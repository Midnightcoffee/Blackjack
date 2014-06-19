class Game < ActiveRecord::Base
  belongs_to :player
  before_save :only_one_allowed

  def only_one_allowed
    if Game.count != 0
      return false
    end
  end

end
