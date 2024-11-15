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

  def get_replacement(current_node)
    current_node = current_node.right
    while current_node != nil && current_node.left != nil
      current_node = current_node.left
    end
    current_node
  end
  
  def delete(root = @root, value)
      return root if root.nil? # Base case: If the root is nil, return nil

      if root.value > value
        root.left = delete(root.left, value)
      elsif root.value < value
        root.right = delete(root.right, value)
      else
        if root.left.nil? # Case 1: No left child, return right subtree
          return root.right
        elsif root.right.nil? # Case 2: No right child, return left subtree
          return root.left
        else
          # Case 3: Both children present, find the inorder successor
          succ = get_replacement(root)
          root.value = succ.value
          root.right = delete(root.right, succ.value)
        end
      end
      return root
  end

  def find(root = @root, value)
    return root if root.nil?
    if root.value < value
      root = find(root.right, value)
    elsif root.value > value
      root = find(root.left, value)
    end
    return root
  end

  def level_order(root = @root, queue = [], visited = false)
    return if queue.empty? && visited == true
    
    queue << root if visited == false
    puts queue[0].value
    queue << root.left if root.left != nil
    queue << root.right if root.right != nil
    queue.shift
    level_order(queue[0], queue, true)
  end

  def in_order(root = @root)
    if root == nil
      return
    end
    in_order(root.left) # starts with fursthest left node (left sub-tree)
    puts root.value # prints node
    in_order(root.right) # goes to right sub-tree
  end


  def pre_order(root = @root)
    if root == nil
      return
    end
    puts root.value # takes root as first node
    pre_order(root.left) # goes to left sub-tree
    pre_order(root.right) # goes to right sub-tree
  end

  def post_order(root = @root)
    if root == nil
      return
    end
    post_order(root.left) # goes to left sub-tree
    post_order(root.right) # goes to right sub-tree
    puts root.value 
  end

  def height(node, height = 0)
    if node == nil
      return -1
    end
    left_height = height(node.left, height + 1)
    right_height = height(node.right, height + 1)
    [left_height, right_height].max + 1
  end
end

array = [1, 2, 3, 4, 5, 6, 10, 11]
tree = Tree.new(array)
