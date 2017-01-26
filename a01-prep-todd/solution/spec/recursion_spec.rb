require 'rspec'
require 'spec_helper'
require 'recursion'

describe "Recursion" do
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
      # this should enforce you calling your method recursively.
      expect(self).to receive(:factorials_rec).at_least(:twice).and_call_original
      factorials_rec(6)
    end
  end

  describe "#range" do
    it "returns an array of numbers between start and end" do
      expect(range(1,10)).to eq([2,3,4,5,6,7,8,9])
    end

    it "returns one number if end = start + 2" do
      expect(range(3,5)).to eq([4])
    end

    it "returns an empty array if end = start + 1" do
      expect(range(3,4)).to eq([])
    end

    it "returns an empty array if end < start" do
      expect(range(5,4)).to eq([])
    end
  end

  describe "#sum" do
    it "returns the sums of all elements in an array" do
      arr = [1,2,3,4]
      expect(sum(arr)).to eq(10)
    end

    it "returns 0 if the array is empty" do
      expect(sum([])).to eq(0)
    end
  end

  describe "#exp" do
    it "returns the exponentiation of an odd power" do
      expect(exp(2, 3)).to eq(8)
    end

    it "returns the exponentiation of an even power" do
      expect(exp(2, 4)).to eq(16)
    end

    it "returns the exponentiation of 0 ** power" do
      expect(exp(0, 2)).to eq(0)
    end

    it "returns the exponentiation of base ** 0" do
      expect(exp(4, 0)).to eq(1)
    end

    it "returns the exponentiation of 0 ** 0" do
      expect(exp(0, 0)).to eq(1)
    end
  end

  describe "#deep_dup" do
    robot_parts = [
      ["nuts", "bolts", "washers"],
      ["capacitors", "resistors", "inductors"]
    ]
    robot_parts_dup = robot_parts.dup
    robot_parts_deep_dup = robot_parts.deep_dup

    robot_parts_deep_dup[0] << "LEDs"

    it "creates a deep duplicate of an array" do
      expect(robot_parts_deep_dup).to eq([
        ["nuts", "bolts", "washers", "LEDs"],
        ["capacitors", "resistors", "inductors"]
      ])
    end

    it "doesn't modify the original array" do
      expect(robot_parts_dup).to eq([
        ["nuts", "bolts", "washers"],
        ["capacitors", "resistors", "inductors"]
      ])
    end
  end

  describe "#fibs_rec" do
    it "returns one fib" do
      expect(fibs_rec(1)).to eq([0])
    end

    it "returns two fibs" do
      expect(fibs_rec(2)).to eq([0,1])
    end

    it "returns many fibs" do
      expect(fibs_rec(7)).to eq([0,1,1,2,3,5,8])
    end
  end

  describe "#subsets" do
    it "returns an empty subset" do
      expect([].subsets).to eq([[]])
    end

    it "returns an one subset" do
      expect([1].subsets).to eq([[], [1]])
    end

    it "returns subsets" do
      expect([1, 2].subsets).to eq([[], [1], [2], [1, 2]])
    end

    it "returns many subsets" do
      expect([1,2,3].subsets).to eq([[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]])
    end
  end

  describe "#permutations" do
    it "returns all permutations of an array" do
      expect(permutations([1, 2, 3])).to eq([[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]])
    end
  end

  describe "#make_change" do
    it "returns change" do
      expect(make_change(76, [25, 10, 5, 1])).to eq([25, 25, 25, 1])
    end

    it "returns best change" do
      expect(make_change(24, [10, 7, 7])).to eq([10, 7, 7])
    end
  end

  describe "#stringify" do
    it "stringifies numbers in base 10" do
      expect(5.stringify(10)).to eq("5")
      expect(10.stringify(10)).to eq("10")
      expect(42.stringify(10)).to eq("42")
    end

    it "stringifies numbers in base 2" do
      expect(5.stringify(2)).to eq("101")
      expect(10.stringify(2)).to eq("1010")
      expect(42.stringify(2)).to eq("101010")
    end

    it "stringifies numbers in base 16" do
      expect(5.stringify(16)).to eq("5")
      expect(10.stringify(16)).to eq("a")
      expect(42.stringify(16)).to eq("2a")
    end
  end

  describe '#first_even_numbers_sum' do

    it "returns the sum of the first even number" do
      expect(first_even_numbers_sum(1)).to eq(2)
    end

    it "returns the sum of the first n even numbers" do
      expect(first_even_numbers_sum(6)).to eq(42)
    end
  end
end
