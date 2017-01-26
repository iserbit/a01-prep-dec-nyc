require 'rspec'
require 'assessment01'

describe "my_each" do
  res = []
  [1,2,3].my_each{|el| res << 2*el}

  it "It works for blocks" do
    expect(res).to eq([2,4,6])
  end
end

describe "my_each_with_index" do
  res = []
  [1,2,3].my_each_with_index{|el, i| res << 2*el + i}

  it "It works for blocks that use both the index and element" do
    expect(res).to eq([2,5,8])
  end
end

describe 'my_select' do
  a = [1, 2, 3]

  it 'It correctly selects elements according to the passed in block' do
    expect(a.my_select { |num| num > 1 }).to eq([2, 3])
  end

  it 'It returns an empty array if there are no matches' do
    expect(a.my_select { |num| num == 4 }).to eq([])
  end
end

describe 'my_reject' do
  a = [1, 2, 3]

  it 'It correctly selects elements that do not match the passed in block' do
    expect(a.my_reject { |num| num > 1 }).to eq([1])
  end

  it 'It returns all elements if no elements match the block' do
    expect(a.my_reject { |num| num == 4 }).to eq([1,2,3])
  end
end

describe 'my_any' do
  a= [1,2,3]
  it "returns true if any number matches the block" do
    expect(a.my_any? { |num| num > 1 }).to eq(true)
  end

  it "returns false if no elementes match the block" do
    expect(a.my_any? { |num| num == 4 }).to eq(false)
  end
end

describe 'my_all' do
  a= [1,2,3]

  it "returns true if all elements match the block" do
    expect(a.my_all? { |num| num > 0 }).to eq(true)
  end

  it "returns false if not all elementes match the block" do
    expect(a.my_all? { |num| num > 1 }).to eq(false)
  end
end

describe "my_zip" do
  a = [ 4, 5, 6 ]
  b = [ 7, 8, 9 ]

  it 'Zips arrays of the same size' do
    expect([1, 2, 3].my_zip(a, b)).to eq([[1, 4, 7], [2, 5, 8], [3, 6, 9]])
  end

  it 'Zips arrays of differnet sizes and adds nil appropriately' do
    expect(a.my_zip([1,2], [8])).to eq([[4, 1, 8], [5, 2, nil], [6, nil, nil]])
  end

  c = [10, 11, 12]
  d = [13, 14, 15]

  it "Zips arrays with more elements than the original" do
    expect([1, 2].my_zip(a, b, c, d)).to eq([[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]])
  end
end

describe "my_rotate" do
  a = [ "a", "b", "c", "d" ]

  it "Rotates the elements 1 position if no argument is passed in" do
    expect(a.my_rotate).to eq(["b", "c", "d", "a"])
  end

  it "Rotates the elements correctly if an argument is passed in" do
    expect(a.my_rotate(2)).to eq(["c", "d", "a", "b"])
  end

  it "Rotates the elements correctly if a negative argument is passed in" do
    expect(a.my_rotate(-3)).to eq(["b", "c", "d", "a"])
  end

  it "Rotates the elements correctly for a large argument" do
    expect(a.my_rotate(15)).to eq(["d", "a", "b", "c"])
  end
end

describe "my_join" do
  a = [ "a", "b", "c", "d" ]

  it "Joins an array if no argument is passed" do
    expect(a.my_join).to eq("abcd")
  end

  it "Joins an array if an argument is passed" do
    expect(a.my_join("$")).to eq("a$b$c$d")
  end
end

describe "my_reverse" do
  a = [ "a", "b", "c", "d" ]

  it "Reverses an array" do
    expect(a.my_reverse).to eq(a.reverse)
  end
end

describe 'my_inject' do
  it 'calls the block passed to it' do
    expect do |block|
      ["test array"].my_inject(:dummy, &block)
    end.to yield_control.once
  end

  it 'makes the first element the accumulator if no default is given' do
    expect do |block|
      ["el1", "el2", "el3"].my_inject(&block)
    end.to yield_successive_args(["el1", "el2"], [nil, "el3"])
  end

  it 'yields the accumulator and each element to the block' do
    expect do |block|
      [1, 2, 3].my_inject(100, &block)
    end.to yield_successive_args([100, 1], [nil, 2], [nil, 3])
  end

  it 'does NOT call the built in Array#inject or Array#reduce method' do
    original_array = ["original array"]
    expect(original_array).not_to receive(:inject)
    expect(original_array).not_to receive(:reduce)
    original_array.my_inject {}
  end

  it 'with accumulator, it correctly injects and returns answer' do
    expect([1, 2, 3].my_inject(1) { |acc, x| acc + x }).to eq(7)
    expect([3, 3].my_inject(3) { |acc, x| acc * x }).to eq(27)
  end

  it 'without accumulator, it correctly injects and returns answer' do
    expect([1, 2, 3].my_inject { |acc, x| acc + x }).to eq(6)
    expect([3, 3].my_inject { |acc, x| acc * x }).to eq(9)
  end
