class PokerController < ApplicationController
  respond_to :html, :js
  before_action :get_messages

  def create
    players = params[:starting_players]
    other_player = players.first
    idx = $games.size
    $games.push(PokerGame.new(players))
    url = poker_path(game_id: idx)
    ActionCable.server.broadcast "invitations_channel_#{other_player}",
                                  url: url
    redirect_to poker_path(game_id: idx)
  end

  def show
    idx = params[:game_id].to_i
    game = $games[idx]
    @flop = game.flop
    @lobby = game.lobby
    @user = game.lobby.select { |u| u.user_id == current_user.id }

  end

  def get_messages 
    @messages = Message.for_display 
    @message = current_user.messages.build 
  end
end

class PokerPlayer
  attr_accessor :hand, :hand_value
  attr_reader :name, :user_id

  def initialize(user_id, hand)
    @name = name
    @hand = PokerHand.new(hand)
    @user_id = user_id
  end  
end

class PokerGame
  attr_accessor :human, :dealer
  attr_reader :winner, :flop, :lobby

  def initialize(players)
    @deck = Card.all.to_a
    @deck.shuffle!
    @flop = @deck.pop(5)
    @lobby = [PokerPlayer.new(players[0],@deck.pop(2)), PokerPlayer.new(players[1],@deck.pop(2))]
    @winner = nil
  end
end
  
class PokerHand
  attr_reader :hand

  def initialize(cards)
    @hand = cards
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
end