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

	def initialize(aValue, aSuit)
    	@suit = aSuit
		@value = aValue
	end
    def to_s
        retVal = VALUES[@value] * 1
        retVal << " of "
        retVal << SUITS[@suit]
        return retVal
    end
end
class Shoe
	def initialize(numDecks)
		@cards = Array.new()
		numDecks.times do
            Card::SUITS.each_key do |suit|
                Card::VALUES.each_key do |value|
                    @cards.push(Card.new(value, suit))
                    puts "Hi"
                end
            end
        end
    end
    def print_deck
        i = 1
        @cards.each do |card|
            puts("#{i}: #{card.to_s}")
            i += 1
        end
    end
end
