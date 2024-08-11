import Foundation

class Heap {
    private var size : Int // Number of elements in Heap
    private var arr : [Int] // The Heap array
    private var isMinHeap : Bool

    init(_ isMin : Bool) {
        self.arr = []
        self.size = 0
        self.isMinHeap = isMin
    }

    init(_ array : inout [Int], _ isMin : Bool) {
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

    func compare(_ first : Int, _ second : Int) -> Bool {
        if (self.isMinHeap) {
            return (self.arr[first] > self.arr[second])
        } else {
            return (self.arr[first] < self.arr[second])
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
        if (rChild < self.size && self.compare(lChild,rChild)) {
            child = rChild
        }
        if (child != -1 && self.compare(parent,child)) {
            let temp : Int = self.arr[parent]
            self.arr[parent] = self.arr[child]
            self.arr[child] = temp
            self.percolateDown(child)
        }
    }

    func percolateUp(_ child : Int) {
        let parent : Int = (child - 1) / 2
        if (parent >= 0 && self.compare(parent,child)) {
            let temp : Int = self.arr[child]
            self.arr[child] = self.arr[parent]
            self.arr[parent] = temp
            self.percolateUp(parent)
        }
    }

    func isEmpty() -> Bool
    {
        return (self.size == 0)
    }

    func length() -> Int
    {
        return self.size
    }

    func peek() -> Int
    {
        if (self.isEmpty())
        {
            print("Heap empty exception.")
			return 0
        }
        return self.arr[0]
    }

    func add(_ value : Int) {
		self.size += 1
		self.arr.append(value)
        self.percolateUp(self.size - 1)
    }

    func remove() -> Int {
        if (self.isEmpty()) {
            print("Heap empty exception.")
			return 0
        }
        let value : Int = self.arr[0]
        self.arr[0] = self.arr[self.size - 1]
        self.size -= 1
		self.arr.removeLast()
        self.percolateDown(0)
        return value
    }

    func printHeap() {
        print("Heap : ",terminator: "")
		var i : Int = 0
		while (i < self.size)
		{
			print(String(self.arr[i]), terminator: " ")
			i += 1
		}
        print()
    }

    func delete(_ value : Int) -> Bool
    {
		var i : Int = 0
		while (i < self.size)
		{
			if (self.arr[i] == value) {
				self.arr[i] = self.arr[self.size - 1]
				self.size -= 1
				self.arr.removeLast()
				self.percolateUp(i)
				self.percolateDown(i)
				return true
			}
			i += 1
		}
        return false
    }
}

func merge(_ lists : inout [Int], _ size : Int) -> Int {
    let pq = Heap(true)
    var i : Int = 0
    while (i < size) {
        pq.add(lists[i])
        i += 1
    }
    
    var total : Int = 0
    var value : Int = 0
    while (pq.length() > 1) {
        value = pq.remove()
        value += pq.remove()
        pq.add(value)
        total += value
    }
    return total
}

// Testing code.
var lists : [Int] = [4, 3, 2, 6]
print("Total : " + String(merge(&lists, lists.count)))

// Total : 29