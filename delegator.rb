require 'delegate'

class Anything < SimpleDelegator
end

class Example
 def testing
  "We are testing SimpleDelegator"
 end
end

array = Anything.new([])
array << "Hey"
array << "I am Array"
puts array
# Hey
# I am Array

example = Anything.new(Example.new)
puts example.testing
#  We are testing SimpleDelegator
