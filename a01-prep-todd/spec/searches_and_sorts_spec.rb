require 'rspec'
require 'spec_helper'
require 'searches_and_sorts'

describe "Searches && Sorts" do
  describe "#bubble_sort!" do
    let(:array) { [1, 2, 3, 4, 5].shuffle }

    it "works with an empty array" do
      expect([].bubble_sort!).to eq([])
    end

    it "works with an array of one item" do
      expect([1].bubble_sort!).to eq([1])
    end

    it "sorts numbers" do
      expect(array.bubble_sort!).to eq(array.sort)
    end

    it "modifies the original array" do
      duped_array = array.dup
      array.bubble_sort!
      expect(duped_array).not_to eq(array)
    end

    it "will use a block if given" do
      sorted = array.bubble_sort! do |num1, num2|
        # order numbers based on descending sort of their squares
        num2**2 <=> num1**2
      end

      expect(sorted).to eq([5, 4, 3, 2, 1])
    end
  end

  describe "#bubble_sort" do
    let(:array) { [1, 2, 3, 4, 5].shuffle }

    it "delegates to #bubble_sort!" do
      expect_any_instance_of(Array).to receive(:bubble_sort!)

      array.bubble_sort
    end

    it "does not modify the original array" do
      duped_array = array.dup
      array.bubble_sort
      expect(duped_array).to eq(array)
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

  describe "my_quick_sort" do

    a = (0..8).to_a

    it "Sorts an array of numbers with no duplicates" do
      expect(a.shuffle.my_quick_sort).to eq(a)
    end

    it "Sorts an array of numbers with duplicates" do
      expect([1,2,3,3,9,10,10,17,432].shuffle.my_quick_sort).to eq([1,2,3,3,9,10,10,17,432])
    end

    it "Sorts according to the block passed in" do
      expect(a.shuffle.my_quick_sort{|a,b| b<=>a}).to eq(a.reverse)
    end
  end

  describe "my_bsearch" do

    it "finds the first element in the array" do
      expect([1, 2, 3].my_bsearch(1)).to eq(0)
    end

    it "finds an element for an array with an even number of elements" do
      expect([2, 3, 4, 5].my_bsearch(3)).to eq(1)
    end

    it "finds an element for an array with an odd number of elements" do
      expect([2, 4, 6, 8, 10].my_bsearch(6)).to eq(2)
    end

    it "finds an element in the second half of the array (even)" do
      expect([1, 3, 4, 5, 9].my_bsearch(5)).to eq(3)
    end

    it "finds an element in the second half of the array (odd)" do
      expect([1, 2, 3, 4, 5, 6].my_bsearch(6)).to eq(5)
    end

    it "Returns nil if the element is not in the array (smaller)" do
      expect([1, 2, 3, 4, 5, 6].my_bsearch(0)).to eq(nil)
    end

    it "Returns nil if the element is not in the array (bigger)" do
      expect([1, 2, 3, 4, 5, 7].my_bsearch(6)).to eq(nil)
    end

    it "Accepts a comparison block" do
      expect([1, 2, 3, 4, 5, 7].my_bsearch(6){|a,b| a*3 <=> b}).to eq(1)
    end
  end
end
