require 'pry'

module Hand
  def hit(card)
    hand << card
  end

  def busted?
    total > 21
  end

  def total
    sum = hand.sum(&:value)

    hand.select { |card| card.rank == 'Ace' }.count.times do
      break if sum <= 21
      sum -= 10
    end

    sum
  end
end

class Player
  include Hand

  attr_accessor :hand

  def initialize
    @hand = []
  end
end

class Dealer
  include Hand

  attr_accessor :hand

  def initialize
    @hand = []
  end

  def deal(deck)
    deck.draw
  end
end

class Card
  attr_reader :rank, :suit

  RANKS = {
    'Jack' => 10,
    'Queen' => 10,
    'King' => 10,
    'Ace' => 11
  }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other_card)
    RANKS.fetch(rank, rank) <=> RANKS.fetch(other_card.rank, other_card.rank)
  end

  def value
    RANKS.fetch(rank, rank)
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  attr_reader :cards

  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @cards = shuffle_cards
  end

  def shuffle_cards
    cards = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        cards << Card.new(rank, suit)
      end
    end
    cards.shuffle
  end

  def draw
    shuffle_cards if @cards.empty?
    @cards.pop
  end
end

class Game
  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def deal_cards
    2.times do
      player.hit(deck.draw)
      dealer.hit(deck.draw)
    end
  end

  def show_cards(player)
    puts "#{player.class} has:"
    player.hand.each do |card|
      puts "> #{card}"
    end
    puts "-----------------"

    puts "#{player.class} Total: #{player.total}"
    puts ""
  end

  def show_initial_cards
    show_cards(player)

    puts ""
    puts "Dealer is showing:"
    puts "> #{dealer.hand.first}"
    puts "-----------------"
    puts "Dealer total: #{dealer.hand.first.value}"
    puts ""
  end

  def hit?
    response = nil
    loop do
      puts "Hit or stay? ('h' or 's')"
      response = gets.chomp.downcase
      break if %w(h s).include?(response)
      puts "That's not a valid input."
    end
    response == 'h'
  end

  def player_turn
    loop do
      if hit?
        puts "Player hits!"
        player.hand << dealer.deal(deck)
        show_cards(player)
      else
        break
      end

      break if player.busted?
    end
  end

  def dealer_turn
    while dealer.total < 17
      dealer.hand << dealer.deal(deck)
    end
  end

  def show_result
    show_cards(player)
    show_cards(dealer)

    if player.busted?
      puts "You busted! Dealer wins."
    elsif dealer.busted?
      puts "Dealer busted! You win!"
    elsif player.total > dealer.total
      puts "Player wins!"
    elsif player.total < dealer.total
      puts "Dealer wins. You lose!"
    else
      puts "It's a draw!"
    end
  end

  def play_again?
    response = nil

    loop do
      puts "Would you like to play again? ('y' or 'n')"
      response = gets.chomp.downcase
      break if %w(y n).include?(response)
      puts "Sorry, not a valid input."
    end

    response == 'y'
  end

  def reset
    player.hand = []
    dealer.hand = []
  end

  def start
    loop do
      deal_cards
      show_initial_cards
      player_turn
      dealer_turn unless player.busted?
      show_result

      break unless play_again?

      reset
    end

    puts "Thanks for playing!"
  end
end

Game.new.start
