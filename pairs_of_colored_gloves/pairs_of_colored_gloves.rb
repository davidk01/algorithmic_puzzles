class GloveSet < Struct.new(:left_count, :right_count)

  def subsets
    (0..left_count).flat_map do |i|
      (0..right_count).map {|j| self.class.new(i, j)}
    end
  end

  def element_count
    left_count + right_count
  end

  def contains_pair?
    left_count > 0 && right_count > 0
  end

end

class BlackGloveSet < GloveSet
end

class BrownGloveSet < GloveSet
end

class GrayGloveSet < GloveSet
end

##
# Enumerate pairs of elements from two finite iterable collections. Technically
# the way I've written it only the second collection needs to be finite.

class ProductEnumerator < Struct.new(:first, :second)

  def each
    if @cache
      @cache.each {|el| yield el}
    else
      @cache = []
      first.each do |f|
        second.each {|s| @cache << [f, s]; yield [f, s]}
      end
    end
  end

end

black_gloves = BlackGloveSet.new(5, 5)
brown_gloves = BrownGloveSet.new(3, 3)
gray_gloves = GrayGloveSet.new(2, 2)
subsets = ProductEnumerator.new(black_gloves.subsets, 
 ProductEnumerator.new(brown_gloves.subsets, gray_gloves.subsets))

##
# As explained in the solution strategy we need to find maximal elements among the subsets
# with no pairs and two pairs to find answers to a) and b).

no_pairs_maximal_count, two_pairs_maximal_count = 0, 0
subsets.each do |subset|
  triple = subset.flatten
  size = triple.reduce(0) {|m, s| m + s.element_count}
  case triple.reduce(0) {|m, s| s.contains_pair? ? m + 1 : m}
  when 0
    no_pairs_maximal_count = [size, no_pairs_maximal_count].max
  when 2
    two_pairs_maximal_count = [size, two_pairs_maximal_count].max
  end
end

puts "To guarantee one pair one must select at least #{no_pairs_maximal_count + 1} gloves."
puts "To guarantee three pairs one must select at least #{two_pairs_maximal_count + 1} gloves."
