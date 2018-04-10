class PokerController < ApplicationController
  respond_to :html, :js
  before_action :get_messages

  def create
    players = params[:starting_players]
    idx = $games.size
    $games.push(Game.new)
    redirect_to poker_path(game_id: idx)
  end

  def show
    idx = params[:game_id].to_i
    game = $games[idx]
    @flop = game.flop
    @lobby = game.lobby
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

class Game
  attr_accessor :human, :dealer
  attr_reader :winner, :flop, :lobby

  def initialize
    @lobby = []
    @deck = []
    Card.all.each { |card| @deck << card }
    @deck.shuffle!
    @flop = @deck.pop(5)
    @winner = nil
  end

  private

  # def random_card
  #   idx = rand(52) + 1
  #   if !$indices.include?(idx)
  #     $indices << idx
  #     Card.find(idx)
  #   else 
  #     random_card
  #   end
  # end
end