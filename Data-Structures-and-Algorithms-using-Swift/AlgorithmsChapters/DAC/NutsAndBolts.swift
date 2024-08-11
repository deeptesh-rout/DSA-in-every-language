import Foundation

func makePairs(_ nuts : inout [Int], _ bolts : inout [Int]) {
	makePairs( &nuts, &bolts,0,nuts.count - 1)
	print("Matched nuts and bolts are :", nuts, bolts)
}

// Quick sort kind of approach.
func makePairs(_ nuts : inout [Int], _ bolts : inout [Int], _ low : Int, _ high : Int) {
	if (low < high) {
		// Choose first element of bolts array as pivot to partition nuts.
		let pivot : Int = partition( &nuts,low,high,bolts[low])
		// Using nuts[pivot] as pivot to partition bolts.
		_ = partition( &bolts,low,high,nuts[pivot])
		// Recursively lower and upper half of nuts and bolts are matched.
		makePairs( &nuts, &bolts,low,pivot - 1)
		makePairs( &nuts, &bolts,pivot + 1,high)
	}
}

// Partition method similar to quick sort algorithm.
func partition(_ arr : inout [Int], _ low : Int, _ high : Int, _ pivot : Int) -> Int {
	var i : Int = low
	var j : Int = low
	while (j < high) {
		if (arr[j] < pivot) {
			arr.swapAt(i,j)
			i += 1
		} else if (arr[j] == pivot) {
			arr.swapAt(high,j)
			j -= 1
		}
		j += 1
	}
	arr.swapAt(i,high)
	return i
}

// Testing code.
var nuts : [Int] = [1, 2, 6, 5, 4, 3]
var bolts : [Int] = [6, 4, 5, 1, 3, 2]
makePairs( &nuts, &bolts)

/*
Matched nuts and bolts are : [1, 2, 3, 4, 5, 6] [1, 2, 3, 4, 5, 6]
*/