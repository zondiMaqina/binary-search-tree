require_relative 'merge_sort'

class Node
  attr_accessor :value, :left, :right
  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end

class Tree
  def initialize(array)
    @root = build_tree(array, 0, array.size - 1)
  end

  def build_tree(array, start, endpoint)
    return nil if array.empty?
    return nil if start > endpoint
    sorted_array = MergeSort.new.merge_sort(array).uniq # returns sorted array with no duplicates
    mid = (start + endpoint) / 2
    root = Node.new(array[mid]) # creates new node
    root.left = build_tree(sorted_array, start, mid - 1)
    root.right = build_tree(sorted_array, mid + 1, endpoint)
    return root
  end
end
array = [1, 2, 3, 4]
tree = Tree.new(array)
p tree