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

    public var isEmpty : Bool {
        return (self.size == 0)
    }

    public var length : Int {
        return self.size
    }

    func peek() -> T? {
        if (self.isEmpty) {
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
        if (self.isEmpty) {
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
		var i : Int = 0
		while (i < self.size) {
			print(self.arr[i]!, terminator: " ")
			i += 1
		}
        print()
    }

    func delete(_ value : T) -> Bool {
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

func kthSmallest(_ arr : inout [Int], _ size : Int, _ k : Int) -> Int {
	let arr = arr.sorted()
	return arr[k - 1]
}

func kthSmallest2(_ arr : inout [Int], _ size : Int, _ k : Int) -> Int {
	let hp = Heap<Int>(true)
	var i : Int = 0
	while (i < size) {
		hp.add(arr[i])
		i += 1
	}
	i = 0
	while (i < k - 1) {
		_ = hp.remove()
		i += 1
	}
	return hp.peek()!
}

func kthSmallest3(_ arr : inout [Int], _ size : Int, _ k : Int) -> Int {
	let hp = Heap<Int>(false)
	var i : Int = 0
	while (i < size) {
		if (i < k) {
			hp.add(arr[i])
		} else {
			if (hp.peek()! > arr[i]) {
				hp.add(arr[i])
				_ = hp.remove()
			}
		}
		i += 1
	}
	
	return hp.peek()!
}

func kthLargest(_ arr : inout [Int], _ size : Int, _ k : Int) -> Int {
	var value : Int = 0
	let hp = Heap<Int>(false)
	var i : Int = 0
	while (i < size) {
		hp.add(arr[i])
		i += 1
	}
	
	i = 0
	while (i < k) {
		value = hp.remove()!
		i += 1
	}
	return value
}

// Testing code.
func main1() {
	var arr : [Int] = [8, 7, 6, 5, 7, 5, 2, 1]
	print("Kth Smallest :: " + String(kthSmallest( &arr,arr.count,3)))
	var arr2 : [Int] = [8, 7, 6, 5, 7, 5, 2, 1]
	print("Kth Smallest :: " + String(kthSmallest2( &arr2,arr2.count,3)))
	var arr3 : [Int] = [8, 7, 6, 5, 7, 5, 2, 1]
	print("Kth Smallest :: " + String(kthSmallest3( &arr3,arr3.count,3)))
	var arr4 : [Int] = [8, 7, 6, 5, 7, 5, 2, 1]
	print("Kth Largest :: " + String(kthLargest( &arr4,arr4.count,3)))
}

// Kth Smallest :: 5
// Kth Smallest :: 5
// Kth Smallest :: 5
// Kth Largest :: 7

func isMinHeap(_ arr : inout [Int], _ size : Int) -> Bool
{
	var lchild : Int
	var rchild : Int
	
	var parent : Int = 0
	// last element index size - 1
	while (parent < (size / 2 + 1)) {
		lchild = parent * 2 + 1
		rchild = parent * 2 + 2
		// heap property check.
		if (((lchild < size) && (arr[parent] > arr[lchild])) || ((rchild < size) && (arr[parent] > arr[rchild]))) {
			return false
		}
		parent += 1
	}
	return true
}

func isMaxHeap(_ arr : inout [Int], _ size : Int) -> Bool
{
	var lchild : Int
	var rchild : Int
	var parent : Int = 0
	// last element index size - 1
	while (parent < (size / 2 + 1)) {
		lchild = parent * 2 + 1
		rchild = lchild + 1
		// heap property check.
		if (((lchild < size) && (arr[parent] < arr[lchild])) || ((rchild < size) && (arr[parent] < arr[rchild]))) {
			return false
		}
		parent += 1
	}
	return true
}



// Testing code.
func main2() {
	var arr3 : [Int] = [8, 7, 6, 5, 7, 5, 2, 1]
	print("isMaxHeap :: " + String(isMaxHeap( &arr3,arr3.count)))
	var arr4 : [Int] = [1, 2, 3, 4, 5, 6, 7, 8]
	print("isMinHeap :: " + String(isMinHeap( &arr4,arr4.count)))
}
// isMaxHeap :: true
// isMinHeap :: true

func kSmallestProduct(_ arr : inout [Int], _ size : Int, _ k : Int) -> Int {
	arr = arr.sorted(by: <)
	var product : Int = 1
	var i : Int = 0
	while (i < k) {
		product *= arr[i]
		i += 1
	}
	
	return product
}

func swap(_ arr : inout [Int], _ i : Int, _ j : Int) {
	let temp : Int = arr[i]
	arr[i] = arr[j]
	arr[j] = temp
}

func quickSelectUtil(_ arr : inout [Int], _ lower : Int, _ upper : Int, _ k : Int) {
	var lower = lower
	var upper = upper

	if (upper <= lower) {
		return
	}
	
	let pivot : Int = arr[lower]
	let start : Int = lower
	let stop : Int = upper
	while (lower < upper) {
		while (lower < upper && arr[lower] <= pivot) {
			lower += 1
		}
		while (lower <= upper && arr[upper] > pivot) {
			upper -= 1
		}
		if (lower < upper) {
			swap( &arr,upper,lower)
		}
	}
	swap( &arr,upper,start)
	// upper is the pivot position
	if (k < upper) {
		quickSelectUtil( &arr,start,upper - 1,k)
	}
	// pivot -1 is the upper for left sub array.
	if (k > upper) {
		quickSelectUtil( &arr,upper + 1,stop,k)
	}
}

func kSmallestProduct3(_ arr : inout [Int], _ size : Int, _ k : Int) -> Int {
	quickSelectUtil( &arr,0,size - 1,k)
	var product : Int = 1
	var i : Int = 0
	while (i < k) {
		product *= arr[i]
		i += 1
	}
	return product
}

func kSmallestProduct2(_ arr : inout [Int], _ size : Int, _ k : Int) -> Int {
	let hp = Heap<Int>(true)
	var i : Int = 0
	var product : Int = 1
	while (i < size) {
		hp.add(arr[i])
		i += 1
	}
	
	i = 0
	while (i < size && i < k) {
		product *= hp.remove()!
		i += 1
	}
	return product
}

func kSmallestProduct4(_ arr : inout [Int], _ size : Int, _ k : Int) -> Int {
	let hp = Heap<Int>(false)
	var i : Int = 0
	while (i < size) {
		if (i < k) {
			hp.add(arr[i])
		} else {
			if (hp.peek()! > arr[i]) {
				hp.add(arr[i])
				_ = hp.remove()
			}
		}
		i += 1
	}
	
	var product : Int = 1
	i = 0
	while (i < k) {
		product *= hp.remove()!
		i += 1
	}
	return product
}

// Testing code.
func main3() {
var arr : [Int] = [8, 7, 6, 5, 7, 5, 2, 1]
print("Kth Smallest product:: " + String(kSmallestProduct( &arr,8,3)))
	var arr2 : [Int] = [8, 7, 6, 5, 7, 5, 2, 1]
	print("Kth Smallest product:: " + String(kSmallestProduct2( &arr2,8,3)))
	var arr3 : [Int] = [8, 7, 6, 5, 7, 5, 2, 1]
	print("Kth Smallest product:: " + String(kSmallestProduct3( &arr3,8,3)))
	var arr4 : [Int] = [8, 7, 6, 5, 7, 5, 2, 1]
	print("Kth Smallest product:: " + String(kSmallestProduct4( &arr4,8,3)))
}

// Kth Smallest product:: 10 
// Kth Smallest product:: 10 
// Kth Smallest product:: 10
// Kth Smallest product:: 10

func printLargerHalf(_ arr : inout [Int], _ size : Int) {
	arr = arr.sorted(by: <)
	var i : Int = size / 2
	while (i < size) {
		print(String(arr[i]), terminator: " ")
		i += 1
	}
	print()
}

func printLargerHalf2(_ arr : inout [Int], _ size : Int) {
	let hp = Heap<Int>(true)
	var i : Int = 0
	while (i < size) {
		hp.add(arr[i])
		i += 1
	}
	
	i = 0
	while (i < size / 2) {
		_ = hp.remove()
		i += 1
	}
	hp.display()
}

func printLargerHalf3(_ arr : inout [Int], _ size : Int) {
	quickSelectUtil( &arr,0,size - 1,size / 2)
	var i : Int = size / 2
	while (i < size) {
		print(String(arr[i]), terminator: " ")
		i += 1
	}
	print()
}

// Testing code.
func main4() {
	var arr : [Int] = [8, 7, 6, 5, 7, 5, 2, 1]
	printLargerHalf( &arr,8)
	var arr2 : [Int] = [8, 7, 6, 5, 7, 5, 2, 1]
	printLargerHalf2( &arr2,8)
	var arr3 : [Int] = [8, 7, 6, 5, 7, 5, 2, 1]
	printLargerHalf3( &arr3,8)
}
// 6 7 7 8 
// [6, 7, 7, 8] 
// 6 7 7 8

func sortK(_ arr : inout [Int], _ size : Int, _ k : Int) {
	let hp = Heap<Int>(true)
	var i : Int = 0
	while (i < k) {
		hp.add(arr[i])
		i += 1
	}
	
	var index : Int = 0
	i = k
	while (i < size) {
		arr[index] = hp.remove()!
		index += 1
		hp.add(arr[i])
		i += 1
	}
	
	while (hp.length > 0) {
		arr[index] = hp.remove()!
		index += 1
	}
}

// Testing Code
func main5() {
	let k : Int = 3
	var arr : [Int] = [1, 5, 4, 10, 50, 9]
	let size : Int = arr.count
	sortK( &arr,size,k)
	print(arr)
}

// [1, 4, 5, 9, 10, 50]

main1()
main2()
main3()
main4()
main5()