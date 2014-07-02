class Game < ActiveRecord::Base
  belongs_to :player
 
  #TODO separate out class methods and instance methods
  #FIXME: should these be symbols? Whats the advantage or disadvantage?
  @@hidden = [:deck_sleeve, :created_at, :updated_at]
  @@levels = ["Beginner", "Intermediate", "High Roller"]

  # ------------------------------- Class variables -----------------------
  def self.levels
    @@levels
  end

  def self.hidden
    @@hidden
  end

  # ----------------------------- instance methods -------------------
    
  def within_range? player_bet
    player_bet >= self.min_bet && player_bet <= (self.max_bet || Float::INFINITY)
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

  def clear_hands
    self.player_hand = ""
    self.dealer_hand = ""
    self.save
  end
  
  def legal_bet? player, player_bet
    player.enough_chips?(player_bet) && self.within_range?(player_bet) && self.player_bet == 0
  end

  def place_bet player, player_bet
    self.message = "You can Stand or Hit"
    self.player_bet = player_bet
    if self.save
      #FIXME should probable tell player
      player.total_chips -= player_bet
      player.save
    end
  end

  #hit should be on Dealer and Player
  #FIXME 
  def hit who
    #FIXME pass along players
    @player = Player.find(1)
    @deck_sleeve = self.deck_sleeve.split("|")
    card = @deck_sleeve.pop()
    if who == "player"
      self.player_hand += card + "|"
      #TODO DRY
      if self.bust?(self.player_hand)
        #TODO move into bust?
        self.message = "Player Busted, place bet to start new hand."
        self.game_over
        self.player_loses @player
        #TODO: because we have one player the game is over
      else
        self.save 
      end
    else
      self.dealer_hand += card + "|"
    end
    self.deck_sleeve = @deck_sleeve.join("|").concat("|")
    if self.deck_sleeve == "|"
      self.create_deck
    else
      self.save
    end

  end

  def stand
    self.dealer_play
  end

  def bust? hand
    self.hand_value(hand) > 21
  end


  def create_deck
    deck_sleeve = []
    6.times do
      deck = []
      ["Spade", "Diamond", "Heart", "Club"].each do |suit|
        ["2","3","4","5","6","7","8","9","10","Jack","Queen","King","Ace"].each do |rank|
          card =  suit + "," + rank
          deck << card
        end
      end
      deck_sleeve.concat(deck)
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

  #TODO: rename?
  def find_winner
    #TODO: would need to check all players
    dealer_value = self.hand_value(self.dealer_hand)
    player_value = self.hand_value(self.player_hand)
    #TODO: pass along player
    @player = Player.find(1)
    if bust?(self.dealer_hand) 
      message = "Dealer busted"
      self.player_wins @player
    elsif player_value > dealer_value
      self.player_wins @player
      message = "Player beats Dealer"
    elsif dealer_value > player_value
      self.player_loses @player
      message = "Dealer beats Player"
    else
      self.player_pushes @player
      message = "Dealer ties with Player"
    end
    #FIXME: maybe game reset?
    self.create_message message, player_value, dealer_value

  end
  
  #FIXME: these should be on player to, maybe they should read inform_winners,
  #inform losers
  def player_loses player
    self.player_bet = 0
    self.game_over
    #TODO: this is to roundabout a way to reset the chips.
  end


  def player_wins player
    #FXIME: updating should be on the player along with game_over
    player.total_chips += (2 * self.player_bet)

    player.save
    self.player_bet = 0
    self.game_over
    #TODO do we need this save
  end

  def player_pushes player
    #refund
    player.total_chips += self.player_bet
    player.save
    self.game_over

  end

  #FIXME: maybe game reset or hand_over
  def game_over
    self.player_bet = 0
    self.save
    player.game_over self
  end

  def create_message outcome, player_value, dealer_value
    self.message = "#{outcome}: dealer( #{dealer_value} ) VS player( #{player_value} ) || place bet to start new hand"
  end

end
