import Foundation

class SegmentTree {
    var segArr : [Int]
    var size : Int

    init(_ input : inout [Int]) {
        self.size = input.count
        // Height of segment tree.
        let x : Int = Int((ceil(log(Double(self.size)) / log(2))))
        
		// Maximum size of segment tree
        let max_size : Int = 2 * Int(pow(Double(2),Double(x))) - 1
        
		// Allocate memory for segment tree
        self.segArr = Array(repeating: 0, count: max_size)
        _ = self.constructST( &input,0,self.size - 1,0)
    }

    func constructST(_ input : inout [Int], _ start : Int, _ end : Int, _ index : Int) -> Int {
        // Store it in current node of the segment tree and return
        if (start == end) {
            self.segArr[index] = input[start]
            return input[start]
        }

        // If there are more than one elements,
        // then traverse left and right subtrees
        // and store the sum of values in current node.
        let mid : Int = (start + end) / 2
        self.segArr[index] = self.constructST( &input,start,mid,index * 2 + 1) + self.constructST( &input,mid + 1,end,index * 2 + 2)
        return self.segArr[index]
    }

    func getSum(_ start : Int, _ end : Int) -> Int {
        // Check for error conditions.
        if (start > end || start < 0 || end > self.size - 1) {
            print("Invalid Input.")
            return -1
        }
        return self.getSumUtil(0,self.size - 1,start,end,0)
    }

    func getSumUtil(_ segStart : Int, _ segEnd : Int, _ queryStart : Int, _ queryEnd : Int, _ index : Int) -> Int {
        if (queryStart <= segStart && segEnd <= queryEnd) {
            // complete overlapping case.
            return self.segArr[index]
        }

        if (segEnd < queryStart || queryEnd < segStart) {
            // no overlapping case.
            return 0
        }
		
        // Segment tree is partly overlaps with the query range.
        let mid : Int = (segStart + segEnd) / 2
        return self.getSumUtil(segStart,mid,queryStart,queryEnd,2 * index + 1) + self.getSumUtil(mid + 1,segEnd,queryStart,queryEnd,2 * index + 2)
    }

    func set(_ arr : inout [Int], _ ind : Int, _ val : Int) {
        // Check for error conditions.
        if (ind < 0 || ind > self.size - 1) {
            print("Invalid Input.")
            return
        }
        arr[ind] = val
        // Set new value in segment tree
        _ = self.setUtil(0,self.size - 1,ind,val,0)
    }

    // Always diff will be returned.
    func setUtil(_ segStart : Int, _ segEnd : Int, _ ind : Int, _ val : Int, _ index : Int) -> Int {
        // set index lies outside the range of current segment.
        // So diff to its parent node will be zero.
        if (ind < segStart || ind > segEnd) {
            return 0
        }

        // If the input index is in range of this node, then set the
        // value of the node and its children
        if (segStart == segEnd) {
            if (segStart == ind) {
                // Index that need to be set.
                let diff : Int = val - self.segArr[index]
                self.segArr[index] = val
                return diff
            } else {
                return 0
            }
        }

        let mid : Int = (segStart + segEnd) / 2
        let diff : Int = self.setUtil(segStart,mid,ind,val,2 * index + 1) + self.setUtil(mid + 1,segEnd,ind,val,2 * index + 2)
        
		// Current node value is set with diff.
        self.segArr[index] = self.segArr[index] + diff
        
		// Value of diff is propagated to the parent node.
        return diff
    }

}


var arr : [Int] = [1, 2, 4, 8, 16, 32, 64]
let tree : SegmentTree = SegmentTree(&arr)
print("Sum of values in the range(0, 3): " + String(tree.getSum(1,3)))
print("Sum of values of all the elements: " + String(tree.getSum(0,arr.count - 1)))
tree.set( &arr,1,10)
print("Sum of values in the range(0, 3): " + String(tree.getSum(1,3)))
print("Sum of values of all the elements: " + String(tree.getSum(0,arr.count - 1)))


/*
Sum of values in the range(0, 3): 14
Sum of values of all the elements: 127
Sum of values in the range(0, 3): 22
Sum of values of all the elements: 135
*/