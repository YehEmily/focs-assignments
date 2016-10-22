
# FOCS Homework 15, for Day 15

You may edit your answers into this file, or add a separate file in the same directory.

If you add a separate file, please include the following at the top:

```
Student Name: Frankly Olin [change to your name]
Check one:
[ ] I completed this assignment without assistance or external resources.
[X] I completed this assignment with assistance from ___
   and/or using these external resources: Cal Poly Pomona's CS241 lecture notes
```


## I. Binary search tree ordering


Assume that the following tree structures are all properly constructed binary search trees, preserving the binary search property that any (internal) node's left child is smaller than the internal node and its right child is larger (or of equal value).  

Anything labeled with a T can be assumed to be a (possibly empty) subtree (i.e., may contain zero or more nodes); anything labeled with a lower case letter is a single node.

What inequalities must hold in each of these trees?

### 0.
```
        a
       / \
      /   \
    T1     T2
```

ANSWER:  all elements of TI <= x <= all elements of T2 // Shouldn't this be all elements of T1 <= a <= all elements of T2? Does it not matter?

### 1.
```
        b
       / \
      /   \
     c     T3
    / \
   /   \
 T1    T2
```

ANSWER: all elements of T1 <= c <= all elements of T2 <= b <= all elements of T3


### 2.
```
        d
       / \
      /   \
    T1     e
          / \
         /   \
       T2    T3
```

ANSWER: all elements of T1 <= d <= all elements of T2 <= all elements of e <= all elements of T3



### 3.
```
        f
       / \
      /   \
     g     T4
    / \
   /   \
 T1     h
       / \
      /   \
    T2     T3
```

Ans: all elements of T1 <= g <= all elements of T2 <= h <= all elements of T3 <= f <= all elements of T4



## II.  Extending this analogy:  drawing trees.

### 4. 

What other tree structures containing three internal nodes -- x, y, and z -- can exist?  Draw these and describe the inequalities that exist among the internal nodes and their subtrees. 
[Hint:  There should be four more shapes.] 
The relationship among x, y, and z doesn't matter.  For convenience, we've arbitrarily labeled them top to bottom and the subtrees left to right.

EXHIBIT A:
```
           x
          / \
         /   \
        y     T3
       / \
      /   \
     z     T2
    / \
   /   \
  T1   T4
```

T1 <= z <= y <= T2 <= x <= T3

EXHIBIT B:
```
          x
        /   \
       /     \
      y       z
     / \     / \
    /   \   /   \
   T1   T2 T3   T4
```

T1 <= y <= T2 <= x <= T3 <= z <= T4

EXHIBIT C:
```
         x
        / \
       /   \
      T1    y
           / \
          /   \
         z    T2
        / \
       /   \ 
      T3   T4
```

T1 <= x <= T3 <= z <= T4 <= y <= T2

EXHIBIT D:
```
         x
        / \
       /   \
      T1    y
           / \
          /   \
         T2    z
              / \
             /   \
            T3   T4
```
 
T1 <= x <= T2 <= y <= T3 <= z <= T4


## III.  Observing balance

It is desirable for binary search trees to be balanced (or close).  If we assume that each of the T structures has the same depth, the two-internal-node trees have the following property:

For EVERY internal node (x and y), the depth of the internal node's left subtree and the depth of the internal node's right subtree differ by at most 1.  We call these trees almost-balanced.  


### 5. 

Does this property hold for any of the three-internal-node trees?  Which ones?  Which ones are NOT almost-balanced?  (We call these unbalanced.)

ANSWER:
* The tree in question 3 is unbalanced because f's left subtree has a depth of 3, while its right subtree has a depth of 1.
* The tree in question 4, exhibit A is also unbalanced because x's left subtree has a depth of 3, while its right subtree has a depth of 1.
* The tree in question 4, exhibit B is balanced! So I think this property holds for this tree.
* The tree in question 4, exhibit C is unbalanced because x's right subtree has a depth of 3, while its left subtree has a depth of 1.
* The tree in question 4, exhibit D is also unbalanced because x's right subtree has a depth of 3, while its left subtree has a depth of 1.


## IV.  Maintaining balance

Observe the following:

If you are given a binary tree of the form in question 1, you can transform them into the form in question 2 (and vice versa) while preserving the binary search property. 
[Since they are both almost-balanced, this doesn't help, but it also doesn't hurt.] 

### 6. 

Use this insight to show how to modify each of the unbalanced tree forms with three internal nodes into an almost-balanced tree that preserves the binary search property.

ANSWER: Hm, I don't know if I fully understand this insight. Does this mean we can rearrange the binary trees, like this?

The tree from 3:
```
        f                      h
       / \                   /   \
      /   \                 /     \
     g     T4      -->     g       f
    / \	                  / \     / \
   /   \                 /   \   /   \
 T1     h               T1   T2 T3   T4
       / \
      /   \
    T2     T3
```


The tree from 4, exhibit A: (Oh cool, I can basically just rotate this tree to get a balanced tree!)
```
           x                     y
          / \                  /   \
         /   \                /     \
        y     T3    -->      z       x
       / \                  / \     / \
      /   \                /   \   /   \
     z     T2             T1   T4 T2   T3
    / \
   /   \
  T1   T4
```


