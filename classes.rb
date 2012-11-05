class Card
  SUITS = { 
    :clubs => "Clubs", 
    :hearts => "Hearts",
    :diamonds => "Diamonds",
    :spades => "Spades" }

  VALUES = {
    :two => "Two",
    :three => "Three",
    :four => "Four",
    :five => "Five",
    :six => "Six",
    :seven => "Seven",
    :eight => "Eight",
    :nine => "Nine",
    :ten => "Ten",
    :jack => "Jack",
    :queen => "Queen",
    :king => "King",
    :ace => "Ace" }

	attr_reader :suit
	attr_reader :value

	def initialize(a_value, a_suit)
  	@suit = a_suit
		@value = a_value
	end
  def to_s
    ret_val = VALUES[@value] * 1
    ret_val << " of "
    ret_val << SUITS[@suit]
    return ret_val
  end
end
class Shoe
  attr_reader :size
	def initialize(num_decks)
    @size = num_decks
		@cards = Array.new()
		num_decks.times do
      Card::SUITS.each_key do |suit|
        Card::VALUES.each_key do |value|
          @cards.push(Card.new(value, suit))
        end
      end
    end
  end
  def shuffle
    old_cards = @cards
    @cards = Array.new
    old_cards.size.times do
      @cards.push(old_cards.delete_at(rand(old_cards.size)))
    end
  end
  def print_deck
    i = 1
    @cards.each do |card|
      puts("#{i}: #{card.to_s}")
      i += 1
    end
  end
  def get_cards_left
    return @cards.size
  end
  def draw_card
    return @cards.pop
  end
end
