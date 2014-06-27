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

  def enough_chips? player_bet
    self.total_chips >= player_bet
  end
end
