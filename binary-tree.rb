require './node'

# This module condtains all the methods for determining the order of a binary tree.
module OrderMethods
  # Returns values in an array in level order. Can take an optional block
  def level_order(node = root, result = [], &block)
    return nil if node.nil?

    h = height(node)
    i = 0
    while i <= (h + 1)
      current_level(i, result, node, &block)
      i += 1
    end
    result
  end

  # Helper method for level_order method
  def current_level(level, result, node = root, &block)
    return if node.nil?

    if level == 1
      result.push(block_given? ? block.call(node) : node.data)
    elsif level > 1
      current_level(level - 1, result, node.left, &block)
      current_level(level - 1, result, node.right, &block)
    end
  end

  # Returns values in numerical order, can take optional block
  def inorder(node = root, result = [], &block)
    return if node.nil?

    inorder(node.left, result, &block)
    result.push(block_given? ? block.call(node) : node.data)
    inorder(node.right, result, &block)

    result
  end

  # Returns values in pre-order, can take optional block
  def preorder(node = root, result = [], &block)
    return if node.nil?

    result.push(block_given? ? block.call(node) : node.data)
    preorder(node.left, result, &block)
    preorder(node.right, result, &block)

    result
  end

  # Returns values in post-order, can take optional block
  def postorder(node = root, result = [], &block)
    return if node.nil?

    preorder(node.left, result, &block)
    preorder(node.right, result, &block)
    result.push(block_given? ? block.call(node) : node.data)

    result
  end
end

# This module contains only the method pretty_print given by the assignment.
module PrettyPrint
  # Method given from the project to print the binary tree in an attractive manner
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# Builds the whole tree and contains tree methods
class Tree
  include OrderMethods
  include PrettyPrint

  attr_accessor :root

  # Builds tree from sorted array of unique numbers
  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  # Most methods are recursive, requiring nil checks and base cases
  # Builds binary tree from sorted array
  def build_tree(array)
    return nil if array.empty?
    return Node.new(array[0]) if array.length <= 1

    mid = (array.length - 1) / 2
    node = Node.new(array[mid])

    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[mid + 1..-1])
    node
  end

  # Inserts value into tree
  def insert(value, node = @root)
    return @root = Node.new(value) if @root.nil?

    if value < node.data
      node.left ? insert(value, node.left) : node.left = Node.new(value)
    else
      node.right ? insert(value, node.right) : node.right = Node.new(value)
    end
    node
  end

  # Returns maximum number in tree
  def find_max(node = root)
    return node if node.nil?
    return node if node.right.nil?

    find_max(node.right)
  end

  # Returns minimum number in tree
  def find_min(node = root)
    return node if node.nil?
    return node if node.left.nil?

    find_min(node.left)
  end

  # Removes value from tree and copies children if necessary
  # three conditions -
  # 1. Node to be deleted is the leaf - delete the node
  # 2. Node to be deleted has one child - delete the node and copy the child to the node
  # 3. Node to be deleted has two children - delete the node,
  # find the inorder sucessor, copy the inorder successor to the current node
  def delete(value, node = root)
    return nil if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    elsif node.left && node.right
      min_of_right_subtree = find_min(node.right)
      node.data = min_of_right_subtree.data
      node.right = delete(min_of_right_subtree.data, node.right)
    elsif !node.left.nil?
      node = node.left
    elsif !node.right.nil?
      node = node.right
    else
      node = nil
    end
    node
  end

  # Returns the node that contains the value in the method call
  def find(value, node = root)
    return nil if node.nil?

    if value < node.data
      find(value, node.left)
    elsif value > node.data
      find(value, node.right)
    else
      node
    end
  end

  # Returns the height of given node from the farthest leaf node
  def height(node = root, counter = -1)
    return counter if node.nil?

    counter += 1

    [height(node.left, counter), height(node.right, counter)].max
  end

  # Returns the depth of a value from a node from the root node
  def depth(value, node = root, counter = 0)
    return nil if node.nil?

    if value < node.data
      counter += 1
      depth(value, node.left, counter)
    elsif value > node.data
      counter += 1
      depth(value, node.right, counter)
    else
      counter
    end
  end

  # Returns boolean whether or not the tree is balanced.
  # I.e., the right sub-tree is not more than one level different than the left sub-tree
  def balanced?(node = root)
    return true if node.nil?

    left = height(@root.left, 0)
    right = height(@root.right, 0)
    (left - right).between?(-1, 1)
  end

  # Rebuilds the binary tree using in-order traversal. Checks for duplicates
  def rebalance
    new_array = inorder.uniq
    @root = build_tree(new_array)
  end
end
