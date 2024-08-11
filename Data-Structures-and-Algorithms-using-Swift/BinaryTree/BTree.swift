import Foundation

class BTree {
    class Node {
        var n : Int  // Current number of keys
        var keys : [Int]   // An array of keys
        var arr : [Node?]   // An array of child pointers
        var leaf : Bool   // Is true when node is leaf. Otherwise false

        // Constructor
        init(_ leaf : Bool, _ mx : Int) {
            self.n = 0
            self.keys = Array(repeating: 0, count: mx)
            self.arr = Array(repeating: nil, count: mx + 1)
            self.leaf = leaf
        }
    }

    var root : Node? // Pointer to root node
    var max : Int  // Maximum degree
    var min : Int  // Minimum degree

    init(_ dg : Int) {
        self.root = nil
        self.max = dg  // Max number of children.
        self.min = dg / 2
    }
    
    func printTree() {
        self.printTree(self.root,"")
        print()
    }

    func printTree(_ node : Node?, _ indent : String) {
        if (node == nil) {
            return
        }

        var i : Int = 0
		while (i < node!.n) {
			self.printTree(node!.arr[i],indent + "    ")
			print(indent + "key[" + String(i) + "]:" + String(node!.keys[i]))
			i += 1
		}
        
        self.printTree(node!.arr[i],indent + "    ")
    }

    func printInOrder(_ node : Node?) {
        var i : Int = 0
		while (i < node!.n) {
			if (node!.leaf == false) {self.printInOrder(node!.arr[i])
			}
			print(String(node!.keys[i]) ,terminator: " ")
			i += 1
		}

        if (node!.leaf == false) {
            self.printInOrder(node!.arr[i])
        }
    }

    func search(_ key : Int) -> Node? {
        if (self.root == nil) {
            return nil
        }
        return self.search(self.root,key)
    }

    func search(_ node : Node?, _ key : Int) -> Node? {
        var i : Int = 0
        while (i < node!.n && node!.keys[i] < key) {            
			i += 1
        }

        // If the found key is equal to key, return this node
        if (node!.keys[i] == key) {
            return node
        }

        // If the key is not found and this is a leaf node
        if (node!.leaf == true) {
            return nil
        }

        // Search in the appropriate child
        return self.search(node!.arr[i],key)
    }

    func insert(_ key : Int) {
        // If tree is empty
        if (self.root == nil) {
            // Allocate memory for root
            self.root = Node(true, self.max)
            self.root!.keys[0] = key
            // Insert key
            self.root!.n = 1
            // Update number of keys in root
            return
        }

        if (self.root!.leaf == true) {
            // Finds the location where new key can be inserted.
            // By moving all keys greater than key to one place forward.
            var i : Int = self.root!.n - 1
            while (i >= 0 && self.root!.keys[i] > key) {
                self.root!.keys[i + 1] = self.root!.keys[i]
                i -= 1
            }
            // Insert the new key at found location
            self.root!.keys[i + 1] = key
            self.root!.n = self.root!.n + 1
        } else {
            var i : Int = 0
            while (i < self.root!.n && self.root!.keys[i] < key) {                i += 1
            }
            self.insert(self.root,self.root!.arr[i],i,key)
        }
        if (self.root!.n == self.max) {
            // If root contains more then allowed nodes, then tree grows in height.
            // Allocate memory for new root
            let rt : Node? = Node(false, self.max)
            rt!.arr[0] = self.root
            self.split(rt,self.root,0)
            // divide the child into two and then add the median to the parent.
            self.root = rt
        }
    }
    // Insert a new key in this node
    // Arguments are parent, child, index of child and key.
    func insert(_ parent : Node?, _ child : Node?, _ index : Int, _ key : Int) {
        if (child!.leaf == true) {
            // Finds the location where new key will be inserted
            // by moving all keys greater than key to one place forward.
            var i : Int = child!.n - 1
            while (i >= 0 && child!.keys[i] > key) {
                child!.keys[i + 1] = child!.keys[i]
                i -= 1
            }
            // Insert the new key at found location
            child!.keys[i + 1] = key
            child!.n += 1
        } else {
            var i : Int = 0
            // insert the node to the proper child.
            while (i < child!.n && child!.keys[i] < key) {                
				i += 1
            }
            self.insert(child,child!.arr[i],i,key)
        }

        if (child!.n == self.max) {
            // More nodes than allowed.
            // divide the child into two and then add the median to the parent.
            self.split(parent,child,index)
        }
    }

