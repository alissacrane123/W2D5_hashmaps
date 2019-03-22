class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    sum = 0

    self.each_with_index do |el, i|
      sum += (el + i).hash
    end
    sum
  end
end

class String
  def hash
    alpha = ('a'..'z').to_a

    sum = 0
    self.chars.each_with_index do |ch, i|
      index = alpha.index(ch.downcase)
      sum += (index + i).hash
    end
    sum
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
    alpha = ('a'..'z').to_a

    keys = self.keys.map(&:to_s)
    values = self.values 
    arr = []
    (0...keys.length).each  { |i| arr << [keys[i], values[i]] }

    sum = 0
    arr.each do |sub_arr|
      sub_sum = 0
      sub_arr.each do |el|
        if el.is_a?(String)
          index = alpha.index(el)
          sub_sum += index 
        elsif el.is_a?(Integer)
          sub_sum += el
        end 
      end 
      sum += sub_sum.hash
    end 
    sum
  end
end
