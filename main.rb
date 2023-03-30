# frozen_string_literal: true

require './binary-tree'
require './node'

# Driver program that tests the methods of the binary tree
p 'Creating a new Binary Search Tree...'
array = (Array.new(15) { rand(1..100) })
bst = Tree.new(array)
puts ''
p 'Is the tree balanced?'
p bst.balanced?

p 'Find the max number'
p bst.find_max.data
max = bst.find_max.data
p "Let's delete the max number"
bst.delete(max)

puts ''
p 'Here they are in order:'
p "Level order: #{bst.level_order}"
p "Preorder: #{bst.preorder}"
p "Postorder: #{bst.postorder}"
p "Inorder: #{bst.inorder}"

puts ''
p "Let's add several numbers to the tree..."
puts ''
puts ''

15.times do |num|
  num = rand(101..1000)
  bst.insert(num)
end

p 'Is the tree still balanced?'
p bst.balanced?
puts ''
p "Let's rebalance it."
p 'Rebalancing...'
bst.rebalance
puts ''
p 'Now is it balanced?'
p bst.balanced?
puts ''
p 'Here they are again in order:'
p "Level order: #{bst.level_order}"
p "Preorder: #{bst.preorder}"
p "Postorder: #{bst.postorder}"
p "Inorder: #{bst.inorder}"

p 'And here is the tree in pretty_print:'
bst.pretty_print
