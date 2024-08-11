import Foundation

class Heap < T: Comparable > {
    private var size : Int // Number of elements in Heap
    private var arr : [T?] // The Heap array
    private var isMinHeap : Bool

    init(_ isMin : Bool) {
        self.arr = []
        self.size = 0
        self.isMinHeap = isMin
    }

    init(_ array : inout [T], _ isMin : Bool) {
        self.size = array.count
        self.arr = array
        self.isMinHeap = isMin

		// Build Heap operation over array
		var i : Int = (self.size / 2)
		while (i >= 0) {
			self.percolateDown(i)
			i -= 1
		}
    }

    func comp(_ first : T, _ second : T) -> Bool {
        if (self.isMinHeap) {
            return first > second
        } else {
            return first < second
        }
    }

    // Other Methods.
    func percolateDown(_ parent : Int) {
        let lChild : Int = 2 * parent + 1
        let rChild : Int = lChild + 1
        var child : Int = -1
        if (lChild < self.size) {
            child = lChild
        }

        if (rChild < self.size && self.comp(arr[lChild]!, arr[rChild]!)) {
            child = rChild
        }

        if (child != -1 && self.comp(arr[parent]!, arr[child]!)) {
            self.arr.swapAt(parent, child)
			self.percolateDown(child)
        }
    }

    func percolateUp(_ child : Int) {
        let parent : Int = (child - 1) / 2
        if (parent >= 0 && self.comp(arr[parent]!, arr[child]!)) {
			self.arr.swapAt(child, parent)
            self.percolateUp(parent)
        }
    }

    func isEmpty() -> Bool {
        return (self.size == 0)
    }

    func length() -> Int {
        return self.size
    }

    func peek() -> T? {
        if (self.isEmpty()) {
            print("Heap empty exception.")
			return nil
        }
        return self.arr[0]
    }

    func add(_ value : T) {
		self.size += 1
		self.arr.append(value)
        self.percolateUp(self.size - 1)
    }

    func remove() -> T? {
        if (self.isEmpty()) {
            print("Heap empty exception.")
			return nil
        }
        let value = self.arr[0]
        self.arr[0] = self.arr[self.size - 1]
        self.size -= 1
		self.arr.removeLast()
        self.percolateDown(0)
        return value
    }

    func display() {
        print("Heap : ",terminator: "")
		var i : Int = 0
		while (i < self.size) {
			print(self.arr[i]!, terminator: " ")
			i += 1
		}
        print()
    }
}

class HuffmanTree {
    class Node : Comparable {
        var c : Character
        var freq : Int
        var left : Node?
        var right : Node?

        init(_ ch : Character, _ fr : Int, _ l : Node?, _ r : Node?) {
            self.c = ch
            self.freq = fr
            self.left = l
            self.right = r
        }

        static func < (lhs: Node, rhs: Node) -> Bool {
            return lhs.freq < rhs.freq
        }

        static func == (lhs: Node, rhs: Node) -> Bool {
            return lhs.freq == rhs.freq
        }
    }

    var root : Node? = nil

    init(_ arr : inout [Character], _ freq : inout [Int]) {
        let n : Int = arr.count
        let pq = Heap<Node>(true)
        var i : Int = 0

        while (i < n) {
            let node : Node = Node(arr[i], freq[i], nil, nil)
            pq.add(node)
            i += 1
        }
        
        while (pq.length() > 1) {
            let lt : Node = pq.remove()!
            let rt : Node = pq.remove()!
            let nd : Node = Node("+", lt.freq + rt.freq, lt, rt)
            pq.add(nd)
        }
        self.root = pq.peek()
    }

    func printHuffmanTree(_ root : Node?, _ s : String) {
        if (root!.left == nil && root!.right == nil && root!.c != "+") {
            print(String(root!.c) + " = " + s)
            return
        }
        self.printHuffmanTree(root!.left, s + "0")
        self.printHuffmanTree(root!.right, s + "1")
    }

    func printHuffmanTree() {
        print("Char = Huffman code")
        self.printHuffmanTree(self.root,"")
    }
}

// Testing code.
var ar : [Character] = ["A", "B", "C", "D", "E"]
var fr : [Int] = [30, 25, 21, 14, 10]
let hf : HuffmanTree = HuffmanTree(&ar, &fr)
hf.printHuffmanTree()

/* 
Char = Huffman code
C = 00
E = 010
D = 011
B = 10
A = 11
 */
