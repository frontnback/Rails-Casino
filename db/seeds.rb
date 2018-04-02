# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DECK = ['2', '3', '4', '5', '6', '7', '8', '9'] +
       ['10', 'J', 'Q', 'K', 'A']

SUITS = ['HEARTS', 'SPADES', 'CLUBS', 'DIAMONDS']
cards = Array.new
DECK.each do |card|
  SUITS.each do |suit|
    cards << "#{card} of #{suit}"
  end 
end

cards.each do |card|
  Card.create(name: card)
end