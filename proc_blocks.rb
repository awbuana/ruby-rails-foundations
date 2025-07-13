# A block is a chunk of code associated with a method call.
#  It's the most common and fundamental way to pass code around in Ruby. Blocks are not objects themselves, but they can be converted into Proc objects.
# Characteristics:
# Syntax: Defined with do...end or {...}.
# Arity (Number of Arguments): Forgiving with arguments. If you pass too many arguments, it discards the extras. If you pass too few, the missing ones will be nil.
# Return: return inside a block will return from the enclosing method, not just the block itself. This is often called "non-local return."
# Not Objects (Initially): You can't assign a block to a variable directly. You have to convert it to a Proc if you want to treat it as an object.

def greet_with_block
  yield("World") if block_given? # `yield` executes the block
end

greet_with_block do |name|
  puts "Hello, #{name}!"
end
# Hello, World!

# explicit
def greet(&block)
  block.call("World explicit", "gmail.com")
end

greet do |name, email|
  puts "Hello, #{name} #{email}!"
end

# A Proc is an objectified block of code. You can create a Proc from a block, or directly using Proc.new or proc. Procs are instances of the Proc class.
# Characteristics:
# Syntax: Created with Proc.new { ... } or proc { ... }. You can also convert a block to a Proc using &block_name.
# Arity: Forgiving with arguments, similar to blocks.
# Return: return inside a Proc behaves like a return in a block – it performs a non-local return, exiting the method that defined the Proc (or the method that called the Proc if it was created from a block passed to that method).
# Objects: Procs are objects, so you can store them in variables, pass them as arguments, and return them from methods.
# Creating a Proc
my_proc = Proc.new do |name|
  puts "Greetings, #{name} from a Proc!"
end

# Calling a Proc
my_proc.call("Alice")
my_proc.("Bob") # Shorthand for .call
# Greetings, Alice from a Proc!
# Greetings, Bob from a Proc!

