import Foundation
class rangeMaxST {
    var segArr : [Int]
    var n : Int

    init(_ input : inout [Int]) {
        self.n = input.count 
		
        // Height of segment tree.
        let x : Int = Int((ceil(log(Double(n)) / log(2))))

        // Maximum size of segment tree
        let max_size : Int = 2 * Int(pow(Double(2),Double(x))) - 1

        // Allocate memory for segment tree
        self.segArr = Array(repeating: 0, count: max_size)
        _ = self.constructST( &input,0,self.n - 1,0)
    }

    func constructST(_ input : inout [Int], _ start : Int, _ end : Int, _ index : Int) -> Int {
        // Store it in current node of the segment tree and return
        if (start == end) {
            self.segArr[index] = input[start]
            return input[start]
        }
        // If there are more than one elements, then traverse left and right subtrees
        // and store the minimum of values in current node.
        let mid : Int = (start + end) / 2
        self.segArr[index] = max(self.constructST( &input,start,mid,index * 2 + 1),self.constructST( &input,mid + 1,end,index * 2 + 2))
        return self.segArr[index]
    }

func getMax(_ start : Int, _ end : Int) -> Int {
    // Check for error conditions.
    if (start > end || start < 0 || end > self.n - 1) {
        print("Invalid Input.")
        return Int.min
    }
    return self.getMaxUtil(0,self.n - 1,start,end,0)
}

func getMaxUtil(_ segStart : Int, _ segEnd : Int, _ queryStart : Int, _ queryEnd : Int, _ index : Int) -> Int {
    if (queryStart <= segStart && segEnd <= queryEnd) { // complete overlapping case.
        return self.segArr[index]
    }
	
    if (segEnd < queryStart || queryEnd < segStart) {  // no overlapping case.
        return Int.min
    }

    // Segment tree is partly overlaps with the query range.
    let mid : Int = (segStart + segEnd) / 2
    return max(self.getMaxUtil(segStart,mid,queryStart,queryEnd,2 * index + 1),self.getMaxUtil(mid + 1,segEnd,queryStart,queryEnd,2 * index + 2))
}

func update(_ ind : Int, _ val : Int) {
    // Check for error conditions.
    if (ind < 0 || ind > self.n - 1) {
        print("Invalid Input.")
        return
    }
    // Update the values in segment tree
    _ = self.updateUtil(0,self.n - 1,ind,val,0)
}

// Always min inside valid range will be returned.
func updateUtil(_ segStart : Int, _ segEnd : Int, _ ind : Int, _ val : Int, _ index : Int) -> Int {
    // Update index lies outside the range of current segment.
    // So minimum will not change.
    if (ind < segStart || ind > segEnd) {
        return self.segArr[index]
    }
    // If the input index is in range of this node, then update the
    // value of the node and its children
    if (segStart == segEnd) {
        if (segStart == ind) {
            // Index value need to be updated.
            self.segArr[index] = val
            return val
        } else {
            return self.segArr[index]
        }
    }
    let mid : Int = (segStart + segEnd) / 2
    // Current node value is updated with min.
    self.segArr[index] = max(self.updateUtil(segStart,mid,ind,val,2 * index + 1),self.updateUtil(mid + 1,segEnd,ind,val,2 * index + 2))
    // Value of diff is propagated to the parent node.
    return self.segArr[index]
}
}

var arr : [Int] = [1, 8, 2, 7, 3, 6, 4, 5]
let tree : rangeMaxST = rangeMaxST(&arr)
print("Max value in the range(1, 5): " + String(tree.getMax(1,5)))
print("Max value in the range(2, 7): " + String(tree.getMax(2,7)))
print("Max value of all the elements: " + String(tree.getMax(0,arr.count - 1)))
tree.update(2,9)
print("Max value in the range(1, 5): " + String(tree.getMax(1,5)))
print("Max value of all the elements: " + String(tree.getMax(0,arr.count - 1)))

/* 
Max value in the range(1, 5): 8
Max value in the range(2, 7): 7
Max value of all the elements: 8
Max value in the range(1, 5): 9
Max value of all the elements: 9
 */