end

describe "my_flatten" do
  it 'Flattens arrays correctly' do
    expect([1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten).to eq([1, 2, 3, 4, 5, 6, 7, 8])
  end
end

describe "#my_uniq" do
  let(:array) { [1, 2, 1, 3, 4, 2] }

  it "returns the unique elements" do
    expect(array.my_uniq).to eq([1, 2, 3, 4])
  end

  it "does not modify the original array" do
    duped_array = array.dup

    array.my_uniq

    expect(array).to eq(duped_array)
  end

  it "does not call the built-in #uniq method" do
    expect(array).not_to receive(:uniq)

    array.my_uniq
  end
end

describe "Arrays" do
  describe "#two_sum" do
    it "returns positions of pairs of numbers that add to zero" do
      expect([5, 1, -7, -5].two_sum).to eq([[0, 3]])
    end

    it "finds multiple pairs" do
      expect([5, -1, -5, 1].two_sum).to eq([[0, 2], [1, 3]])
    end

    it "finds pairs with same element" do
      expect([5, -5, -5].two_sum).to eq([[0, 1], [0, 2]])
    end

    it "returns [] when no pair is found" do
      expect([5, 5, 3, 1].two_sum).to eq([])
    end

    it "won't find spurious zero pairs" do
      expect([0, 1, 2, 3].two_sum).to eq([])
    end

    it "will find real zero pairs" do
      expect([0, 1, 2, 0].two_sum).to eq([[0, 3]])
    end
  end
end

describe "#primes" do
  it "returns first five primes in order" do
    expect(primes(5)).to eq([2, 3, 5, 7, 11])
  end

  it "returns an empty array when asked for zero primes" do
    expect(primes(0)).to eq([])
  end
end

describe "#digital_root" do
  it "calculates the digital root of a single-digit number" do
    expect(digital_root(9)).to eq(9)
  end

  it "calculates the digital root of a larger number" do
    expect(digital_root(4322)).to eq(2)
  end

  it "does not call #to_s on the argument" do
    expect_any_instance_of(Fixnum).to_not receive(:to_s)
    digital_root(4322)
  end
end

describe "#sum_to" do
  it "calculates the sum to 1" do
    expect(sum_to(1)).to eq(1)
  end

  it "calculates the sum from 1 to 5" do
    expect(sum_to(5)).to eq(15)
  end

  it "calculates the sum from 1 to 9" do
    expect(sum_to(9)).to eq(45)
  end

  it "returns nil when n is a negative number" do
    expect(sum_to(-8)).to eq(nil)
  end

  it "calls itself recursively" do
    expect(self).to receive(:sum_to).at_least(:twice).and_call_original
    sum_to(9)
  end
end

describe "#add_nums" do
  it "returns the sum of an array" do
    expect(add_nums([1, 2, 3, 4])).to eq(10)
  end

  it "returns the sum of an array" do
    expect(add_nums([3, 4, 5])).to eq(12)
  end

  it "calls itself recursively" do
    expect(self).to receive(:add_nums).at_least(:twice).and_call_original
    add_nums([3, 4, 5])
  end
end

describe "#gamma_fnc" do
  it "returns nil for 0" do
    expect(gamma_fnc(0)).to eq(nil)
  end

  it "calculates the gamma function of 1" do
    expect(gamma_fnc(1)).to eq(1)
  end

  it "calculates the gamma function of 4" do
    expect(gamma_fnc(4)).to eq(6)
  end

  it "calculates the gamma function of 8" do
    expect(gamma_fnc(8)).to eq(5040)
  end

  it "calls itself recursively" do
    expect(self).to receive(:gamma_fnc).at_least(:twice).and_call_original
    gamma_fnc(8)
  end
end

describe "#range" do
  it "returns an array of all numbers between the range" do
    expect(range(1, 5)).to eq([1, 2, 3, 4])
  end

  it "returns an array of all numbers between the range" do
    expect(range(3, 7)).to eq([3, 4, 5, 6])
  end

  it "calls itself recursively" do
    expect(self).to receive(:range).at_least(:twice).and_call_original
    range(1, 5)
  end
end

describe "#factorials_rec" do
  it "returns first factorial number" do
    expect(factorials_rec(1)).to eq([1])
  end

  it "returns first two factorial numbers" do
    expect(factorials_rec(2)).to eq([1, 1]) # = [0!, 1!]
  end

  it "returns many factorials numbers" do
    expect(factorials_rec(6)).to eq([1, 1, 2, 6, 24, 120])
    # == [0!, 1!, 2!, 3!, 4!, 5!]
  end

  it "calls itself recursively" do
    expect(self).to receive(:factorials_rec).at_least(:twice).and_call_original
    factorials_rec(6)
  end
end

describe "#fibs_rec" do
  it "returns first Fibonacci number" do
    expect(fibs_rec(1)).to eq([1])
  end

  it "returns first two Fibonacci numbers" do
    expect(fibs_rec(2)).to eq([1, 1]) # = [0!, 1!]
  end

  it "returns many Fibonacci numbers" do
    expect(fibs_rec(6)).to eq([1, 1, 2, 3, 5, 8])
  end

  it "calls itself recursively" do
    expect(self).to receive(:fibs_rec).at_least(:twice).and_call_original
    fibs_rec(6)
  end
end

describe "exponent" do
  it "correctly handles positive powers" do
    expect(exponent(5,3)).to eq(125)
  end

  it "correctly handles negative powers" do
    expect(exponent(2, -3)).to eq(1/8.0)
  end

  it "correctly handles 0" do
    expect(exponent(2, 0)).to eq(1)
  end

  it "calls itself recursively" do
    expect(self).to receive(:exponent).at_least(:twice).and_call_original
    exponent(5,3)
  end
end

describe "deep_dup" do
  robot_parts = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
  ]

  copy = robot_parts.deep_dup

  it "makes a copy of the original array" do
    expect(copy).to eq(robot_parts)
  end

  it "deeply copies arrays" do
    copy[1] << "LEDs"
    expect(robot_parts[1]).to eq(["capacitors", "resistors", "inductors"])
  end
