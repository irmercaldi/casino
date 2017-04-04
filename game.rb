require "color_text"
require "pry"

class Bingo
    def initialize
      @table = [
      #HORIZONTAL WINS      
      [:a1,:a2,:a3,:a4,:a5],
      [:b1,:b2,:b3,:b4,:b5],
      [:c1,:c2,:c3,:c4,:c5],
      [:d1,:d2,:d3,:d4,:d5],
      [:e1,:e2,:e3,:e4,:e5],
      #VERTICAL WINS
      [:a1,:b1,:c1,:d1,:e1],
      [:a2,:b2,:c2,:d2,:e2],
      [:a3,:b3,:c3,:d3,:e3],
      [:a4,:b4,:c4,:d4,:e4],
      [:a5,:b5,:c5,:d5,:e5],
      #DIAGONAL WINS
      [:a1,:b2,:c3,:d4,:e5],
     [:e1,:d2,:c3,:b4,:a5]
     ]

    @user = ' X'.red 
    #NUMBER OF USERS/CARDS

    puts "LETS PLAY BINGO!!!!"
    print "How many cards would you like to buy?"
    @users_count = gets.chomp.to_i
    
    #GET USER'S NAME
    @user_name = []
    @user_score = []
    1.upto(@users_count) do |i|
      print "Player #{i}, what is your name? "
      @user_name << gets.chomp
      @user_score[i-1] = 0
      
    end

    start_game
    end

    def start_game 
    #DEFINED BINGO SPACES
    @places =  Hash.new { |hash, key| hash[key] = " "  }
    @places_keys = [
      :a1,:a2,:a3,:a4,:a5,
      :b1,:b2,:b3,:b4,:b5,
      :c1,:c2,:c3,:c4,:c5,
      :d1,:d2,:d3,:d4,:d5,
      :e1,:e2,:e3,:e4,:e5
   ]

    @bingo_cards = []

    card_populate(@users_count)

    user_turn
    end

  def card_number_picker(num)
    #RANDOMLY PICKS THE BINGO NUMBERS FOR THE BOARD/PLACES X IN THE MIDDLE FOR FREE SPACE
         case num
         when 0..4
            rand(1..15)
         when 5..9
            rand(16..30)
         when 10..11
            rand(31..45)
         when 12
             "X".red
         when 13..14
            rand(31..45)
         when 15..19
            rand(46..60)
         when 20..24
            rand(61..75)
         else
            0 
         end
  end

  def card_populate(number)
    #FILLS THE CARD WITH NUMBERS FROM THE BINGO ARRAY
    number.times do 
      @places_keys.each_with_index do |n,i| 
        @places[n] = card_number_picker(i)
      end
      @bingo_cards << @places.dup
    end
  end

 def draw_game
  #DRAWS OUT CARD
     @bingo_cards.each_with_index do |bingo,i|
        puts " #{@user_name[i]}"
        puts " 1   #{bingo[:a1]} | #{bingo[:b1]} | #{bingo[:c1]} | #{bingo[:d1]} | #{bingo[:e1]}"
        puts "    --- --- --- --- ---"
        puts " 2   #{bingo[:a2]} | #{bingo[:b2]} | #{bingo[:c2]} | #{bingo[:d2]} | #{bingo[:e2]}"
        puts "    --- --- --- --- ---"
        puts " 3   #{bingo[:a3]} | #{bingo[:b3]} | #{bingo[:c3]} | #{bingo[:d3]} | #{bingo[:e3]}"
        puts "    --- --- --- --- ---"
        puts " 4   #{bingo[:a4]} | #{bingo[:b4]} | #{bingo[:c4]} | #{bingo[:d4]} | #{bingo[:e4]}"
        puts "    --- --- --- --- ---"
        puts " 5   #{bingo[:a5]} | #{bingo[:b5]} | #{bingo[:c5]} | #{bingo[:d5]} | #{bingo[:e5]}"
        puts " Bingo Number: #{@random}"
     end
  end

  def times_in_column arr, item, bingo
     #COUNTS NUMBER OF X'S IN COLUMN TO SEE IF IT EQUALS 5 IN A ROW
     times = 0
      arr.each do |i| 
        times += 1 if bingo[i] == item
      end
     if times == 5 
      return true
    else
      return false
    end
  end

  def user_turn
    draw_game
    print "Please type g to Go, or 'exit' to be a quitter: "
    input = gets.chomp.downcase.to_str
    if input == 'g'
      @random = rand(1..75)
      puts @random
      @bingo_cards.each do |bingo|
        @places_keys.each do |key|
        bingo[key] = @user if bingo[key] == @random
         end
      end
      check_game(@user)

    else
      wrong_input unless input == 'exit'
    end
  end

   def wrong_input
     puts " Please type go or exit"
     user_turn
   end

  def check_game(next_turn)
    game_over = nil
    @bingo_cards.each_with_index do |bingo, i|
      @table.each do |column|

   #HAS USER WON?
        if times_in_column(column, @user, bingo) == true
          draw_game
          @user_score[i] += 1
          puts " Game Over -- #{@user_name[i]} WINS!!"
          @user_name.each_with_index do |user,z|
            puts "#{user}  #{@user_score[z]}"
          end
          game_over = true
        end
      end
    end

    unless game_over
      user_turn
    end
  end
end

Bingo.new