The tree from 4, exhibit C:
```
         x                       z
        / \                    /   \
       /   \                  /     \
      T1    y       -->      x       y
           / \              / \     / \
          /   \            /   \   /   \
         z    T2          T1   T3 T4   T2
        / \
       /   \ 
      T3   T4
```

The tree from 4, exhibit D:
```
         x                        y
        / \                     /   \
       /   \                   /     \
      T1    y       -->       x       z
           / \               / \     / \
          /   \             /   \   /   \
         T2    z           T1   T2 T3   T4
              / \
             /   \
            T3   T4
```


## V.  Rebalancing

### 7. 

Verify that the following tree is almost-balanced:

For EVERY internal node (x and y), the depth of the internal node's left subtree and the depth of the internal node's right subtree differ by at most 1. 

```
         8
        / \
       /   \
      6     14
     /\      /\ 
    /  \    /  \ 
   3   7   12   16 
  /\       /    /\ 
 /  \     /    /  \ 
2    5   10   15   20
                   /
                  /
                 18
```
ANSWER: I'm not 100% clear on what constitutes as a node, nor on what depth measures, so please let me know if I'm completely wrong, but I think that all of the nodes are included in this list: [8, 6, 3, 14, 12, 16]. In this list, the depth of 8's left subtree is 3 and the depth of its right subtree is 4. The depth of 6's left subtree is 2, and the depth of its right subtree is 1. The depth of 3's left subtree is 1, as is the depth of its right subtree. On the right side of 8, the depth of 14's left subtree is 2 and the depth of its right subtree is 3. The depth of 12's left subtree is 1 and the depth of its right subtree is 0. The depth of 16's left subtree is 1, and the depth of its right subtree is 2. So, we can observe that the depths of each node's left subtree and right subtree never differ by more than 1. Therefore, this tree must be almost-balanaced.


### 8. 

Insert the value 13 into this tree.  Where does it go?  Is the resulting tree almost-balanced?  If not, see #11.

```
          8
        /   \
       /     \
      6       14
     /\      /  \ 
    /  \    /    \ 
   3   7   12     16 
  /\       /\      /\ 
 /  \     /  \    /  \ 
2    5   10  13  15   20
                     /
                    /
                   18
```

I think this tree is almost-balanced, still. The depths of all the internal nodes have not changed at all with the insertion of 13 as a right subtree of 12.

### 9. 

Insert the value 17 into the tree.  Where does it go?  Is the resulting tree almost-balanced?  If not, see #11.

```
         8
        / \
       /   \
      6     14
     /\      /\  
    /  \    /  \ 
   3   7   12   16  
  /\       /    /\ 
 /  \     /    /  \ 
2    5   10   15   20
                   /
                  /
                 18
                 /
                /
               17
```

Oh no, this tree isn't almost-balanced anymore! After inserting 17 under 18, the depth of 16's left subtree is 1, while the depth of its right subtree is 3.

### 10. 

Insert the value 4 into the tree.  Where does it go?  Is the resulting tree almost-balanced?  If not, see #11.

```
         8
        / \
       /   \
      6     14
     /\      /\ 
    /  \    /  \ 
   3   7   12   16 
  /\       /    /\ 
 /  \     /    /  \ 
2    4   10   15   18
      \            /\
       \          /  \
        5        17  20
```

Oh no, I don't think this tree is almost-balanced anymore... After inserting 4 before 5, the depth of 6's left subtree is now 3, while the depth of 6's right subtree is only 1.


### 11. 

Use the work you've done above to rebalance the tree.  Start at the newly inserted value; work up until you find an internal node that has left and right children whose depth differs by more than one.  Rebalance that subtree using the processes you created in #6.  Continue to climb the tree, rebalancing any unbalanced (not almost-balanced) nodes as you go up.

Rebalancing the tree in 9:
```
         8
        / \
       /   \
      6     14
     /\      /\
    /  \    /  \ 
   3   7   12   16
  /\       /    /\ 
 /  \     /    /  \ 
2    5   10   15   18
                   /\
                  /  \
                 17  20
```
	       
Rebalancing the tree in 10:
```
             8
            / \
           /   \
          /     \
         /       \
        /         \
       /           \ 
      4            14
     / \           /\ 
    /   \         /  \ 
   3     6       12   16 
  /      /\      /    /\ 
 /      /  \    /    /  \ 
2      5    7  10   15   18
                    /\
                   /  \
                  17  20
```
### 12. 

[Challenge] Assuming that a tree is almost-balanced when you make an insertion, and that that insertion may violate the almost-balanced property, can almost-balance always be restored solely by climbing the  path from the newly inserted node to the root?  Will you ever have to descend another branch?  Why or why not?

I think that it will sometimes be necessary to descend another branch in order to rebalance the tree. However, I'm not sure... this is just my intuition. From #6, it appears that sometimes it is necessary to rotate the tree, in which case, technically, I think we are descending the other branch from the root to rearrange the tree.

Although, on the other hand, if you insert a new node, it will always have to be inserted on the left branch (if it's less than the root) or the right branch (if it's greater than the root). Does this mean that it will still be necessary to descend another branch to rebalance the tree? I really don't know. (I hope this will be explained during the next lecture!)





