module Utils
  def random_pick(pegs)
    numbers = [1, 2, 3, 4, 5, 6] # available colors / numbers
    (numbers * pegs).sample(pegs)
  end
end

class Board
  include Utils

  attr_reader :secret

  def initialize(num = 4)
    @secret = random_pick(num)
  end

  def check(array)
    r_arr = [] # array to return
    array_cp = []
    array.each { |i| array_cp << i }
    secret_cp = []
    @secret.each { |i| secret_cp << i }

    array.length.times do |i|
      if array[i] == @secret[i]
        r_arr << 'R'
        secret_cp[i] = nil
        array_cp[i] = nil
      else
        r_arr << 'O'
      end
    end

    secret_cp.delete(nil)
    array_cp.delete(nil)

    array_cp.each do |i|
      if secret_cp.include?(i)
        secret_cp.delete_at(secret_cp.index(i))
        r_arr[r_arr.index('O')] = 'W'
      end
    end

    p r_arr
    puts
  end

  def won?(arr)
    @secret == arr
  end
end

def play_guess
  board = Board.new

  # p board.secret

  puts "'R' means 'right color at the right place'"
  puts "'W' means 'right color on the wrong place'"
  puts '\'O\' is empty'
  puts

  12.times do |i|
    puts 'Enter your guess.'
    guess_in = gets.chomp
    guess = guess_in.split(' ')
    guess.each_with_index do |item, idx|
      guess[idx] = item.to_i
    end
    board.check(guess)
    if board.won?(guess)
      puts 'You won'
      break
    end
    puts 'You lost' if i == 11
  end
end

play_guess