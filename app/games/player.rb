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
