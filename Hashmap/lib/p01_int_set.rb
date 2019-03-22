require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max + 1,false)
  end

  def insert(num)
    raise 'Out of bounds' unless num < @store.length && num >=0
    @store[num] = true
  end

  def remove(num)
    @store[num] = false 
  end

  def include?(num)
    @store[num] == true 
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    i = num % num_buckets
    @store[i] << num
  end

  def remove(num)
    i = num % num_buckets
    @store[i].delete(num)
  end

  def include?(num)
    i = num % num_buckets
    @store[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    i = num % num_buckets 
    return false if include?(num)
       
    @count += 1
    @store[i] << num

    resize! if num_buckets < @count 
  end

  def remove(num)
    i = num % num_buckets 
    if include?(num)
      @count -= 1
      @store[i].delete(num)
    end
  end

  def include?(num)
    i = num % num_buckets
    @store[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    old_store = @store.dup
    @count = 0
    @store = Array.new(new_num_buckets) {Array.new}

    old_store.each do |box|
      box.each do |el|
        insert(el)
      end 
    end
  end
end
