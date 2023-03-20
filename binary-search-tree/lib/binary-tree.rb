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

  def delete(value, node = @root)
    # three conditions - 
    # 1. Node to be deleted is the leaf - delete the node
    # 2. Node to be deleted has one child - delete the node and copy the child to the node
    # 3. Node to be deleted has two children - delete the node,
      # find the inorder sucessor, delete the inorder successor. 
      # (minimum value of the right side of the node)
    return node if node.nil?

    pointer = node
    p pointer.data

    if value < pointer.data
      pointer.left = delete(value, pointer.left)
    elsif value > pointer.data
      pointer.right = delete(value, pointer.right)
    else
      if pointer.left.nil?
        temp = pointer.right
        pointer = nil
        return temp
      elsif pointer.right.nil?
        temp = pointer.left
        pointer = nil
        return temp
      end

    end


    pointer
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
bst.insert(6)
bst.insert(785)
bst.pretty_print
p bst.delete(6)
bst.pretty_print