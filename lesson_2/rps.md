# Approach to OOP

The classical approach to object oriented programming is:
1. Write a textual description of the problem or exercise.
2. Extract the major nouns and verbs from the description.
3. Organize and associate the verbs with the nouns.
4. The nouns are the classes and the verbs are the behaviors or methods.

In OO, we generally don't think about the game flow logic at all to start. It's all about organizing and modularizing the code into a cohesive structure - classes. After we come up with the initial class definitions, the final step is to orchestrate the flow of the program using objects instatiated from the classes.

Let's apply the approach above to Rock, Paper, and Scissors

RPS is a two-player game where each player chooses one of three possible moves: rock, paper, or scissors.
the chose moves are then compared to see who wins, according to the following rules:
- rock beats scissors
- scissors beats paper
- paper beats rock

If the players choose the same move, then it's a tie.

Nouns: player, move, rule
Verbs: choose, compare

Now, let's organize the verbs and nouns:

Player
- choose
Move
Rule

-compare

This seems a little awkward because we don't know where `compare` should go and `Move` and `Rule` don't have any verbs. Nevertheless, let's try coding up some classes and methods.

```ruby
class Player
  def initialize
    # maybe a "name"? what about a "move"?
  end

  def choose

  end
end

class Move
  def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock" or "scissors"
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2)

end

```

This is an initial skeleton/napkin modeling of the problem. There are still a lot of unaswered questions and the structure will likely change, but this is a good starting point.

After organizing the nouns and verbs into classes, we need an "engine" to orchestrate the objects. This is where the procedural program flow should be. Let's call the "engine" class `RPSGame`. We want an easy interface to kick things off, so perhaps to play the game, we just instantiate an object and call a method `play`, like this:

```ruby
RPSGame.new.plah
```

Give our desired interface, let's take a shot at the class definition.

```ruby
class RPSGame
  def initialize

  end

  def play

  end
end
```

Starting from that skeleton, we can start to think about what objects are required in the `play` method to facilitate the game..

```ruby
def play
  display_welcome_message
  human_choose_move
  computer_choose_move
  display_winner
  display_goodbye_message
end
```

Lines 3 and 4 look similar, and it also looks like there's a redundant "choose_move" part. This ties into our Player class, which has a choose method. What if "human" and "computer" were both objects of the Player class? They'd both immediately have the Player#choose method. With that insight, we update the RPSGame class definition:

```ruby
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end
```

The `RPSGame` class helps clarify how the classes/object work together and can better inform how to use (or not use) the `Player`, `Move`, and `Rule` classes. 

Let's move this to a proper ruby program file and build from here.