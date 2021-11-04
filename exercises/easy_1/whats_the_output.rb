# What output does this code print? Fix this class so that there are no surprises waiting in store for the unsuspecting developer.
# 

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    # @name.upcase!   --> this mutates the @variable which is probably undesirable. 
    "My name is #{@name.upcase}."    # --> simply call `upcase` here instead which will not mutate the caller.
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name