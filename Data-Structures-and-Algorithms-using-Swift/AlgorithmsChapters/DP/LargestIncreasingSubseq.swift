import Foundation
func lis(_ arr : inout [Int]) -> Int {
	let n : Int = arr.count
	var lis : [Int] = Array(repeating: 0, count: n)
	var mx : Int = 0
	
	// Populating LIS values in bottom up manner.
	var i : Int = 0
	while (i < n) {
		lis[i] = 1 // Initialize LIS values for all indexes as 1.
		var j : Int = 0
		while (j < i) {
			if (arr[j] < arr[i] && lis[i] < lis[j] + 1) {
				lis[i] = lis[j] + 1
			}
			j += 1
		}
		
		if (mx < lis[i]) { // Max LIS values.
			mx = lis[i]
		}
		i += 1
	}
	return mx
}

// Testing code.
var arr : [Int] = [10, 12, 9, 23, 25, 55, 49, 70]
print("Length of lis is", lis( &arr))

// Length of lis is 6