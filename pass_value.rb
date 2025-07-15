require 'pry'

def foo(i)
  puts i.object_id
  binding.pry
end

i = 1
puts i.object_id

foo(i)

puts i
