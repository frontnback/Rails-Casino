class PokerController < ApplicationController
  respond_to :html, :js
  before_action :get_messages

  def index
    $indices = []
    $game = Game.new
  end

  def get_messages 
    @messages = Message.for_display 
    @message = current_user.messages.build 
end
end

class Player
  attr_accessor :hand, :hand_value
  attr_reader :name

  def initialize(name)
    @name = name
    @hand = PokerHand.new
  end  
end

class PokerHand
  attr_reader :hand

  def initialize
    @hand = [random_card, random_card]
  end

  def evaluate
    case 
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private
    def suit_arr
      hand.map { |card| card.suit }
    end

    def rank_arr
      hand.map { |card| card.rank }
    end

    def ace_two_straight?
      (['Ace', 2, 3, 4, 5] - rank_arr).empty?
    end

    def sort_hand
      hand.sort_by { |card| card.id }
    end

    def royal_flush?
      flush? && %w(A Q K J 10) - rank_arr.empty?
    end

    def straight_flush?
      flush? && straight?
    end

    def n_of_a_kind?(n)
      rank_arr.any? { |card| rank_arr.count(card) == n }
    end

    def four_of_a_kind?
      n_of_a_kind?(4)
    end

    def full_house?
      n_of_a_kind?(3) && n_of_a_kind?(2)
    end

    def flush?
      suit_arr.uniq.size == 1
    end

    def straight?
      sort_hand.last.straight_id - sort_hand.first.straight_id == 4
    end

    def three_of_a_kind?
      n_of_a_kind?(3)
    end

    def two_pair?
      rank_arr.uniq.count == 3
    end

    def pair?
      rank_arr.uniq.count == 4
    end

    private

      def random_card
        idx = rand(52) + 1
        if !$indices.include?(idx)
          $indices << idx
          Card.find(idx)
        else 
          random_card
        end
      end
end

class Game
  attr_accessor :human, :dealer
  attr_reader :winner

  def initialize
    $player1 = Player.new('Player 1')
    $player2 = Player.new('Player 2')
    $player3 = Player.new('Player 3')
    $player4 = Player.new('Player 4')
    $player5 = Player.new('Player 5')
    $player6 = Player.new('Player 6')
    $player7 = Player.new('Player 7')
    $player8 = Player.new('Player 8')
    @winner = nil
    $flop = PokerHand.new
    3.times do
      $flop.hand << random_card
    end
  end

  private

  def random_card
    idx = rand(52) + 1
    if !$indices.include?(idx)
      $indices << idx
      Card.find(idx)
    else 
      random_card
    end
  end
end