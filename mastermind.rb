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
    array.length.times do |i|
      if array[i] == @secret[i]
        r_arr << 'R'
      elsif @secret.include?(array[i])
        r_arr << 'W'
      else
        r_arr << 'O'
      end
    end
    puts r_arr.join(' | ')
  end

  def won?(arr)
    @secret == arr
  end
end

def play
  board = Board.new

  p board.secret

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
    if i == 11
      puts 'You lost'
    end
  end
end

play