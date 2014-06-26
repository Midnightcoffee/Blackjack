class Game < ActiveRecord::Base
  belongs_to :player
  attr_reader :levels
  
  #FIXME: should these be symbols? Whats the advantage or disadvantage?
  @@levels = ["Beginner", "Intermediate", "High Roller"]
  @@bet_range = {
             "Beginner" => {min: 1, max: 50},
             "Intermediate" => {min: 50, max: 100}, 
             "High Roller" => {min: 100, max: Float::INFINITY}
              }
    
  #FIXME is there a way to get the game_id from the instance
  def self.legal_bet_range amount, level
    amount >= @@bet_range[level][:min] and amount <= @@bet_range[level][:max]
  end

end
