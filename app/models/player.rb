class Player < ActiveRecord::Base
  has_one :game
  before_save :only_one_allowed

  #FIXME: duplicate code with player
  def only_one_allowed
    if Player.count != 0
      return false
    end
  end
end