    func split(_ parent : Node?, _ child : Node?, _ index : Int) {
        // Getting index of median.
        let median : Int = self.max / 2

        // Reduce the number of keys in child
        child!.n = median
        let node : Node? = Node(child!.leaf, self.max)

        // Copy the second half keys of child to node
        var j : Int = 0
        while (median + 1 + j < self.max) {
            node!.keys[j] = child!.keys[median + 1 + j]
            j += 1
        }

        node!.n = j
        // Copy the second half children of child to node
        j = 0
        while (child!.leaf == false && median + j <= self.max - 1) {
            node!.arr[j] = child!.arr[median + 1 + j]
            j += 1
        }

		j = parent!.n
		// parent is going to have a new child,
		// create space of new child
		while (j >= index + 1) {
			parent!.arr[j + 1] = parent!.arr[j]
			j -= 1
		}
        
        // Link the new child to the parent node
        parent!.arr[index + 1] = node

		j = parent!.n - 1
		// A key of child will move to the parent node.
		// Find the location of new key by moving
		// all greater keys one space forward.
		while (j >= index) {
			parent!.keys[j + 1] = parent!.keys[j]
			j -= 1
		}
        
        // Copy the middle key of child to the parent
        parent!.keys[index] = child!.keys[median]
        // Increment count of keys in this parent
        parent!.n += 1
    }

    func remove(_ key : Int) {
        self.remove(self.root,key)
        if (self.root!.n == 0) {
            // Shrinking : If root is pointing to empty node.
            // If that node is a leaf node then root will become null.
            // Else root will point to first child of node.
            if (self.root!.leaf) {
                self.root = nil
            } else {
                self.root = self.root!.arr[0]
            }
        }
    }
    
    func remove(_ node : Node?, _ key : Int) {
        let index : Int = self.findKey(node,key)
        if (node!.leaf) {
            if (index < node!.n && node!.keys[index] == key) {
                self.removeFromLeaf(node,index)
            } else {
                print("The key " + String(key) + " not found.")
                return
            }
        } else {
            if (index < node!.n && node!.keys[index] == key) {
                self.removeFromNonLeaf(node,index)
            } else {
                self.remove(node!.arr[index],key)
            }

            // All the property violation in index subtree only.
            // which include remove from leaf case too.
            if (node!.arr[index]!.n < self.min) {
                self.fixBTree(node,index)
            }
        }
    }

    // Returns the index of first key which is greater than or equal to key.
    func findKey(_ node : Node?, _ key : Int) -> Int {
        var index : Int = 0
        while (index < node!.n && node!.keys[index] < key) {            index += 1
        }
        return index
    }

    // Remove the index key from leaf node.
    func removeFromLeaf(_ node : Node?, _ index : Int) {
		var i : Int = index + 1
		// Move all the keys after the index position one step left.
		while (i < node!.n) {
			node!.keys[i - 1] = node!.keys[i]
			i += 1
		}
        
        // Reduce the key count.
        node!.n -= 1
        return
    }

    // Remove the index key from a non-leaf node.
    func removeFromNonLeaf(_ node : Node?, _ index : Int) {
        let key : Int = node!.keys[index]
        // If the child that precedes key has at least min keys,
        // Find the predecessor 'pred' of key in the subtree rooted at index.
        // Replace key by pred and recursively delete pred in arr[index]
        if (node!.arr[index]!.n > self.min) {
            let pred : Int = self.getPred(node,index)
            node!.keys[index] = pred
            self.remove(node!.arr[index],pred)
        } else if (node!.arr[index + 1]!.n > self.min) {
            let succ : Int = self.getSucc(node,index)
            node!.keys[index] = succ
            self.remove(node!.arr[index + 1],succ)
        } else {
            self.merge(node,index)
            self.remove(node!.arr[index],key)
        }
        return
    }

    // To get predecessor of keys[index]
    func getPred(_ node : Node?, _ index : Int) -> Int {
        // Keep moving to the right most node of left subtree until we reach a leaf.
        var cur : Node? = node!.arr[index]
        while (!cur!.leaf) {
            cur = cur!.arr[cur!.n]
        }

        // Return the last key of the leaf
        return cur!.keys[cur!.n - 1]
    }

    // To get successor of keys[index]
    func getSucc(_ node : Node?, _ index : Int) -> Int {
        // Keep moving to the left most node of right subtree until we reach a leaf
        var cur : Node? = node!.arr[index + 1]
        while (!cur!.leaf) {
            cur = cur!.arr[0]
        }

        // Return the first key of the leaf
        return cur!.keys[0]
    }

