class Player < ActiveRecord::Base
  attr_readonly :id
  has_many :games
  validates :total_chips, presence: true
  before_save :reset_chips_to_100

  def reset_chips_to_100
    if self.total_chips  == 0 && self.no_outstanding_bets?
      self.total_chips = 100
    end
  end

  #FIXME is this breaking LOD
  def no_outstanding_bets?
    active_bet = true
    self.games.each do |game|
      if game.player_bet != 0
        active_bet = false
      end
    end
    active_bet
  end

  def enough_chips? player_bet
    self.total_chips >= player_bet
  end

end
