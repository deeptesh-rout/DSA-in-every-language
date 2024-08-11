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
		while (i < self.size) {
			print(String(self.arr[i]), terminator: " ")
			i += 1
		}
        print()
    }

    func delete(_ value : Int) -> Bool
    {
		var i : Int = 0
		while (i < self.size) {
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

func IntComp(_ first : Int, _ second : Int) -> Bool {
	return first > second
}

func chotaBhim(_ cups : inout [Int]) -> Int {
	let size : Int = cups.count
	var time : Int = 60
	cups =	cups.sorted(by: IntComp)
	var total : Int = 0
	var index : Int
	var temp : Int
	while (time > 0) {
		total += cups[0]
		cups[0] = Int(ceil(Double(cups[0])/2))
		index = 0
		temp = cups[0]
		while (index < size - 1 && temp < cups[index + 1]) {
			cups[index] = cups[index + 1]
			index += 1
		}
		cups[index] = temp
		time -= 1
	}
	return total
}

func chotaBhim2(_ cups : inout [Int]) -> Int {
	var time : Int = 60
	let pq = Heap(&cups, false)
	var total : Int = 0
	var value : Int

	while (time > 0) {
		value = pq.remove()
		total += value
		value = Int(ceil(Double(value) / 2.0))
		pq.add(value)
		time -= 1
	}
	return total
}

// Testing code.
var cups : [Int] = [2, 1, 7, 4, 2]
print("Total : " + String(chotaBhim( &cups)))
var cups2 : [Int] = [2, 1, 7, 4, 2]
print("Total : " + String(chotaBhim2( &cups2)))
/* 
Total : 76
Total : 76 
*/