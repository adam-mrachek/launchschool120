class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    parts = name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def to_s
    name
  end
end

bob = Person.new('Robert Smith')
puts "The person's name is #{bob}."