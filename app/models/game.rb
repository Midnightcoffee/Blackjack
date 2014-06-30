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

  #FIXME find a way to represent specific games with specific players
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
    @player = Player.find(1)
    @deck_sleeve = self.deck_sleeve.split("|")
    card = @deck_sleeve.pop()
    if who == "player"
      self.player_hand += card + "|"
      #TODO DRY
      if self.bust? self.player_hand
        self.player_loses @player
        #TODO: because we have one player the game is over
        self.game_over
        #TODO: remove chips
        
      end
    else
      self.dealer_hand += card + "|"
    end
    self.deck_sleeve = @deck_sleeve.join("|").concat("|")
    self.save
  end

  def stand
    self.dealer_play
  end

  def bust? hand
    self.hand_value(hand) > 21
  end
  #FIXME: maybe game reset?
  def game_over
    self.player_hand = ""
    self.dealer_hand = ""
    self.player_bet = 0
    self.save
  end

  def create_deck
    deck_sleeve = []
    6.times do
      deck = []
      ["Spade", "Diamond", "Heart", "club"].each do |suit|
        ["2","3","4","5","6","7","8","9","10","Jack","Queen","King","Ace"].each do |rank|
          card =  suit + "," + rank
          deck << card
        end
      end
      deck_sleeve << deck
    end
    deck_sleeve.shuffle!
    deck_sleeve = deck_sleeve.join("|") + "|"
    self.deck_sleeve = deck_sleeve
    self.save
  end

  def hand_value hand
    hand = hand.split("|")
    values = []
    hand.each do |card|
      values << self.card_value(card)
    end
    values = values.sort_by(&:length)
    best_value = 0
    values.each do |value|
      if best_value + value.max <= 21
        best_value += value.max
      else
        best_value += value.min
      end
    end
    best_value
  end

  def card_value card
    suit, rank = card.split(",")
    if ["Ace"].include? rank
      return [1,11]
    elsif ["King","Queen","Jack"].include? rank
      return [10]
    else
      return [rank.to_i]
    end
  end

  def dealer_play
    #soft  16
    while self.hand_value(self.dealer_hand) <= 16 do
      self.hit "game"
    end
    #TODO: pause state between game over and next game
    self.find_winner
  end

  def find_winner
    #TODO: would need to check all players
    dealer_value = self.hand_value(self.dealer_hand)
    player_value = self.hand_value(self.player_hand)
    #TODO: pass along player
    @player = Player.find(1)
    if bust?(self.dealer_hand) || player_value > dealer_value
      self.player_wins @player
    elsif dealer_value > player_value
      self.player_loses @player
    else
      self.player_pushes @player
    end
    #FIXME: maybe game reset?
    self.game_over
  end

  def player_loses player
    #bet isn't refunded so... nothing happens?
  end

  def player_wins player
    player.total_chips += (2 * self.player_bet)
    player.save
  end

  def player_pushes player
    #refund
    player.total_chips += self.player_bet
    player.save
  end
end
