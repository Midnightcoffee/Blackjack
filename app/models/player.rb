class Player < ActiveRecord::Base
  attr_readonly :id
  has_many :games
  validates :total_chips, presence: true


  def broke?
    self.total_chips  == 0 && self.no_outstanding_bets?
  end

  def game_over
    if self.broke?
      self.reset_chips_to_100
    end
    self.update_level
  end

  def reset_chips_to_100
    self.total_chips = 100
    self.save
  end

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

  def update_level
    x = (self.total_chips / 100)
    if self.total_chips % 100 != 0
      x += 1
    end
    self.level = x
    self.save
  end

end
