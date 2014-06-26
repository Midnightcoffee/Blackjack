class Player < ActiveRecord::Base
  attr_readonly :id
  has_many :games
  validates :total_chips, presence: true
  before_save :reset_chips_to_100

  def reset_chips_to_100
    if self.total_chips  == 0
      self.total_chips = 100
    end 
  end

  #FIXME better way to express this
  #TODO: game range
  def bet game, amount
    if self.total_chips >= amount && Game.legal_bet_range(amount, game.level)
      game.player_bet = amount
      game.save!
    else
      #FIXME pass along error message
      false
    end
  end


end
