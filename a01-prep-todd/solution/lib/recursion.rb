#### Recursion ####

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def digital_root(num)
  while num > 10
    num = digital_root_step(num)
  end

  num
end

def digital_root_step(num)
  root = 0
  while num > 0
    root += (num % 10)

    num /= 10
  end

  root
end

# Write a recursive method that returns an array of first n number of factorials
def factorials_rec(num)
  if num == 1
    [1]
  else
    facs = factorials_rec(num - 1)
    facs << facs.last * (num - 1)
    facs
  end
end

# I do exclude max, so this is like `min...max`.
def range(min, max)
  return [] if max <= min + 1
  range(min, max - 1) << max - 1
end

def sum(nums)
  return 0 if nums.empty?
  nums[0] + sum(nums.drop(1))
end

def exp(base, power)
  (power == 0) ? 1 : (base * exp(base, power - 1))
end

class Array
  def deep_dup
    # Argh! Mario and Kriti beat me with a one line version?? Must
    # have used `inject`...
    new_array = []
    self.each do |el|
      new_array << (el.is_a?(Array) ? el.deep_dup : el)
    end
    new_array
  end

  # The renowned one-line inject version of deep_dup
  # Beware inject!
  def dd_inject
    inject([]) { |dup, el| dup << (el.is_a?(Array) ? el.dd_inject : el) }
  end

  # Beware map! The ultimate one-liner.
  def dd_map
    map { |el| el.is_a?(Array) ? el.dd_map : el }
  end
end

# Write a method that returns the first n number of fibonacci numbers in an array.
def fibs_rec(n)
  if n <= 2
    [0, 1].take(n)
  else
    fibs = fibs_rec(n - 1)
    fibs << fibs[-2] + fibs[-1]
  end
end

# Write a method subsets that will return all subsets of an array.
class Array
  def subsets
    return [[]] if empty?
    subs = take(count - 1).subsets
    subs.concat(subs.map { |sub| sub + [last] })
  end
end

def permutations(array)
  return [array] if array.length <= 1


  # Similar to the subsets problem, we observe that to get the permutations
  # of [1, 2, 3] we can look at the permutations of [1, 2] which are
  # [1, 2] and [2, 1] and add the last element to every possible index getting
  # [3, 1, 2], [1, 3, 2], [1, 2, 3], [3, 2, 1], [2, 3, 1]

  # pop off the last element
  first = array.shift
  # make the recursive call
  perms = permutations(array)
  # we will need an array to store all our different permutations
  total_permutations = []


  # Now we iterate over the result of our recusive call say [[1, 2], [2, 1]]
  # and for each permutation add first into every index. This new subarray
  # gets added to total_permutations.
  perms.each do |perm|
    (0..perm.length).each do |i|
      total_permutations << perm[0 ... i] + [first] + perm[i .. -1]
    end
  end
  total_permutations.sort
end

def make_change(target, coins = [25, 10, 5, 1])
  # Don't need any coins to make 0 cents change
  return [] if target == 0
  # Can't make change if all the coins are too big. This is in case
  # the coins are so weird that there isn't a 1 cent piece.
  return nil if coins.none? { |coin| coin <= target }

  # Optimization: make sure coins are always sorted descending in
  # size. We'll see why later.
  coins = coins.sort.reverse

  best_change = nil
  coins.each_with_index do |coin, index|
    # can't use this coin, it's too big
    next if coin > target

    # use this coin
    remainder = target - coin

    # Find the best way to make change with the remainder (recursive
    # call). Why `coins.drop(index)`? This is an optimization. Because
    # we want to avoid double counting; imagine two ways to make
    # change for 6 cents:
    #   (1) first use a nickel, then a penny
    #   (2) first use a penny, then a nickel
    # To avoid double counting, we should require that we use *larger
    # coins first*. This is what `coins.drop(index)` enforces; if we
    # use a smaller coin, we can never go back to using larger coins
    # later.
    best_remainder = make_change(remainder, coins.drop(index))

    # We may not be able to make the remaining amount of change (e.g.,
    # if coins doesn't have a 1cent piece), in which case we shouldn't
    # use this coin.
    next if best_remainder.nil?

    # Otherwise, the best way to make the change **using this coin**,
    # is the best way to make the remainder, plus this one coin.
    this_change = [coin] + best_remainder

    # Is this better than anything we've seen so far?
    if (best_change.nil? || (this_change.count < best_change.count))
      best_change = this_change
    end
  end

  best_change
end

# Stringify
#
# In this exercise, you will define a method `Fixnum#stringify(base)`,
# which will return a string representing the original integer in a
# different base (up to base 16). **Do not use the built-in
# `#to_s(base)`**.
#
# To refresh your memory, a few common base systems:
#
# |Base 10 (decimal)     |0   |1   |2   |3   |....|9   |10  |11  |12  |13  |14  |15  |
# |----------------------|----|----|----|----|----|----|----|----|----|----|----|----|
# |Base 2 (binary)       |0   |1   |10  |11  |....|1001|1010|1011|1100|1101|1110|1111|
# |Base 16 (hexadecimal) |0   |1   |2   |3   |....|9   |A   |B   |C   |D   |E   |F   |
#
# Examples of strings your method should produce:
#
# ```ruby
# 5.stringify(10) #=> "5"
# 5.stringify(2)  #=> "101"
# 5.stringify(16) #=> "5"
#
# 234.stringify(10) #=> "234"
# 234.stringify(2)  #=> "11101010"
# 234.stringify(16) #=> "EA"
# ```
#
# Here's a more concrete example of how your method might arrive at the
# conversions above:
#
# ```ruby
# 234.stringify(10) #=> "234"
# (234 / 1)   % 10  #=> 4
# (234 / 10)  % 10  #=> 3
# (234 / 100) % 10  #=> 2
#                       ^
#
# 234.stringify(2) #=> "11101010"
# (234 / 1)   % 2  #=> 0
# (234 / 2)   % 2  #=> 1
# (234 / 4)   % 2  #=> 0
# (234 / 8)   % 2  #=> 1
# (234 / 16)  % 2  #=> 0
# (234 / 32)  % 2  #=> 1
# (234 / 64)  % 2  #=> 1
# (234 / 128) % 2  #=> 1
#                      ^
# ```
#
# The general idea is to each time divide by a greater power of `base`
# and then mod the result by `base` to get the next digit. Continue until
# `num / (base ** pow) == 0`.
#
# You'll get each digit as a number; you need to turn it into a
# character. Make a `Hash` where the keys are digit numbers (up to and
# including 15) and the values are the characters to use (up to and
# including `F`).

# Recursive Solution

class Fixnum
  def stringify(base)
    # handle the case where self == 0.
    return "0" if self == 0

    # first find the least-significant digit, the part that goes in the
    # "ones" column. The leftover amount is now a multiple of `base`. We
    # can recursively call our method to represent the high order bits.
    low_digit = self % base
    leftover = self - low_digit

    digits = [
      "0", "1", "2", "3", "4", "5", "6", "7",
      "8", "9", "a", "b", "c", "d", "e", "f"
    ]

    if leftover > 0
      (leftover / base).stringify(base) + digits[low_digit]
    else
      # nothing leftover, done.
      digits[low_digit]
    end

    # e.g.,
    # self_to_s(144, 10) => {:low_digit => 4, :leftover => 140}
    #   self_to_s(14, 10) => {:low_digit => 4, :leftover => 10}
    #     self_to_s(1, 10) => {:low_digit => 1, :leftover => 0}
  end
end

def first_even_numbers_sum(n)
  return 2 if n == 1

  2 * n + first_even_numbers_sum(n-1)
end
