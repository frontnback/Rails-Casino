class PokerController < ApplicationController
  respond_to :html, :js
  before_action :get_messages

  def create
    invitation = Invitation.find(params[:invitation])
    players = [invitation.sender_id, invitation.recipient_id]
    poker_room = PokerRoom.new(player1: players[0], player2: players[1],
                 player3: players[2], player4: players[3], player5: players[4],
                 player6: players[5], player7: players[6], player8: players[7])
    if poker_room.save 
      room_id = poker_room.id
      new_game = PokerGame.new(players, room_id)
      players.each { |player| User.find(player).update!(current_room: room_id) }

      room_url = poker_path(id: room_id, round: new_game.round.id)
      ActionCable.server.broadcast "invitations_channel_#{invitation.sender_id}",
                                    url: room_url
      redirect_to room_url
    end
  end

  def show
    round = $games[params[:round].to_i]
    @flop = round.flop
    @lobby = round.lobby
    @current_user_hand = round.current_player(current_user.id).hand
  end

  # def call
  #   current_player.current_bet = current_game.round.pot
  # end

  def bet
    current_round.current_player(current_user.id).current_bet = params[:bet]
  end

  # def fold
  # end

  def get_messages 
    @messages = Message.for_display 
    @message = current_user.messages.build 
  end

  private
    def current_game
      $games[current_user.current_game]
    end

    def current_room
      current_user.current_room
    end

    def current_round
      id = PokerRoom.find(current_room).current_round
      $games[id]
    end
end

class PokerPlayer
  attr_accessor :hand, :hand_value, :current_bet
  attr_reader :name, :user_id

  def initialize(user_id, hand)
    @name = name
    @hand = PokerHand.new(hand)
    @user_id = user_id
    @current_bet = 0
    @round_bet = 0
  end  
end

class PokerGame
  attr_accessor :human, :dealer
  attr_reader :winner, :flop, :lobby, :round, :big_blind

  def initialize(players, room)
    @big_blind = 100
    @deck = Card.all.to_a
    @deck.shuffle!
    @flop = @deck.pop(5)
    @lobby = [PokerPlayer.new(players[0],@deck.pop(2)), PokerPlayer.new(players[1],@deck.pop(2))]
    @winner = nil
    @round = PokerRound.new(player1: players[0], player2: players[1], poker_room_id: room)
    if @round.save 
      $games[@round.id] = self
      PokerRoom.find(room).update!(current_round: @round.id)
    end
  end

  def current_player(current_user_id)
    self.lobby.select { |player| player.user_id == current_user_id }.first
  end

  # def first_round
  # end

  # def second_round
  # end

  # def third_round
  # end 

  # def fourth_round
  # end
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