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
    r_arr = [] # return array

    array.length.times do |i|
      if array[i] == @secret[i]
        r_arr << 'R'
      end
    end
    r_arr
  end
end

board = Board.new
p board.check [1, 2, 3, 4]