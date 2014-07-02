class Game < ActiveRecord::Base
  belongs_to :player
 
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
      self.player_hit
      #TODO: dealer?
    end
    1.times do
      self.dealer_hit
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

  def get_card
    @deck_sleeve = self.deck_sleeve.split("|") 
    card = @deck_sleeve.pop() 
  end

  def deck_clean_up
    self.deck_sleeve = @deck_sleeve.join("|").concat("|")
    if self.deck_sleeve == "|"
      self.create_deck
    else
      self.save
    end
  end

  def player_hit
    card = self.get_card
    self.player_hand += card + "|"
    if self.bust?(self.player_hand)
      self.message = "Player Busted, place bet to start new hand."
      self.player_loses @player
    else
      self.save 
    end
    self.deck_clean_up
  end

  def dealer_hit
    card = self.get_card
    self.dealer_hand += card + "|"
    self.deck_clean_up
    self.save
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
    while self.hand_value(self.dealer_hand) <= 16 do
      self.dealer_hit
    end
    self.find_winner
  end

  #TODO: rename?
  def find_winner
    dealer_value = self.hand_value(self.dealer_hand)
    player_value = self.hand_value(self.player_hand)
    #TODO: pass along player
    @player = Player.find(1)
    if bust?(self.dealer_hand) 
      self.player_wins @player
      @outcome_msg = "Dealer Busted"
    elsif player_value > dealer_value
      self.player_wins @player 
      @outcome_msg = "Player beats Dealer"
    elsif player_value < dealer_value
      self.player_loses @player
        @outcome_msg = "Dealer beats Player"
    else
      self.player_pushes @player
      @outcome_msg = "Dealer ties with Player"
    end
    self.game_over @outcome_msg, player_value, dealer_value
  end
  
  def player_loses player
    self.player_bet = 0
  end

  def player_wins player
    player.total_chips += (2 * self.player_bet)
  end

  def player_pushes player
    player.total_chips += self.player_bet
  end

  def game_over outcome_msg
    self.create_message outcome_msg, player_value, dealer_value
    self.player_bet = 0
    self.save
    player.game_over
  end

  def create_message outcome_msg, player_value, dealer_value
    self.message = "#{outcome_msg}: dealer( #{dealer_value} ) VS player( #{player_value} ) || place bet to start new hand"
  end
end
