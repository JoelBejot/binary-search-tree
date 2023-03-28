require './binary-tree.rb'
require './node.rb'

# Driver program that tests the methods of the binary tree
p "Creating a new Binary Search Tree..."
array = (Array.new(15) { rand(1..100) })
bst = Tree.new(array)
puts ""
p "Is the tree balanced?"
p bst.balanced?

puts ""
p "Here they are in order:"
p "Level order: #{bst.level_order}"
p "Preorder: #{bst.preorder}"
p "Postorder: #{bst.postorder}"
p "Inorder: #{bst.inorder}"

puts ""
p "Let's add several numbers to the tree..."
puts ""
puts ""

15.times do |num| 
  num = rand(101..1000)
  bst.insert(num) 
end

p "Is the tree still balanced?"
p bst.balanced?
puts ""
p "Let's rebalance it."
p "Rebalancing..."
bst.rebalance
puts ""
p "Now is it balanced?"
p bst.balanced?
puts ""
p "Here they are again in order:"
p "Level order: #{bst.level_order}"
p "Preorder: #{bst.preorder}"
p "Postorder: #{bst.postorder}"
p "Inorder: #{bst.inorder}"