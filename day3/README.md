# Some Definitions

binary-search-tree property:

 - the left subtree of a node contains only nodes with keys less than the
   node's key, and

 - the right subtree of a node contains only nodes with keys greater than
   the node's key

a rotation is best described pictorally:

       x                                  y
     /   \     ====left rotate===>      /   \
    α     y                            x      γ
        /   \  <===right rotate===   /   \
       β     γ                      α      β

rotations preserve the binary-search-tree property.
