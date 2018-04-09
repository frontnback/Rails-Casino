class PokerController < ApplicationController
  respond_to :html, :js
  before_action :get_messages

  def create
    players = []
    params[:starting_players].each { |player| players << player }
    $games.push(Game.new(params[:starting_players]))
  end

  def show
  end
  # def index
  #   $game.push(Game.new(params[:starting_players]))
  # end

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
  attr_reader :winner

  def initialize(starting_players)
    @lobby = starting_players
    @deck = []
    Card.all.each { |card| deck << card }
    @deck.shuffle!
    @flop = @deck.pop(5)
    @winner = nil
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