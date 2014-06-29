class Game < ActiveRecord::Base
  belongs_to :player
 
  #TODO separate out class methods and instance methods
  #FIXME: should these be symbols? Whats the advantage or disadvantage?
  @@levels = ["Beginner", "Intermediate", "High Roller"]
  @@bet_range = {
             "Beginner" => {min: 1, max: 50},
             "Intermediate" => {min: 50, max: 100}, 
             "High Roller" => {min: 100, max: Float::INFINITY}
              }
  def self.levels
    @@levels
  end
    
  #FIXME is there a way to get the game_id from the instance
  #FIXME maybe this shouldn't be self.method
  def within_range? player_bet
    player_bet >= @@bet_range[self.level][:min] && player_bet <= @@bet_range[self.level][:max]
  end

  #FIXME there is a MUCH better way to do this
  def deal 
    2.times do
      self.hit "player"
      #TODO: dealer?
    end
    # if we had multiple players it would like players.each do |player|
    # 1 times makes life easier and it doesn't matter when dealer gets his cards
    1.times do
      self.hit "game"
      #TODO: dealer?
    end
  end
  
  #hit should be on Dealer and Player
  #FIXME 
  def hit who
    @deck_sleeve = self.deck_sleeve.split("|")
    card = @deck_sleeve.pop()
    if who == "player"
      self.player_hand += card + "|"
    else
      self.dealer_hand += card + "|"
    end
    self.deck_sleeve = @deck_sleeve.join("|").concat("|")
    self.save
  end

end
