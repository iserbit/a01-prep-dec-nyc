#### Searches && Sorts ####

class Array
  def bubble_sort!
    # Without a proc
    sorted = false
    until sorted
      sorted = true

      each_index do |i|
        next if i + 1 == self.length
        j = i + 1
        if self[i] > self[j]
          sorted = false
          self[i], self[j] = self[j], self[i]
        end
      end
    end

    self
  end

  def bubble_sort!(&prc)
    # With a proc
    prc ||= Proc.new { |x, y| x <=> y }

    sorted = false
    until sorted
      sorted = true

      each_index do |i|
        next if i + 1 == self.length
        j = i + 1
        if prc.call(self[i], self[j]) == 1
          sorted = false
          self[i], self[j] = self[j], self[i]
        end
      end
    end

    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end

  def merge_sort(&prc)
    # See how I create a Proc if no block was given; this eliminates
    # having to later have two branches of logic, one for a block and
    # one for no block.
    prc ||= Proc.new { |x, y| x <=> y }

    return self if count <= 1

    midpoint = count / 2
    sorted_left = self.take(midpoint).merge_sort(&prc)
    sorted_right = self.drop(midpoint).merge_sort(&prc)

    Array.merge(sorted_left, sorted_right, &prc)
  end

  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1
        merged << left.shift
      when 0
        merged << left.shift
      when 1
        merged << right.shift
      end
    end

    merged.concat(left)
    merged.concat(right)

    merged
  end


  def my_quick_sort(&prc)
    prc ||= proc {|a, b| a<=>b}
    return self if size < 2

    pivot = first
    left = self[1..-1].select{|el| prc.call(el, pivot) == -1}
    right = self[1..-1].select{|el| prc.call(el, pivot) != -1}

    left.my_quick_sort(&prc) + [pivot] + right.my_quick_sort(&prc)
  end

  def my_bsearch(target, &prc)
    return nil if size == 0
    prc ||= proc {|a, b| a <=> b}

    mid = size/2

    case prc.call(self[mid], target)
    when 0
      return mid
    when 1
      return self.dup.take(mid).my_bsearch(target, &prc)
    else
      search_res = self.dup.drop(mid+1).my_bsearch(target, &prc)
      search_res.nil? ? nil : mid + 1 + search_res
    end
  end
end
