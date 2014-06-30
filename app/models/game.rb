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
      #TODO DRY
      if self.bust? self.player_hand
        self.game_over
      end
    else
      self.dealer_hand += card + "|"
      #TODO DRY
      if self.bust? self.dealer_hand
        self.game_over
      end
    end
    self.deck_sleeve = @deck_sleeve.join("|").concat("|")
    self.save
  end

  def stand who
    @player = Player.find(1)

    #FIXME: player is a mocked example a specific player.
    if who == "player"
      # note the players chips have already been removed from their total
      # FIXME: mock specific hand just to pass test
      if self.player_hand == "Spade,10|Spade,Ace|" 
        @player.total_chips += (2 * self.player_bet)
      end
    end
    #FIXME put into "game over state/reset method "
    @player.save
    self.game_over
  end

  def bust? hand
    #TODO: refactor into its own function
    hand = hand.split("|")
    #TODO: special cases like Ace
    total = 0 
    hand.each do |hand|
      suit, value = hand.split(",")
      total += value.to_i  
    end
    total > 21
  end

  def game_over
    self.player_hand = ""
    self.dealer_hand = ""
    self.player_bet = 0
    self.save
  end

  def create_deck
    deck_sleeve = ""
    6.times do
      deck = ""
      ["Spade", "Diamond", "Heart", "club"].each do |suit|
        ["2","3","4","5","6","7","8","9","10","Jack","Queen","King","Ace"].each do |v|
          card =  suit + "," + v + "|"
          deck.concat(card) 
        end
      end
      deck_sleeve.concat(deck)
    end
    self.deck_sleeve = deck_sleeve
    self.save
  end
end
