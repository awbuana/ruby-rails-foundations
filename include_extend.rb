# include and extend

module A
 def hello
 "world"
 end
end

class Foo
 include A
end

class Bar
 extend A
end

Foo.new.hello #works
Foo.hello #error

Bar.new.hello #error
Bar.hello #works

# included

module A
 def self.included(base)
 base.extend(ClassMethods)
 end

 def hello
 "world"
 end

 module ClassMethods
 def hi
 "bye"
 end
 end
end

class Foo
 include A
end

Foo.new.hello #works
Foo.hello #error

Foo.new.hi #error
Foo.hi #works