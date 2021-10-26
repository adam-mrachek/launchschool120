# Tic Tac Toe is a 2-player board game played on a 3X3 grid.
# Players take turns marking a square - the first player to mark 3 squares in a row wins.

# Nouns: board, player, square, grid
# Verbs: play, mark

# Board
# Square
# Player
# - mark
# - play

require 'pry'

class Board
  INITIAL_MARKER = " "
  WINNING_LINES = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ]

  attr_reader :squares

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new(INITIAL_MARKER) }
  end

  def square(key)
    @squares[key]
  end

  def set_square(key, marker)
    @squares[key].marker = marker
  end

  def open_squares
    squares.select{ |k, v| v.marker == " " }.keys
  end

  def full?
    open_squares.empty?
  end

  def someone_won?
    !!detect_winner
  end

  def detect_winner
    WINNING_LINES.each do |line|
      markers = @squares.fetch_values(line[0], line[1], line[2])
      if markers.all? { |marker| "#{marker}" == 'X'}
        return 'X'
      elsif markers.all? { |marker| "#{marker}" == 'O'}
        return 'O'
      end
    end
    nil
  end
end

class Square
  attr_accessor :marker
  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end

  def mark

  end

  def choose_marker
    choice = nil

    loop do
      puts "Choose your marker: X or O?"
      choice = gets.chomp.upcase
      break if %(X O).include?(choice)
      puts "That's not a valid choice."
    end

    choice
  end
end

class TTTGame
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new('X')
    @computer = Player.new('O')
  end

  def display_welcome_message
    puts "Hello, welcome to Tic Tac Toe!"
  end

  def display_goodbye_message
    puts "Thanks for playing. Good bye!"
  end

  def display_board
    puts ""
    puts "     |     |     "
    puts "  #{board.square(1)}  |  #{board.square(2)}  |  #{board.square(3)}"
    puts "     |     |     "
    puts "-----|-----|-----"
    puts "     |     |     "
    puts "  #{board.square(4)}  |  #{board.square(5)}  |  #{board.square(6)}"
    puts "     |     |     "
    puts "-----|-----|-----"
    puts "     |     |     "
    puts "  #{board.square(7)}  |  #{board.square(8)}  |  #{board.square(9)}"
    puts "     |     |     "
    puts ""
  end

  def human_moves
    puts "Choose a square: #{board.open_squares.join(', ')}"
    square = nil

    loop do
      square = gets.chomp.to_i
      break if board.open_squares.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board.set_square(square, human.marker)
  end

  def computer_moves
    square = board.open_squares.sample
    board.set_square(square, computer.marker)
  end

  def display_result
    winner = board.detect_winner
    if winner == 'X'
      puts "Congratulations! You won the game!"
    elsif winner == 'O'
      puts "Computer won the game!"
    end
  end

  def play
    display_welcome_message
    loop do
      display_board
      human_moves
      display_board
      break if board.someone_won? || board.full?

      computer_moves
      break if board.someone_won? || board.full?
    end

    display_board
    display_result
    display_goodbye_message
  end
end

# kick off a game like this
game = TTTGame.new
game.play