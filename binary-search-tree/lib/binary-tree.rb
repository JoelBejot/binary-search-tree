require './node.rb'
require 'pry'

class Tree
  attr_accessor :root, :data

  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(@data)
  end

  def build_tree(array)
    return nil if array.empty?
    
    p array
    mid = (array.length - 1) / 2
    node = Node.new(array[mid])
    p "root node #{node.data}"
    node.left = build_tree(array[0...mid])
    p "left node #{node.data}"
    node.right = build_tree(array[mid+1..-1])
    p "right node #{node.data}"
  
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
bst = Tree.new(array)
#bst.pretty_print