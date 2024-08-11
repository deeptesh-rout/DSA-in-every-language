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

class MedianHeap{
	var minHeap : Heap<Int>
	var maxHeap : Heap<Int>

	public init() {
		minHeap = Heap<Int>(true)
		maxHeap = Heap<Int>(false)
	}
	
	public func insert(_ value : Int) {
		if maxHeap.isEmpty() {
			self.maxHeap.add(value)
		} else {
			let top = self.maxHeap.peek()!
			if top >= value {
				self.maxHeap.add(value)
			} else {
				self.minHeap.add(value)
			}
		}
		// size balancing
		if self.maxHeap.length() > self.minHeap.length()+1 {
			let value = self.maxHeap.remove()!
			self.minHeap.add(value)
		}
	
		if self.minHeap.length() > self.maxHeap.length()+1 {
			let value = self.minHeap.remove()!
			self.maxHeap.add(value)
		}
	}
	
	public func getMedian() -> Int {
		if self.maxHeap.length() == 0 && self.minHeap.length() == 0 {
			print("HeapEmptyException")
			return 0
		}
	
		if self.maxHeap.length() == self.minHeap.length() {
			let val1 = self.maxHeap.peek()!
			let val2 = self.minHeap.peek()!
			return (val1 + val2) / 2
		} else if self.maxHeap.length() > self.minHeap.length() {
			let val1 = self.maxHeap.peek()!
			return val1
		} else {
			let val2 = self.minHeap.peek()!
			return val2
		}
	}	
}

// Testing code
var arr = [1, 9, 2, 8, 3, 7, 4, 6]
var hp = MedianHeap()

for value in arr {
	hp.insert(value)
	print("Median after insertion of \(value) is  \(hp.getMedian())")
}

// Median after insertion of 1 is  1
// Median after insertion of 9 is  5
// Median after insertion of 2 is  2
// Median after insertion of 8 is  5
// Median after insertion of 3 is  3
// Median after insertion of 7 is  5
// Median after insertion of 4 is  4
// Median after insertion of 6 is  5