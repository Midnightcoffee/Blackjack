class Game < ActiveRecord::Base
  belongs_to :player
  attr_reader :levels
 
  #TODO separate out class methods and instance methods
  #FIXME: should these be symbols? Whats the advantage or disadvantage?
  @@levels = ["Beginner", "Intermediate", "High Roller"]
  @@bet_range = {
             "Beginner" => {min: 1, max: 50},
             "Intermediate" => {min: 50, max: 100}, 
             "High Roller" => {min: 100, max: Float::INFINITY}
              }
    
  #FIXME is there a way to get the game_id from the instance
  #FIXME maybe this shouldn't be self.method
  def within_range? player_bet
    player_bet >= @@bet_range[self.level][:min] && player_bet <= @@bet_range[self.level][:max]
  end

  #FIXME there is a much better way to do this
  def deal 

    2.times do
      self.hit Game
      #TODO: dealer?
    end
    # if we had multiple players it would like players.each do |player|
    2.times do
      self.hit Player.find(1)
      #TODO: dealer?
    end
  end
  
  #hit should be on Dealer and Player
  #FIXME 
  def hit who
    puts self.deck_sleeve
    card = self.deck_sleeve.pop()
    if who.class == Player
      game.player_hand.concat(card)
    else
      game.dealer_hand.concat(card)
    end
    self.save!
  end

end
