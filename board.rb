require 'pry'

# 5 x 5 grid
# top row is B I N G O
# 24 random numbers per card
# numbers 1 - 75
# center of card is empty space

#card = create an Array of 5 Arrays each column has numbering as follows
    # B column are from 1 to 15, 
    # I column between 16 and 30, 
    # N column (that contains four numbers and the free (blank) space) between 31 and 45, 
    # G column between 46 and 60, 
    # O column between 61 and 75.
class BingoCard
  def initialize
    @card = []
    5.times do
      row = []
      5.times do
        row << rand(75)
      end
      @card << row
    end
  end

  #-------------- print card displays card to screen----------------------

  def print_card
    @card.each do |row|
      row.each do |square|
        print square.to_s.center(5)
      end
      puts
    end
  end
end

#-------------- print card displays card to screen----------------------
my_card = BingoCard.new
my_card.print_card
