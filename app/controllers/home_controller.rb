class HomeController < ApplicationController
  respond_to :html, :js

  def index
    @incoming = FriendRequest.where(requested_id: current_user)
    $game = Game.new
    $wager = 1
    display_hands
  end

  def hit
    $card = nil
    $game.human_hits
    @card = $game.human_last_card
    if $game.human_busts?
      $card = $game.human_last_card
      evaluate
      render :evaluate and return
    end
  end 

  def stay
    evaluate
  end

  def evaluate
    $game.dealer_turn
    @cards = $game.dealer_last_cards
    @winner = $game.find_winner
    display_hands 
    change_balance
    $game.reset
  end

  def wager
    $wager ||= 1
    $wager += params[:wager].to_i
  end

  def change_balance
    if user_won?
      new_balance = current_balance + $wager
      current_user.update!(balance: new_balance)
    elsif dealer_won?
      new_balance = current_balance - $wager
      current_user.update!(balance: new_balance)
    end
  end

  private

  def current_balance
    current_user.balance
  end

  def user_won?
    $game.winner == 'human'
  end

  def dealer_won?
    $game.winner == 'dealer'
  end

  def display_hands
    @human_hand = $game.human_hand
    @dealer_hand = $game.dealer_hand
  end
end 

class Game
  attr_accessor :human, :dealer
  attr_reader :winner

  def initialize
    $human = Player.new('You')
    $dealer = Player.new('Dealer')
    @winner = nil
  end

  def human_hits
    $human.deal_one
    $human.set_hand_value
  end

  def human_hand
    $human.hand
  end 

  def human_last_card
    human_hand.last
  end

  def dealer_last_cards
    dealer_hand[1..-1]
  end

  def dealer_hand
    $dealer.hand
  end

  def dealer_hits
    $dealer.deal_one
  end

  def human_busts?
    $human.hand_value > 21
  end

  def dealer_busts?
    $dealer.hand_value > 21
  end

  def anyone_bust?
    human_bust? || dealer_busts?
  end

  def dealer_turn
    until $dealer.hand_value >= 17
      dealer_hits
      $dealer.set_hand_value
    end
  end

  def reset
    $human.hand = []
    $dealer.hand = []
  end 

  def find_winner
    if $human.hand_value == $dealer.hand_value
      @winner = nil
      "It's a draw!"
    elsif dealer_busts? && human_busts?
      @winner = nil
      "Both bust! Draw!"
    elsif dealer_busts? && !human_busts?
      @winner = 'human'
      ($human.hand_value == 21) ? "BLACKJACK! You win!" : "Dealer busts! You win!"
    elsif human_busts? && !dealer_busts?
      @winner = 'dealer'
      ($dealer.hand_value == 21) ? "Dealer wins with BLACKJACK!" : "You bust! Dealer wins!"
    elsif $human.hand_value > $dealer.hand_value
      @winner = 'human'
      "You win!"
    else
      @winner = 'dealer'
      "Dealer wins!"
    end
  end

  def user_won?

  end
end

class Player
  attr_accessor :hand, :hand_value
  attr_reader :name

  def initialize(name)
    @name = name
    @hand = [random_card, random_card]
    @hand_value = 0
    set_hand_value
  end

  def deal_one
    @hand << random_card
  end

  def has_ace?
    !hand.select { |card| card.rank == 'A' }.nil?
  end

  def ace_count
    hand.select { |card| card.rank == 'A' }.size
  end

  def busted?
    self.hand_value > 21
  end

  def set_hand_value
    self.hand_value = 0
    self.hand.each { |card| self.hand_value += card.value }
    ace_count.times { self.hand_value -= 10 } if busted? && has_ace?
  end

  private

  def random_card
    idx = rand(52) + 1
    Card.find(idx)
  end
end
