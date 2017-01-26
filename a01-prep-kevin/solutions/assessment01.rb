# These are my personal solutions, and they are not necessarily the best
# answer.  There are multiple ways to solve many problems presented here

class Array
  def my_each(&prc)
    length.times do |i|
      prc.call(self[i])
    end

    self
  end

  def my_each_with_index(&prc)
    length.times do |i|
      prc.call(self[i], i)
    end

    self
  end

  def my_select(&prc)
    selected = []

    my_each do |el|
      selected << el if prc.call(el)
    end

    selected
  end

  def my_reject(&prc)
    rejected = []

    my_each do |el|
      rejected << el unless prc.call(el)
    end

    rejected
  end

  def my_any?(&prc)
    my_each do |el|
      return true if prc.call(el)
    end
    false
  end

  def my_all?(&prc)
    my_each do |el|
      return false unless prc.call(el)
    end
    true
  end

  def my_zip(*arrs)
    zipped = []
    sub_zip = []

    each_index do |i|
      sub_zip << self[i]

      arrs.each do |arr|
        sub_zip << arr[i]
      end

      zipped << sub_zip
      sub_zip = []
    end

    zipped
  end

  def my_rotate(num = 1)
    rotated = dup

    if num > 0
      num.times { rotated = rotated.push(rotated.shift) }
    else
      num.abs.times { rotated = rotated.unshift(rotated.pop) }
    end

    rotated
  end

  def my_join(str = "")
    inject { |acc, el| acc + str + el }
  end

  def my_reverse
    reversed = []

    each_index do |i|
      reversed << self[-1 - i]
    end

    reversed
  end

  def my_inject(acc = nil)
    i = 0

    if acc.nil?
      acc = first
      i = 1
    end

    (i...size).each do |i|
      acc = yield(acc, self[i])
    end

    acc
  end

  def my_flatten
    flattened = []

    each do |el|
      if el.is_a? Array
        flattened += el.my_flatten
      else
        flattened << el
      end
    end

    flattened
  end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def primes(num)
  return [] if num.zero?
  result = [2]

  (3..Float::INFINITY).each do |n|
    result << n if is_prime?(n)
    return result if result.length == num
  end
end

def is_prime?(num)
  (2...num).none? { |n| num % n == 0 }
end

# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**

def digital_root(num)
  num < 10 ? num : digital_root(num % 10 + digital_root(num / 10))
end

# Return an array of all numbers in the range, excluding max (recursive)

def range(min, max)
  return [] if min == max
  [min].concat(range(min + 1, max))
end

# Write a function sum_to(n) that uses recursion to calculate the sum from
# 1 to n (inclusive of n).

def sum_to(num)
  return nil if num < 0
  return num if num == 1
  num + sum_to(num - 1)
end

# Write a function add_numbers(nums) that takes in an array of Fixnums and
# returns the sum of those numbers. Write this method recursively.

def add_nums(nums)
  return nums.first if nums.length == 1
  sum = nums.shift + add_nums(nums)
end

# Let's write a method that will solve Gamma Function recursively. The Gamma
# Function is defined Γ(n) = (n-1)!.

def gamma_fnc(num)
  return nil if num == 0
  return 1 if num == 1
  (num - 1) * gamma_fnc(num - 1)
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(n)
  return [1] if n == 1

  fact = factorials_rec(n - 1)
  fact << fact.last * (n - 1)
end

def fibs_rec(n)
  return [1, 1].take(n) if n <= 2

  fibs = fibs_rec(n - 1)
  fibs << fibs[-1] + fibs[-2]
end

# return b^n recursively. Accept negative value for n

def exponent(base, exp)
  return 1 if exp == 0

  if exp < 0
    1.0 / (base * exponent(base, exp.abs - 1))
  else
    base * exponent(base, exp - 1)
  end
end

class Array
  def deep_dup
    return self if length == 1
    result = []

    each do |el|
      if el.is_a? Array
        result << el.deep_dup
      else
        result << el.dup
      end
    end

    result
  end

  def subsets
    return [self] if length < 1

    result = []
    orig = dup
    base = orig.pop
    subset = orig.subsets

    subset += subset.map do |el|
      el + [base]
    end

    subset
  end

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    indices = Hash.new { |h, k| h[k] = [] }

    each.with_index do |el, i|
      indices[el] << i
    end

    indices.select { |el, i| i.length > 1 }
  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    substrings.select { |word| word == word.reverse }
  end

  def substrings
    result = []

    (0...length).each do |i|
      (i + 1...length).each do |j|
        result << self[i..j]
      end
    end

    result
  end
end

class Array
  def merge_sort(&prc)
    return self if length <= 1
    prc ||= proc { |a, b| a <=> b }

    mid = length / 2

    left  = self[0...mid].merge_sort(&prc)
    right = self[mid..-1].merge_sort(&prc)

    Array.merge(left, right, &prc)
  end

  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      call_result = prc.call(left.first, right.first)

      if call_result < 0
        merged << left.shift
      else
        merged << right.shift
      end
    end

    merged.concat(left)
    merged.concat(right)
    merged
  end

  def quick_sort(&prc)
    return self if length <= 1
    prc ||= proc { |a, b| a <=> b }

    less, more = [], []
    pivot = last

    (0...length - 1).each do |i|
      call_result = prc.call(pivot, self[i])

      if call_result > 0
        less << self[i]
      else
        more << self[i]
      end
    end

    less.quick_sort(&prc) + [pivot] + more.quick_sort(&prc)
  end

  def bsearch(target, &prc)
    return nil if length < 1
    prc ||= proc { |a, b| a <=> b }

    mid = length / 2

    call_result = prc.call(target, self[mid])

    if call_result == 0
      mid
    elsif call_result < 0
      self[0...mid].bsearch(target, &prc)
    else
      right = self[mid + 1..-1].bsearch(target, &prc)
      right.nil? ? nil : (mid + 1) + right
    end
  end
end
