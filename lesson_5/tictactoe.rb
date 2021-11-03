# Tic Tac Toe is a 2-player board game played on a 3X3 grid.
# Players take turns marking a square - the first player to mark 3 squares in a row wins.

# Nouns: board, player, square, grid
# Verbs: play, mark

# Board
# Square
# Player
# - mark
# - play

class Board
  INITIAL_MARKER = " "
  WINNING_LINES = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ]

  attr_reader :squares, :winner

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new(INITIAL_MARKER) }
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def open_squares
    squares.select{ |k, v| v.marker == " " }.keys
  end

  def full?
    open_squares.empty?
  end

  def someone_won?(player1, player2)
    !!winning_marker(player1, player2)
  end

  def winning_marker(player1, player2)
    WINNING_LINES.each do |line|
      markers = @squares.fetch_values(*line)
      if markers.all? { |marker| "#{marker}" == player1.marker }
        @winner = player1
        return player1.marker
      elsif markers.all? { |marker| "#{marker}" == player2.marker }
        @winner = player2
        return player2.marker
      end
    end
    nil
  end

  def draw
    puts "     |     |     "
    puts "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}"
    puts "     |     |     "
    puts "-----|-----|-----"
    puts "     |     |     "
    puts "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}"
    puts "     |     |     "
    puts "-----|-----|-----"
    puts "     |     |     "
    puts "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}"
    puts "     |     |     "
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

  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'

  def initialize
    initialize_board
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end
  
  def play
    clear
    display_welcome_message

    loop do
      initialize_board

      loop do
        display_board
        human_moves
        clear_screen_and_display_board
        break if board.someone_won?(human, computer) || board.full?
  
        computer_moves
        break if board.someone_won?(human, computer) || board.full?
        clear
      end
  
      clear_screen_and_display_board
      display_result

      break unless play_again?
      reset
    end

    display_goodbye_message
  end

  private

  def initialize_board
    @board = Board.new
  end

  def display_welcome_message
    puts "Hello, welcome to Tic Tac Toe!"
  end

  def display_goodbye_message
    puts "Thanks for playing. Good bye!"
  end

  def display_board
    puts "You are #{human.marker}. Computer is #{computer.marker}."
    puts ""
    board.draw
    puts
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts "Choose a square: #{board.open_squares.join(', ')}"
    square = nil

    loop do
      square = gets.chomp.to_i
      break if board.open_squares.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    square = board.open_squares.sample
    board[square] = computer.marker
  end

  def display_result
    winner = board.winner
    if winner.marker == HUMAN_MARKER
      puts "Congratulations! You won the game!"
    elsif winner.marker == COMPUTER_MARKER
      puts "Computer won the game!"
    end
  end

  def play_again?
    response = nil

    loop do
      puts "Would you like to play again? (y or n)"
      response = gets.chomp.downcase
      break if %(y n).include?(response)
      puts "Sorry, please enter 'y' or 'n'."
    end

    response == 'y'
  end

  def reset
    clear
    puts "Let's play again!"
    puts ""
  end

  def clear
    system "clear"
  end
end

# kick off a game like this
game = TTTGame.new
game.play