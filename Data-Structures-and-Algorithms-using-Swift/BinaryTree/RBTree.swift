import Foundation

class RBTree {
    private var root : Node?
    private var NullNode : Node?

    class Node {
        var left : Node?
        var right : Node?
        var parent : Node?
        var data : Int
        var colour : Bool // true for red colour, false for black colour

        init(_ data : Int, _ nullNode : Node?) {
            self.data = data
            self.left = nullNode
            self.right = nullNode
            self.colour = true // New node are red in colour.
            self.parent = nullNode
        }
    }

    init() {
        self.NullNode = Node(0, nil)
        self.NullNode!.colour = false
        self.root = self.NullNode
    }

    // To check whether node is of colour red or not.
    func isRed(_ node : Node?) -> Bool {
        return (node == nil) ? false : (node!.colour == true)
    }

    func printTree() {
        self.printTree(self.root,"",false)
        print()
    }

    func printTree(_ node : Node?, _ indent : String, _ isLeft : Bool) {
        var indent = indent
		if (node === self.NullNode) {
            return
        }

        if (isLeft) {
            print(indent + "L:",terminator: "")
            indent += "|  "
        } else {
            print(indent + "R:",terminator: "")
            indent += "   "
        }
        print(String(node!.data) + "(" + String(node!.colour) + ")")
        self.printTree(node!.left,indent,true)
        self.printTree(node!.right,indent,false)
    }

    // Other methods
    // Function to right rotate subtree rooted with x
    func rightRotate(_ x : Node?) -> Node? {
        let y : Node? = x!.left
        let T : Node? = y!.right

        // Rotation
        y!.parent = x!.parent
        y!.right = x
        x!.parent = y
        x!.left = T

        if (!(T===self.NullNode)) {
            T!.parent = x
        }

        if (x === self.root) {
            self.root = y
            return y
        }

        if (y!.parent!.left === x) {
            y!.parent!.left = y
        } else {
            y!.parent!.right = y
        }

        // Return new root
        return y
    }

    // Function to left rotate subtree rooted with x
    func leftRotate(_ x : Node?) -> Node? {
        let y : Node? = x!.right
        let T : Node? = y!.left

        // Rotation
        y!.parent = x!.parent
        y!.left = x
        x!.parent = y
        x!.right = T

        if (!(T===self.NullNode)) {
            T!.parent = x
        }

        if (x === self.root) {
            self.root = y
            return y
        }

        if (y!.parent!.left === x) {
            y!.parent!.left = y
        } else {
            y!.parent!.right = y
        }
        // Return new root
        return y
    }

    func rightLeftRotate(_ node : Node?) -> Node? {
        node!.right = self.rightRotate(node!.right)
        return self.leftRotate(node)
    }

    func leftRightRotate(_ node : Node?) -> Node? {
        node!.left = self.leftRotate(node!.left)
        return self.rightRotate(node)
    }

    func find(_ data : Int) -> Node? {
        var curr : Node? = self.root
        while (!(curr===self.NullNode)) {
            if (curr!.data == data) {
                return curr
            } else if (curr!.data > data) {
                curr = curr!.left
            } else {
                curr = curr!.right
            }
        }
        return nil
    }

    func insert(_ data : Int) {
        self.root = self.insert(self.root,data)
        let temp : Node? = self.find(data)
        self.fixRedRed(temp)
    }

    func insert(_ node : Node?, _ data : Int) -> Node? {
        var node = node
		if (node === self.NullNode) {
            node = Node(data, self.NullNode)
        } else if (node!.data > data) {
            node!.left = self.insert(node!.left,data)
            node!.left!.parent = node
        } else if (node!.data < data) {
            node!.right = self.insert(node!.right,data)
            node!.right!.parent = node
        }
        return node
    }

    func fixRedRed(_ x : Node?) {
        // if x is root colour it black and return
        if (x === self.root) {
            x!.colour = false
            return
        }
        if (x!.parent === self.NullNode || x!.parent!.parent === self.NullNode) {
            return
        }

        // Initialize parent, grandparent, uncle
        let parent : Node? = x!.parent
        let grandparent : Node? = parent!.parent
        let uncle : Node? = self.uncle(x)
        var mid : Node? = nil

        if (parent!.colour == false) {
            return
        }

        // parent colour is red. gp is black.
        if (!(uncle===self.NullNode) && uncle!.colour == true) {
            // uncle and parent is red.
            parent!.colour = false
            uncle!.colour = false
            grandparent!.colour = true
            self.fixRedRed(grandparent)
            return
        }

        // parent is red, uncle is black and gp is black.
        // Perform LR, LL, RL, RR
        if (parent === grandparent!.left && x === parent!.left) { // LL
            mid = self.rightRotate(grandparent)
        } else if (parent === grandparent!.left && x === parent!.right) { // LR
            mid = self.leftRightRotate(grandparent)
        } else if (parent === grandparent!.right && x === parent!.left) { // RL
            mid = self.rightLeftRotate(grandparent)
        } else if (parent === grandparent!.right && x === parent!.right) { // RR
            mid = self.leftRotate(grandparent)
        }
        mid!.colour = false
        mid!.left!.colour = true
        mid!.right!.colour = true
    }

