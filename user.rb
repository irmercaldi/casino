class User
  
  print " How many human players? "
  @users_count = gets.chomp.to_i

  @user_name = []
  @user_score = []
  1.upto(@users_count) do |i|
    print "Player #{i}, what is your name? "

    @user_name << gets.chomp
    @user_score[i-1] = 0
  end
end

#bank acct 100$$ card = 5$