end

# describe 'subsets' do
#   it "Correctly returns all subsets of an array" do
#     expect([1, 2, 3].subsets).to eq([[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]])
#   end
# end

describe "#dups" do
  it "solves a simple example" do
    expect([1, 3, 0, 1].dups).to eq({ 1 => [0, 3] })
  end

  it "finds two dups" do
    expect([1, 3, 0, 3, 1].dups).to eq({ 1 => [0, 4], 3 => [1, 3] })
  end

  it "finds multi-dups" do
    expect([1, 3, 4, 3, 0, 3].dups).to eq({ 3 => [1, 3, 5] })
  end

  it "returns {} when no dups found" do
    expect([1, 3, 4, 5].dups).to eq({})
  end
end

describe "#symmetric_substrings" do

  it "handles a simple example" do
    expect("aba".symmetric_substrings).to match_array(["aba"])
  end

  it "handles two substrings" do
    expect("aba1cdc".symmetric_substrings).to match_array(["aba", "cdc"])
  end

  it "handles nested substrings" do
    expect("xabax".symmetric_substrings).to match_array(["aba", "xabax"])
  end
end

describe "#merge_sort" do
  let(:array) { [1, 2, 3, 4, 5].shuffle }

  it "works with an empty array" do
    expect([].merge_sort).to eq([])
  end

  it "works with an array of one item" do
    expect([1].merge_sort).to eq([1])
  end

  it "sorts numbers" do
    expect(array.merge_sort).to eq(array.sort)
  end

  it "will use block if given" do
    reversed = array.merge_sort do |num1, num2|
      # reverse order
      num2 <=> num1
    end
    expect(reversed).to eq([5, 4, 3, 2, 1])
  end

  it "does not modify original" do
    duped_array = array.dup
    duped_array.merge_sort
    expect(duped_array).to eq(array)
  end

  it "calls the merge helper method" do
    expect(Array).to receive(:merge).at_least(:once).and_call_original
    array.merge_sort
  end
end

describe "quick_sort" do
  a = (0..8).to_a

  it "Sorts an array of numbers with no duplicates" do
    expect(a.shuffle.quick_sort).to eq(a)
  end

  it "Sorts an array of numbers with duplicates" do
    expect([1,2,3,3,9,10,10,17,432].shuffle.quick_sort).to eq([1,2,3,3,9,10,10,17,432])
  end

  it "Sorts according to the block passed in" do
    expect(a.shuffle.quick_sort{|a,b| b<=>a}).to eq(a.reverse)
  end
end

describe "bsearch" do
  it "finds the first element in the array" do
    expect([1, 2, 3].bsearch(1)).to eq(0)
  end

  it "finds an element for an array with an even number of elements" do
    expect([2, 3, 4, 5].bsearch(3)).to eq(1)
  end

  it "finds an element for an array with an odd number of elements" do
    expect([2, 4, 6, 8, 10].bsearch(6)).to eq(2)
  end

  it "finds an element in the second half of the array (even)" do
    expect([1, 3, 4, 5, 9].bsearch(5)).to eq(3)
  end

  it "finds an element in the second half of the array (odd)" do
    expect([1, 2, 3, 4, 5, 6].bsearch(6)).to eq(5)
  end

  it "Returns nil if the element is not in the array (smaller)" do
    expect([1, 2, 3, 4, 5, 6].bsearch(0)).to eq(nil)
  end

  it "Returns nil if the element is not in the array (bigger)" do
    expect([1, 2, 3, 4, 5, 7].bsearch(6)).to eq(nil)
  end

end
