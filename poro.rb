module UserService
  class Register
    def initialize(a, b)
      @a = a
      @b = b
    end

    def call
      puts "A: #{@a} and B: #{@b}"
    end
  end

  class KwargsRegister
    def initialize(kwargs)
      @args = kwargs
    end

    def call
      puts "Kwargs: #{@args}"
    end
  end

  module_function

  def register(*args); UserService::Register.new(*args).call; end;
  def kwargs_register(*args); UserService::KwargsRegister.new(*args).call; end;
end

UserService.register('a', 'b') # => A: a and B: b

params = {a: 'a', b: 'b'}
UserService.kwargs_register(**params) # => Kwargs: {:a=>"a", :b=>"b"}