import Foundation

class SPLAYTree {
    private var root : Node?

    class Node {
        var data : Int
        var left : Node?
        var right : Node?
        var parent : Node?

        init(_ d : Int, _ l : Node?, _ r : Node?) {
            self.data = d
            self.left = l
            self.right = r
            self.parent = nil
        }
    }

    init() {
        self.root = nil
    }

    func printTree() {
        self.printTree(self.root,"",false)
        print()
    }

    func printTree(_ node : Node?, _ indent : String, _ isLeft : Bool) {
        if (node == nil) {
            return
        }
		var indent = indent
        if (isLeft) {
            print(indent + "L:",terminator: "")
            indent += "|  "
        } else {
            print(indent + "R:",terminator: "")
            indent += "   "
        }

        print(node!.data)
        self.printTree(node!.left,indent,true)
        self.printTree(node!.right,indent,false)
    }

    // Function to right rotate subtree rooted with x
    func rightRotate(_ x : Node?) -> Node? {
        let y : Node? = x!.left
        let T : Node? = y!.right

        // Rotation
        y!.parent = x!.parent
        y!.right = x
        x!.parent = y
        x!.left = T

        if (T != nil) {
            T!.parent = x
        }

        if (y!.parent != nil && y!.parent!.left === x) {
            y!.parent!.left = y
        } else if (y!.parent != nil && y!.parent!.right === x) {
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

        if (T != nil) {
            T!.parent = x
        }

        if (y!.parent != nil && y!.parent!.left === x) {
            y!.parent!.left = y
        } else if (y!.parent != nil && y!.parent!.right === x) {
            y!.parent!.right = y
        }

        // Return new root
        return y
    }

    func parent(_ node : Node?) -> Node? {
        if (node == nil || node!.parent == nil) {
            return nil
        }
        return node!.parent
    }

    func splay(_ node : Node?) {
        var parent : Node?
        var grand : Node?
		var node = node

        while (!(node===self.root)) {
            parent = self.parent(node)
            grand = self.parent(parent)
            if (parent == nil) { // rotations had created new root, always last condition.
                self.root = node
            } else if (grand == nil) { // single rotation case.
                if (parent!.left === node) {
                    node = self.rightRotate(parent)
                } else {
                    node = self.leftRotate(parent)
                }
            } else if (grand!.left === parent && parent!.left === node) {  // Zig Zig case.
                _ = self.rightRotate(grand)
                node = self.rightRotate(parent)
            } else if (grand!.right === parent && parent!.right === node) {  // Zag Zag case.
                _ = self.leftRotate(grand)
                node = self.leftRotate(parent)
            } else if (grand!.left === parent && parent!.right === node) {  // Zig Zag case.
                _ = self.leftRotate(parent)
                node = self.rightRotate(grand)
            } else if (grand!.right === parent && parent!.left === node) {  // Zag Zig case.
                _ = self.rightRotate(parent)
                node = self.leftRotate(grand)
            }
        }
    }

    func find(_ data : Int) -> Bool {
        var curr : Node? = self.root
        while (curr != nil) {
            if (curr!.data == data) {
                self.splay(curr)
                return true
            } else if (curr!.data > data) {
                curr = curr!.left
            } else {
                curr = curr!.right
            }
        }
        return false
    }

    func insert(_ data : Int) {
        let newNode : Node? = Node(data, nil, nil)
        if (self.root == nil) {
            self.root = newNode
            return
        }

        var node : Node? = self.root
        var parent : Node? = nil
        while (node != nil) {
            parent = node
            if (node!.data > data) {
                node = node!.left
            } else if (node!.data < data) {
                node = node!.right
            } else {
                self.splay(node)
                // duplicate insertion not allowed but splaying for it.
                return
            }
        }

        newNode!.parent = parent
        if (parent!.data > data) {
            parent!.left = newNode
        } else {
            parent!.right = newNode
        }
        self.splay(newNode)
    }
    func findMinNode(_ curr : Node?) -> Node? {
        var node : Node? = curr
        if (node == nil) {
            return nil
        }

        while (node!.left != nil) {
            node = node!.left
        }
        return node
    }

    func delete(_ data : Int) {
        var node : Node? = self.root
        var parent : Node? = nil
        var next : Node? = nil
		var data = data
        while (node != nil) {
            if (node!.data == data) {
                parent = node!.parent
                if (node!.left == nil && node!.right == nil) {
                    next = nil
                } else if (node!.left == nil) {
                    next = node!.right
                } else if (node!.right == nil) {
                    next = node!.left
                }
                if (node!.left == nil || node!.right == nil) {
                    if (node === self.root) {
                        self.root = next
                        return
                    }

                    if (parent!.left === node) {
                        parent!.left = next
                    } else {
                        parent!.right = next
                    }

                    if (next != nil) {
                        next!.parent = parent
                    }
                    break
                }

                let minNode : Node? = self.findMinNode(node!.right)
                data = minNode!.data
                node!.data = data
                node = node!.right
            } else if (node!.data > data) {
                parent = node
                node = node!.left
            } else {
                parent = node
                node = node!.right
            }
        }
        self.splay(parent)
    }

    func printInOrder() {
        self.printInOrder(self.root)
        print()
    }

    func printInOrder(_ node : Node?) {
        // In order
        if (node != nil) {
            self.printInOrder(node!.left)
            print(String(node!.data) ,terminator: " ")
            self.printInOrder(node!.right)
        }
    }   
}

let tree : SPLAYTree = SPLAYTree()
tree.insert(5)
tree.insert(4)
tree.insert(6)
tree.insert(3)
tree.insert(2)
tree.insert(1)
tree.insert(3)
tree.printTree()
print("Value 2 found: " + String(tree.find(2)))
tree.delete(2)
tree.delete(5)
tree.printTree()

/* 
R:3
   L:2
   |  L:1
   R:6
      L:4
      |  R:5

Value 2 found: true
R:4
   L:3
   |  L:1
   R:6
 */
