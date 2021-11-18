require 'pry'

class MinilangError < StandardError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  VALID_COMMANDS = %w(push add sub mult div mod pop print)

  def initialize(commands)
    @commands = commands.split(" ").map(&:downcase)
    @register = 0
    @stack = []
  end

  def push
    @stack << @register
  end

  def add
    @register += @stack.pop
  end

  def sub
    @register -= @stack.pop
  end

  def mult
    @register *= @stack.pop
  end

  def div
    @register /= @stack.pop
  end

  def mod
    @register %= @stack.pop
  end

  def pop
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    @register = @stack.pop
  end

  def print
    puts @register
  end

  def integer?(value)
    value.to_i.to_s == value
  end

  def valid_command?(command)
    VALID_COMMANDS.include?(command)
  end

  def eval
    @commands.each do |command|
      if integer?(command)
        @register = command.to_i
      elsif !valid_command?(command)
        raise BadTokenError, "Invalid token: #{command}"
      else
        send(command)
      end
    end
  rescue MinilangError => error 
    puts error.message
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)