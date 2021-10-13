class MyCar
  attr_accessor :speed, :color
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def self.gas_mileage(miles, gallons)
    mileage = miles / gallons
    puts "Your car gets #{mileage} per gallon."
  end

  def accelerate(number)
    self.speed += number
    puts "You accelerated and are now going #{speed} miles per hour."
  end

  def brake(number)
    self.speed -= number
    puts "You hit the brakes and are now going #{speed} miles per hour."
  end

  def turn_off
    self.speed = 0
  end

  def spray_paint(color)
    self.color = color
    puts "Your car is now #{color}."
  end

  def to_s
    "Your car is a #{color} #{year} #{model}."
  end
end