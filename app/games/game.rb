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