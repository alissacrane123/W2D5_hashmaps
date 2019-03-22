class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    i = key.hash % num_buckets
    return false if include?(key)
    @store[i] << key 
    @count += 1
    resize! if num_buckets < @count 
  end

  def include?(key)
    i = key.hash % num_buckets
    @store[i].include?(key)
  end

  def remove(key)
    i = key.hash % num_buckets 
    if include?(key)
      @count -= 1
      @store[i].delete(key)
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    # @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store 
    @store = Array.new(2 * num_buckets) {Array.new}
    @count = 0
    
    old_store.each do |box|
      box.each do |el|
        insert(el)
      end 
    end 
  end
end
