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
    secret.each { |i| secret_cp << i }

    array.length.times do |i|
      if array[i] == @secret[i]
        r_arr << 'R'
        secret_cp[i] = nil
        array_cp[i] = nil
      else
        r_arr << 'O'
      end
    end

    secret_cp.compact!
    array_cp.compact!

    array_cp.each do |i|
      if secret_cp.include?(i)
        secret_cp.delete_at(secret_cp.index(i))
        r_arr[r_arr.index('O')] = 'W'
      end
    end

    r_arr
  end

  def won?(arr)
    @secret == arr
  end
end

class ComputerBoard
  include Utils
  attr_reader :secret, :random_own

  def initialize(secret)
    @secret = secret
    @random_own = random_pick(4)
  end

  def solve
    12.times do |x|
      @secret.length.times do |i|
        random_own[i] = rand(6) + 1 unless random_own[i] == secret[i]
      end

      p "trying #{random_own}"

      if won?(random_own)
        puts 'Computer won!'
        break
      end

      sleep 0.1

      puts 'Computer lost!' if x == 11
    end
  end

  def won?(array)
    array == @secret
  end
end

def print_result(result)
  puts
  puts result.join(' | ')
  puts
end

def play_guess
  board = Board.new

  # p board.secret

  puts
  puts "'R' means 'right color at the right place'"
  puts "'W' means 'right color on the wrong place'"
  puts '\'O\' is empty'
  puts

  12.times do |i|
    puts 'Enter your guess.'
    guess_in = gets.chomp
    guess = guess_in.split(' ')

    guess.map!(&:to_i)

    result = board.check(guess)
    print_result(result)

    if board.won?(guess)
      puts 'You won'
      break
    end
    puts 'You lost' if i == 11
  end
end

def play_creator
  puts 'Enter a secret 4 digit code'
  code = gets.chomp
  code_array = code.split(' ')
  code_array.map!(&:to_i)
  board = ComputerBoard.new(code_array)
  board.solve
end

loop do
  puts "Do you want to play as creator or solver? (enter 'c' or 's' or 'q' to quit)"
  option = gets.chomp.strip.downcase

  case option
  when 'c' then play_creator
  when 's' then play_guess
  when 'q' then break
  else
    puts 'Invalid option.'
  end
end
