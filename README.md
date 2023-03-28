# binary-search-tree

Binary trees were invented to make searching faster. Instead of traversing an entire array, or singly-linked-list, one could traverse a doubly-linked-list, or binary tree, in a much faster manner. 
The binary tree is created from a sorted array. Once the tree is created, it can be searched in O(log n), rather than O(n).

## node.rb

The node file contains the Node class, which creates the nodes in the binary tree

## binary-tree.rb

The binary-tree file contains the Tree class, which builds the binary tree, and contains all the methods to work with the tree.

### initialize

The binary tree is initialized from a sorted array of unique numbers.
The tree is built from the root with the build_tree method.

### build_tree

The tree is built recursively, where numbers below the mid-point of a given number are placed to the left, and numbers to the right of the mid-point are placed to the right.

### insert

This method traverses the tree recursively, finding the right spot to insert a given number.

### find_max

This method finds the right-most number.

### find_min

This method finds the left-most number.

### delete

Deletes a given node under these conditions
1. If the node is at a leaf node, delete the node.
2. If the node has one child, deleted the node and copy the child to the node.
3. If the node has two children, deleted the node, find the inorder successor and copy the inorder successor to the node.

### find

Returns a node contaning the value in the method call.

### level_order

Returns values in an array in level order. Can take an optional block.

### current_level

Helper method for level_order method.

### inorder

Returns values in an array in numberical order, can take optional block.

### preorder

Returns values in an array in pre-order, can take optional block.

### postorder

Returns values in an array in post-order, can take optional block.

### height

Returns the height of given node from the farthest leaf node.

### depth

Returns the depth of a value from a node from the root node.

### balanced?

Returns boolean whether or not the tree is balanced. I.e., the right sub-tree should not be more than one level different than the left sub-tree.

### rebalance

Rebuilds the binary tree using in-order traversal. Checks for duplicates.

### pretty_print

Method given from the project to print the binary tree in an attractive manner.