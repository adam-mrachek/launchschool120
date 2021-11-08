class Transform
  def initialize(string)
    @string = string
  end

  def self.lowercase(str)
    str.downcase
  end

  def uppercase
    @string.upcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')