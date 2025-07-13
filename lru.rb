require 'concurrent/hash'

class CacheItem
  attr_reader :value, :expired_at

  def initialize(value, ttl)
    @value = value
    @expired_at = Time.now.utc + ttl
  end

  def expired?
    @expired_at < Time.now
  end
end

class LRU
  def initialize(size)
    @size = size
    @store = Concurrent::Hash.new
    @access = Concurrent::Hash.new
  end

  def get(key)
    puts "Get: #{key}"
    item = @store[key]
    return if item.nil?

    if item.expired?
      @store.delete(key)
      @access.delete(key)
    end

    refresh_access(key)
    item.value
  end

  def set(key, value, ttl)
    puts "Set: #{key}"

    item = CacheItem.new(value, ttl)
    if @store[key]
      refresh_access(key)
    else
       @store[key] = item
       refresh_access(key)
       expire_keys
    end
  end

  # In Ruby, a private method (or private message handler) can only respond to a message with an implicit receiver (self).
  # It also cannot respond to a message called from outside of the private message handler context (the object)
  private

  def refresh_access(key)
    @access.delete(key)
    @access[key] = true
  end

  def expire_keys
    overflow = @store.length - @size
    return if overflow <= 0

    while overflow != 0
      keyval = @access.first
      if keyval
        key = keyval[0]
        @store.delete(key)
        @access.delete(key)
      end
      overflow -= 1
    end
  end

  # In Ruby, a protected method (or protected message handler) can only respond to a message with an implicit/explicit receiver (object) of the same family.
  # It also cannot respond to a message sent from outside of the protected message handler context.
  protected
end

cache = LRU.new(2)
puts cache.get("user1") || "Not found"
cache.set("user1", "user1", 2)
puts cache.get("user1") || "Not found"
cache.set("user2", "user2", 2)
puts cache.get("user1") || "Not found"
cache.set("user3", "user3", 2)
puts cache.get("user1") || "Not found"
puts cache.get("user2") || "Not found"
puts cache.get("user3") || "Not found"