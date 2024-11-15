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
  attr_accessor :root
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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value) # does not allow dupliactes
    new_node = Node.new(value)
    current_node = @root
    while current_node.left != nil || current_node.right != nil
      if value < current_node.value
        current_node = current_node.left
      elsif value > current_node.value
        current_node = current_node.right
      end
    end
    current_node.left = new_node if value < current_node.value
    current_node.right = new_node if value > current_node.value
  end

  def delete(root = @root, value)
    return root if root.nil?
    # searches for the node wanted first
    if root.value < value
      root = delete(root.right, value)
    elsif root.value > value
      root = delete(root.left, value)
    end
  end
end
array = [1, 2, 3, 4, 5, 6, 7]
tree = Tree.new(array)
tree.insert(10)
p tree.pretty_print

# search for node wanted to be deleted, if not found return nil