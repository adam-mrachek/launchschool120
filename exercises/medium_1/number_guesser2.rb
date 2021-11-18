class GuessingGame

  def initialize(min, max)
    @range = min..max
  end

  def valid_guess?(number)
    @range.include?(number)
  end

  def reset
    @winning_number = Random.new.rand(@range)
    @guesses = Math.log2(@range.max - @range.min).to_i + 1
  end

  def get_guess
    guess = nil
    loop do
      puts "Enter a number between #{@range.min} and #{@range.max}:"
      guess = gets.chomp.to_i
      break if @range.include?(guess)
      puts "Invalid guess."
    end
    guess
  end

  def result_of_guess(guess)
    case
    when guess > @winning_number
      puts "Your guess is too high."
    when guess < @winning_number
      puts "Your guess is too low."
    end
  end

  def win_or_lose
    if @guesses > 0
      puts "That's the number!"
      puts "You won!"
    else
      puts "You have no more guesses. You lost"
    end
  end

  def play
    reset

    while @guesses > 0 do
      puts ""
      puts "You have #{@guesses} guesses remaining."
      guess = get_guess
      break if guess == @winning_number
      result_of_guess(guess)

      @guesses -= 1
    end

    win_or_lose
  end
end

game = GuessingGame.new(501, 1500)
game.play