    // Make sure that the node have at least min number of keys
    func fixBTree(_ node : Node?, _ index : Int) {
        // If the left sibling has more than min keys.
        if (index != 0 && node!.arr[index - 1]!.n > self.min) {
            self.borrowFromLeft(node,index)
        } else if (index != node!.n && node!.arr[index + 1]!.n > self.min) {
            self.borrowFromRight(node,index)
        } else {
            if (index != node!.n) {self.merge(node,index)
            } else {
                self.merge(node,index - 1)
            }
        }
    }

    // Move a key from parent to right and left to parent.
    func borrowFromLeft(_ node : Node?, _ index : Int) {
        let child : Node? = node!.arr[index]
        let sibling : Node? = node!.arr[index - 1]
		var i : Int = child!.n - 1
		// Moving all key in child one step forward.
		while (i >= 0) {
			child!.keys[i + 1] = child!.keys[i]
			i -= 1
		}

		i = child!.n
		// Move all its child pointers one step forward.
		while (!child!.leaf && i >= 0) {
			child!.arr[i + 1] = child!.arr[i]
			i -= 1
		}
        
        // Setting child's first key equal to of the current node.
        child!.keys[0] = node!.keys[index - 1]

        // Moving sibling's last child as child's first child.
        if (!child!.leaf) {
            child!.arr[0] = sibling!.arr[sibling!.n]
        }

        // Moving the key from the sibling to the parent
        node!.keys[index - 1] = sibling!.keys[sibling!.n - 1]

        // Increase child key count and decrease sibling key count.
        child!.n += 1
        sibling!.n -= 1
        return
    }

    // Move a key from parent to left and right to parent.
    func borrowFromRight(_ node : Node?, _ index : Int) {
        let child : Node? = node!.arr[index]
        let sibling : Node? = node!.arr[index + 1]

        // node key is inserted as the last key in child.
        child!.keys[child!.n] = node!.keys[index]

        // Sibling's first child is inserted as the last child of child.
        if (!(child!.leaf)) {
            child!.arr[(child!.n) + 1] = sibling!.arr[0]
        }

        // First key from sibling is inserted into node.
        node!.keys[index] = sibling!.keys[0]

		var i : Int = 1
		// Moving all keys in sibling one step left
		while (i < sibling!.n) {
			sibling!.keys[i - 1] = sibling!.keys[i]
			i += 1
		}

		i = 1
		// Moving the child pointers one step behind
		while (!sibling!.leaf && i <= sibling!.n) {
			sibling!.arr[i - 1] = sibling!.arr[i]
			i += 1
		}
        
        // Increase child key count and decrease sibling key count.
        child!.n += 1
        sibling!.n -= 1
        return
    }

    // Merge node's children at index and index+1.
    func merge(_ node : Node?, _ index : Int) {
        let left : Node? = node!.arr[index]
        let right : Node? = node!.arr[index + 1]
        let start : Int = left!.n

        // Adding a key from node to the left child.
        left!.keys[start] = node!.keys[index]

		var i : Int = 0
		// Copying the keys from right to left.
		while (i < right!.n) {
			left!.keys[start + 1 + i] = right!.keys[i]
			i += 1
		}
	
		i = 0
		// Copying the child pointers from right to left.
		while (!left!.leaf && i <= right!.n) {
			left!.arr[start + 1 + i] = right!.arr[i]
			i += 1
		}

		i = index + 1
		// Moving all keys after  index in the current node one step forward.
		while (i < node!.n) {
			node!.keys[i - 1] = node!.keys[i]
			i += 1
		}
	

		i = index + 2
		// Moving the child pointers after (index+1) in the current node one step forward.
		while (i <= node!.n) {
			node!.arr[i - 1] = node!.arr[i]
			i += 1
		}
        
        // Updating the key count of child and the current node
        left!.n += right!.n + 1
        node!.n -= 1
        return
    }
}

let t : BTree = BTree(3) // A B-Tree with max key 3
t.insert(1)
t.insert(2)
t.insert(3)
t.insert(4)
t.insert(5)
t.insert(6)
t.insert(7)
t.insert(8)
t.insert(9)
t.insert(10)
t.printTree()
print("6 : " + ((t.search(6) != nil) ? "Present" : "Not Present"))
print("11 : " + ((t.search(11) != nil) ? "Present" : "Not Present"))
t.remove(6)
t.remove(3)
t.remove(7)
t.printTree()
/* 
        key[0]:1
    key[0]:2
        key[0]:3
key[0]:4
        key[0]:5
    key[0]:6
        key[0]:7
    key[1]:8
        key[0]:9
        key[1]:10

6 : Present
11 : Not Present
    key[0]:1
    key[1]:2
key[0]:4
    key[0]:5
key[1]:8
    key[0]:9
    key[1]:10

 */