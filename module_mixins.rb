# Code Reusability:
# Mixins promote code reusability by allowing us to define common methods and behaviors in modules, which can then be included in multiple classes. This not only saves development time but also ensures consistency and avoids code duplication.
# Modular Design:
# By encapsulating related functionality within modules, mixins encourage a modular design approach. This makes code easier to manage, understand, and maintain.
# Flexibility:
# Mixins provide a flexible way to enhance the functionality of classes. Developers can include or exclude modules as needed, tailoring the behavior of their classes without the constraints imposed by traditional inheritance.
# Avoiding Class Hierarchy Complexity:
# Inheritance hierarchies can quickly become convoluted and difficult to manage. Mixins offer an alternative approach that avoids the complexities associated with deep class hierarchies.
# Selective Method Overriding:
# When a class includes multiple modules with the same method names, Ruby provides a mechanism to resolve conflicts. By using the prepend keyword instead of include, we can prioritize the module that appears first, allowing us to selectively override methods.

class User
  attr_accessor :name, :email, :password

  def initialize(name, email, password)
    @name = name
    @email = email
    @password = password
  end

  def authenticate(password)
    # Logic to authenticate the user’s password
  end

  def validate_email
    # Logic to validate the email address
  end
end

# Modules in Ruby on Rails offer a way to group similar behaviors together. They act as containers for methods, constants, and other module definitions.
# Modules cannot be instantiated or inherited like classes; instead, they are used to provide shared functionality to classes through a process called “mixing in.”
# Mixins allow you to include a module’s methods and attributes within a class, effectively extending its functionality.
# This concept is a form of multiple inheritance, where a class can inherit from one superclass and mix in multiple modules.
module Pagination
  def paginate(page, per_page)
  # Logic for pagination
  end
end

module FooBar
  def say
    puts "2 - Module"
  end
end

class Foo
  include FooBar

  def say
    puts "1 - Implementing Class"
    super
  end
end

Foo.new.say # =>
            # 1 - Implementing Class
            # 2 - Module
            #

module FooBar
  def say
    puts "2 - Module"
    super
  end
end

class Foo
  prepend FooBar

  def say
    puts "1 - Implementing Class"
  end
end

Foo.new.say # =>
            # 2 - Module
            # 1 - Implementing Class

