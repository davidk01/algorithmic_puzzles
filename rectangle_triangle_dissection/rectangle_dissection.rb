# We are going to represent the rewrite rules as transformations of leaf nodes
# in a tree. To get the resulting strings we just tecursively enumerate all paths
# leading to a leaf node.

##
# Each tree node can have any number of children so we assume
# that the immediate children are in an array.

class TreeNode < Struct.new(:node_value, :children)

  def apply_rules
    if children.any?
      raise StandardError, "Transformations can only be applied to leaf nodes."
    end
    case node_value
    when 'R' # R -> RR | SR | TT
      children = [TreeNode.new('R', []), TreeNode.new('S', [])]
    when 'S' # S -> SSSS | TT | TTT | TTTT
      leaf = TreeNode.new('S', [])
    else
      raise StandardError, "No applicable rule found for node value: #{node_value}."
    end
  end

end

class RewriteRules

  def initialize(seed = 'R')
    @root = TreeNode.new(seed, [])
    @frontier = @root.children
  end

  def expand_frontier
  end

end
