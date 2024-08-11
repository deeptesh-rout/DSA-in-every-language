import Foundation

func lbs(_ arr : inout [Int]) -> Int {
	let n : Int = arr.count
	var lis : [Int] = Array(repeating: 1, count: n)// Initialize LIS values for all indexes as 1.
	var lds : [Int] = Array(repeating: 1, count: n) // Initialize LDS values for all indexes as 1.
	var mx : Int = 0
	
	// Populating LIS values in bottom up manner.
	var i : Int = 0, j : Int
	while (i < n) {
		j = 0
		while (j < i) {
			if (arr[j] < arr[i] && lis[i] < lis[j] + 1) {
				lis[i] = lis[j] + 1
			}
			j += 1
		}
		i += 1
	}
	
	// Populating LDS values in bottom up manner.
	i = n - 1
	while (i > 0) {
		j = n - 1
		while (j > i) {
			if (arr[j] < arr[i] && lds[i] < lds[j] + 1) {
				lds[i] = lds[j] + 1
			}
			j -= 1
		}
		i -= 1
	}
	
	i = 0
	while (i < n) {
		mx = max(mx, lis[i] + lds[i] - 1)
		i += 1
	}
	return mx
}

// Testing code.
var arr : [Int] = [1, 6, 3, 11, 1, 9, 5, 12, 3, 14, 6, 17, 3, 19, 2, 19]
print("Length of lbs is", lbs( &arr))

// Length of lbs is 8