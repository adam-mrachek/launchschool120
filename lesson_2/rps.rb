require 'pry'

class Player
  attr_accessor :move, :name

  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
  end

  def set_name
    if human?
      input = nil

      loop do
        puts "Please enter your name (cannot be blank):"
        input = gets.chomp
        break unless input.empty?
        puts "Not a valid name."
      end
  
      self.name = input
    else
      self.name = ['Homer', 'Bart', 'Lisa', 'Marge'].sample
    end
  end

  def choose
    if human?
      choice = nil
      loop do
        puts "Please choose paper, rock, or scissors:"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include?(choice)
        puts "Sorry, invalid move."
      end
      
      self.move = choice
    else
      self.move = ['rock', 'paper', 'scissors'].sample
    end
  end

  def human?
    @player_type == :human
  end
end

class RPSGame
  attr_accessor :human, :computer

  WINNING_MOVES = {
    'rock' => 'scissors',
    'paper' => 'rock',
    'scissors' => 'paper'
  }

  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Hi, #{human.name}. Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    puts "-------------------"
    if WINNING_MOVES[human.move] == computer.move
      puts "#{human.name} won the game!"
    elsif WINNING_MOVES[computer.move] == human.move
      puts "#{computer.name} won the game!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    response = nil

    loop do
      puts "Would you like to play again? (y/n)"
      response = gets.chomp.downcase
      break if %(y n).include?(response)
      puts "Not a valid input."
    end

    response == 'y'
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end

    display_goodbye_message
  end
end

RPSGame.new.play