    func uncle(_ node : Node?) -> Node? {
        // If no parent or grandparent, then no uncle
        if (node!.parent === self.NullNode || node!.parent!.parent === self.NullNode) {
            return nil
        }

        if (node!.parent === node!.parent!.parent!.left) {
            // uncle on right
            return node!.parent!.parent!.right
        } else {
            // uncle on left
            return node!.parent!.parent!.left
        }
    }

    func delete(_ data : Int) {
        self.delete(self.root,data)
    }

    func delete(_ node : Node?, _ key : Int) {
        var z : Node? = self.NullNode
        var x : Node?, y : Node?
		var node = node
        while (!(node===self.NullNode)) {
            if (node!.data == key) {
                z = node
                break
            } else if (node!.data <= key) {
                node = node!.right
            } else {
                node = node!.left
            }
        }

        if (z === self.NullNode) {
            print("Couldn\'t find key in the tree")
            return
        }
        y = z
        var yColour : Bool = y!.colour

        if (z!.left === self.NullNode) {
            x = z!.right
            self.joinParentChild(z,z!.right)
        } else if (z!.right === self.NullNode) {
            x = z!.left
            self.joinParentChild(z,z!.left)
        } else {
            y = self.minimum(z!.right)
            yColour = y!.colour
            z!.data = y!.data
            self.joinParentChild(y,y!.right)
            x = y!.right
        }

        if (yColour == false) {
            if (x!.colour == true) {
                x!.colour = false
                return
            } else {
                self.fixDoubleBlack(x)
            }
        }
    }

    func fixDoubleBlack(_ x : Node?) {
        if (x === self.root) {
            // Root node.
            return
        }
        let sib : Node? = self.sibling(x)
        let parent : Node? = x!.parent
        if (sib === self.NullNode) {
            // No sibling double black shifted to parent.
            self.fixDoubleBlack(parent)
        } else {
            if (sib!.colour == true) {
                // Sibling colour is red.
                parent!.colour = true
                sib!.colour = false
                if (sib!.parent!.left === sib) { // Sibling is left child.
                    _ = self.rightRotate(parent)
                } else { // Sibling is right child.
                    _ = self.leftRotate(parent)
                }
                self.fixDoubleBlack(x)
            } else {
                // Sibling colour is black
                // At least one child is red.
                if (sib!.left!.colour == true || sib!.right!.colour == true) {
                    if (sib!.parent!.left === sib) {
                        // Sibling is left child.
                        if (!(sib!.left===self.NullNode) && sib!.left!.colour == true) {
                            // left left case.
                            sib!.left!.colour = sib!.colour
                            sib!.colour = parent!.colour
                            _ = self.rightRotate(parent)
                        } else {
                            // left right case.
                            sib!.right!.colour = parent!.colour
                            _ = self.leftRotate(sib)
                            _ = self.rightRotate(parent)
                        }
                    } else {
                        // Sibling is right child.
                        if (!(sib!.left===self.NullNode) && sib!.left!.colour == true) {
                            // right left case.
                            sib!.left!.colour = parent!.colour
                            _ = self.rightRotate(sib)
                            _ = self.leftRotate(parent)
                        } else {
                            // right right case.
                            sib!.right!.colour = sib!.colour
                            sib!.colour = parent!.colour
                            _ = self.leftRotate(parent)
                        }
                    }
                    parent!.colour = false
                } else {
                    // Both children black.
                    sib!.colour = true
                    if (parent!.colour == false) {
						self.fixDoubleBlack(parent)
                    } else {
                        parent!.colour = false
                    }
                }
            }
        }
    }

    func sibling(_ node : Node?) -> Node? {
        // sibling null if no parent
        if (node!.parent === self.NullNode) {
            return nil
        }

        if (node!.parent!.left === node) {
            return node!.parent!.right
        }
        return node!.parent!.left
    }

    func joinParentChild(_ u : Node?, _ v : Node?) {
        if (u!.parent === self.NullNode) {
            self.root = v
        } else if (u === u!.parent!.left) {
            u!.parent!.left = v
        } else {
            u!.parent!.right = v
        }
        v!.parent = u!.parent
    }

    func minimum(_ node : Node?) -> Node? {
		var node = node
        while (!(node!.left===self.NullNode)) {
            node = node!.left
        }
        return node
    }
}

let tree : RBTree = RBTree()
tree.insert(1)
tree.insert(2)
tree.insert(3)
tree.insert(4)
tree.insert(5)
tree.insert(7)
tree.insert(6)
tree.insert(8)
tree.insert(9)
tree.printTree()
tree.delete(4)
tree.printTree()
tree.delete(7)
tree.printTree()

/* 
R:4(false)
   L:2(true)
   |  L:1(false)
   |  R:3(false)
   R:6(true)
      L:5(false)
      R:8(false)
         L:7(true)
         R:9(true)

R:5(false)
   L:2(true)
   |  L:1(false)
   |  R:3(false)
   R:7(true)
      L:6(false)
      R:8(false)
         R:9(true)

R:5(false)
   L:2(true)
   |  L:1(false)
   |  R:3(false)
   R:8(true)
      L:6(false)
      R:9(false)
 */





