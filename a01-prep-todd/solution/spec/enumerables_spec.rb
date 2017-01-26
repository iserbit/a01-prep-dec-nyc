require 'rspec'
require 'spec_helper'
require 'enumerables'

describe "Enumerables" do
  describe "#factors" do
    it "returns factors of 10 in order" do
      expect(factors(10)).to eq([1, 2, 5, 10])
    end

    it "returns just two factors for primes" do
      expect(factors(13)).to eq([1, 13])
    end
  end

  describe "#doubler" do
    let(:array) { [1, 2, 3] }

    it "doubles the elements of the array" do
      expect(doubler(array)).to eq([2, 4, 6])
    end

    it "does not modify the original array" do
      duped_array = array.dup

      doubler(array)

      expect(array).to eq(duped_array)
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

  describe 'my_select' do
    a = [1, 2, 3]
    it 'It correctly selects elements according to the passed in block' do
      expect(a.my_select { |num| num > 1 }).to eq([2, 3])
    end

    it 'It returns an empty array if there are no matches' do
      expect(a.my_select { |num| num == 4 }).to eq([])
    end
  end

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


  describe "my_flatten" do
    it 'Flattens arrays correctly' do
      expect([1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten).to eq([1, 2, 3, 4, 5, 6, 7, 8])
    end
  end

  describe "my_controlled_flatten" do
    it "Flattens an array the specified number of levels" do
      expect([1,[2,3], [4,[5]], [[6,[7]]]].my_controlled_flatten(1)).to eq([1,2,3,4,[5], [6, [7]]])
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
end
