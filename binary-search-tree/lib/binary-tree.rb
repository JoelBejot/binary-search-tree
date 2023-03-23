require './node.rb'
require 'pry'

# Builds the whole tree and contains tree methods
class Tree
  attr_accessor :root

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  def build_tree(array)
    return nil if array.empty?
    return Node.new(array[0]) if array.length <= 1
    
    mid = (array.length - 1) / 2
    node = Node.new(array[mid])

    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[mid+1..-1])
  
    node
  end

  def insert(value, node = @root)
    return @root = Node.new(value) if @root.nil? 

    if value < node.data
      if node.left
        insert(value, node.left)
      else
        node.left = Node.new(value)
      end
    else
      if node.right
        insert(value, node.right)
      else
        node.right = Node.new(value)
      end
    end
    node
  end

  def find_max(node = self.root)
    return node if node.nil?
    if node.right == nil
      return node
    end
    return find_max(node.right)
  end

  def find_min(node = self.root)
    return node if node.nil?
    if node.left == nil
      return node
    end
    return find_min(node.left)
  end

  def delete(value, node = self.root)
    # three conditions - 
    # 1. Node to be deleted is the leaf - delete the node
    # 2. Node to be deleted has one child - delete the node and copy the child to the node
    # 3. Node to be deleted has two children - delete the node,
      # find the inorder sucessor, copy the inorder successor to the current node
    return nil if node.nil?
    pointer = node

    if value < pointer.data
      pointer.left = delete(value, pointer.left)
    elsif value > pointer.data
      pointer.right = delete(value, pointer.right)
    else
      if pointer.left && pointer.right
        min_of_right_subtree = find_min(pointer.right)
        pointer.data = min_of_right_subtree.data
        pointer.right = delete(min_of_right_subtree.data, pointer.right)
      elsif pointer.left != nil
        pointer = pointer.left
      elsif pointer.right != nil
        pointer = pointer.right
      else
        pointer = nil
      end
    end
    return pointer
  end

  def find(value, node = self.root)
    return nil if node.nil?
    
    if value < node.data
      find(value, node.left)
    elsif value > node.data
      find(value, node.right)
    else
      return node
    end
  end

  def level_order

  end

  def inorder(node = self.root, result = [], &block)
    return if node.nil?

    inorder(node.left, result, &block)
    result.push(block_given? ? block.call(node) : node.data)
    inorder(node.right, result, &block)

    result
  end

  def preorder(node = self.root, result = [], &block)
    return if node.nil?

    result.push(block_given? ? block.call(node) : node.data)
    preorder(node.left, result, &block)
    preorder(node.right, result, &block)

    result
  end

  def postorder(node = self.root, result = [], &block)
    return if node.nil?

    preorder(node.left, result, &block)
    preorder(node.right, result, &block)
    result.push(block_given? ? block.call(node) : node.data)

    result
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
bst = Tree.new(array)
bst.pretty_print
p bst.inorder { |node| node.data * 2 }
p bst.preorder { |node| node.data ** 2 }
p bst.postorder { |node| node.data * 10 }