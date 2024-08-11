import Foundation

class BinaryIndexTree {
    var BIT : [Int]
    var size : Int

    init(_ arr : inout [Int]) {
        self.size = arr.count
        self.BIT = Array(repeating: 0, count: self.size + 1)
		var i : Int = 0
		// Populating bit.
		while (i < self.size) {
			self.update(i,arr[i])
			i += 1
		}
    }

    func set(_ arr : inout [Int], _ index : Int, _ val : Int) {
        let diff : Int = val - arr[index]
        arr[index] = val
        self.update(index,diff) // Difference is propagated.
    }

    func update(_ index : Int, _ val : Int) {
        // Index in bit is 1 more than the input array.
        var index = index + 1

        // Traverse to ancestors of nodes.
        while (index <= self.size) {
            // Add val to current node of Binary Index Tree.
            self.BIT[index] += val
            // Next element which need to store val.
            index += index & (-index)
        }
    }

    // Range sum in the range start to end.
    func rangeSum(_ start : Int, _ end : Int) -> Int {
        // Check for error conditions.
        if (start > end || start < 0 || end > self.size - 1) {
            print("Invalid Input.")
            return -1
        }
        return self.prefixSum(end) - self.prefixSum(start - 1)
    }

    // Prefix sum in the range 0 to index.
    func prefixSum(_ index : Int) -> Int {
        var sum : Int = 0
        var index = index + 1
        // Traverse ancestors of Binary Index Tree nodes.
        while (index > 0) {
            // Add current element to sum.
            sum += self.BIT[index]
            // Parent index calculation.
            index -= index & (-index)
        }
        return sum
    }
}

// Testing code.
var arr : [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
let tree : BinaryIndexTree = BinaryIndexTree(&arr)
print("Sum of elements in range(0, 5): " + String(tree.prefixSum(5)))
print("Sum of elements in range(2, 5): " + String(tree.rangeSum(2,5)))
// Set fourth element to 10.
tree.set( &arr,3,10)
// Find sum after the value is updated
print("Sum of elements in range(0, 5): " + String(tree.prefixSum(5)))

/* 
Sum of elements in range(0, 5): 21
Sum of elements in range(2, 5): 18
Sum of elements in range(0, 5): 27
 */
