import Foundation

class AVLTree {
    private var root : Node?
    
    class Node {
        var data : Int
        var left : Node?
        var right : Node?
        var height : Int

        init(_ d : Int, _ l : Node?, _ r : Node?) {
            self.data = d
            self.left = l
            self.right = r
            self.height = 0
        }
    }

    init() {
        self.root = nil
    }

    func height(_ n : Node?) -> Int {
        if (n == nil) {
            return -1
        }
        return n!.height
    }

    func getBalance(_ node : Node?) -> Int {
        return (node == nil) ? 0 : self.height(node!.left) - self.height(node!.right)
    }

    func printTree() {
        self.printTree(self.root,"",false)
        print()
    }

    func printTree(_ node : Node?, _ indent : String, _ isLeft : Bool) {
        var indent : String = indent
		guard let node = node else {
            return
        }

        if (isLeft) {
            print(indent + "L:",terminator: "")
            indent += "|  "
        } else {
            print(indent + "R:",terminator: "")
            indent += "   "
        }
        print(String(node.data) + "(" + String(node.height) + ")")
        self.printTree(node.left,indent,true)
        self.printTree(node.right,indent,false)
    }

    func insert(_ data : Int) {
        self.root = self.insert(self.root,data)
    }

    func insert(_ node : Node?, _ data : Int) -> Node? {
        guard let node = node else {
            return Node(data, nil, nil)
        }

        if (node.data > data) {
            node.left = self.insert(node.left,data)
        } else if (node.data < data) {
            node.right = self.insert(node.right,data)
        } else {
            return node // Duplicate data not allowed
        }

        node.height = max(self.height(node.left),self.height(node.right)) + 1
        let balance : Int = self.getBalance(node)

        if (balance > 1) {
            if (data < node.left!.data) { // Left Left Case
                return self.rightRotate(node)
            }
            if (data > node.left!.data) { // Left Right Case
                return self.leftRightRotate(node)
            }
        }

        if (balance < -1) {
            if (data > node.right!.data) { // Right Right Case
                return self.leftRotate(node)
            }
            if (data < node.right!.data) { // Right Left Case
                return self.rightLeftRotate(node)
            }
        }
        return node
    }

    // Function to right rotate subtree rooted with x
    func rightRotate(_ x : Node?) -> Node? {
        let y : Node? = x!.left
        let T : Node? = y!.right
		
        // Rotation
        y!.right = x
        x!.left = T

        // Update heights
        x!.height = max(self.height(x!.left),self.height(x!.right)) + 1
        y!.height = max(self.height(y!.left),self.height(y!.right)) + 1

        // Return new root
        return y
    }

    // Function to left rotate subtree rooted with x
    func leftRotate(_ x : Node?) -> Node? {
        let y : Node? = x!.right
        let T : Node? = y!.left

        // Rotation
        y!.left = x
        x!.right = T

        // Update heights
        x!.height = max(self.height(x!.left),self.height(x!.right)) + 1
        y!.height = max(self.height(y!.left),self.height(y!.right)) + 1

        // Return new root
        return y
    }

    // Function to right then left rotate subtree rooted with x
    func rightLeftRotate(_ x : Node?) -> Node? {
        x!.right = self.rightRotate(x!.right)
        return self.leftRotate(x)
    }

    // Function to left then right rotate subtree rooted with x
    func leftRightRotate(_ x : Node?) -> Node? {
        x!.left = self.leftRotate(x!.left)
        return self.rightRotate(x)
    }

    func delete(_ data : Int) {
        self.root = self.delete(self.root,data)
    }

    func delete(_ node : Node?, _ data : Int) -> Node? {
        guard let node = node else {
            return nil
        }
        if (node.data == data) {
            if (node.left == nil && node.right == nil) {
                return nil
            } else if (node.left == nil) {
                return node.right
            } else if (node.right == nil) {
                return node.left
            } else {
                let minNode : Node? = self.findMin(node.right)
                node.data = minNode!.data
                node.right = self.delete(node.right,minNode!.data)
            }
        } else {
            if (node.data > data) {
                node.left = self.delete(node.left,data)
            } else {
                node.right = self.delete(node.right,data)
            }
        }

        node.height = max(self.height(node.left),self.height(node.right)) + 1
        let balance : Int = self.getBalance(node)

        if (balance > 1) {
            if (data >= node.left!.data) { // Left Left Case
                return self.rightRotate(node)
            }
            if (data < node.left!.data) { // Left Right Case
                return self.leftRightRotate(node)
            }
        }
        if (balance < -1) {
            if (data <= node.right!.data) { // Right Right Case
                return self.leftRotate(node)
            }
            if (data > node.right!.data) { // Right Left Case
                return self.rightLeftRotate(node)
            }
        }
        return node
    }

    func findMin(_ curr : Node?) -> Node? {
        var curr : Node? = curr
		if curr == nil {
            return nil
        }

        while (curr!.left != nil) {
            curr = curr!.left
        }
        return curr
    }
}

// Testing code.
let t : AVLTree = AVLTree()
t.insert(1)
t.insert(2)
t.insert(3)
t.insert(4)
t.insert(5)
t.insert(6)
t.insert(7)
t.insert(8)
t.printTree()
// 		R:4(3)
// 		L:2(1)
// 		|  L:1(0)
// 		|  R:3(0)
// 		R:6(2)
// 		L:5(0)
// 		R:7(1)
// 		 R:8(0)
t.delete(5)
t.printTree()
// 		R:4(2)
// 		L:2(1)
// 		|  L:1(0)
// 		|  R:3(0)
// 		R:7(1)
// 		L:6(0)
// 		R:8(0)
t.delete(1)
t.printTree()
// 		R:4(2)
// 		L:2(1)
// 		|  R:3(0)
// 		R:7(1)
// 		L:6(0)
// 		R:8(0)
t.delete(2)
t.printTree()