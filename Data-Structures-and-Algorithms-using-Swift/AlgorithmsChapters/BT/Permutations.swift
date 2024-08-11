import Foundation

func permutation(_ arr : inout [Int], _ i : Int, _ length : Int) {
	if (length == i) {
		print(arr)
		return
	}
	var j : Int = i
	while (j < length) {
		arr.swapAt(i,j)
		permutation( &arr,i + 1,length)
		arr.swapAt(i,j)
		j += 1
	}
	return
}
// 	1 2 3 4 
// 	1 2 4 3 
// 	.....
// 	4 1 3 2 
// 	4 1 2 3

func isValid(_ arr : inout [Int], _ n : Int) -> Bool {
	var j : Int = 1
	while (j < n) {
		if (abs(arr[j] - arr[j - 1]) < 2) {
			return false
		}
		j += 1
	}
	return true
}

func permutation2(_ arr : inout [Int], _ i : Int, _ length : Int) {
	if (length == i) {
		if (isValid( &arr,length)) {
			print(arr)
		}
		return
	}

	var j : Int = i
	while (j < length) {
		arr.swapAt(i,j)
		permutation2( &arr,i + 1,length)
		arr.swapAt(i,j)
		j += 1
	}
	return
}

func isValid2(_ arr : inout [Int], _ i : Int) -> Bool {
	if (i < 1 || abs(arr[i] - arr[i - 1]) >= 2) {
		return true
	}
	return false
}

func permutation3(_ arr : inout [Int], _ i : Int, _ length : Int) {
	if (length == i) {
		print(arr)
		return
	}
	var j : Int = i
	while (j < length) {
		arr.swapAt(i,j)
		if (isValid2( &arr,i)) {permutation3( &arr,i + 1,length)
		}
		arr.swapAt(i,j)
		j += 1
	}
	return
}
	
// Testing code
var arr : [Int] = [1, 2, 3, 4]
permutation( &arr,0,4)
print()
permutation2( &arr,0,4)
print()
permutation3( &arr,0,4)

/* 
[1, 2, 3, 4]
[1, 2, 4, 3]
...
[4, 1, 3, 2]
[4, 1, 2, 3]

[2, 4, 1, 3]
[3, 1, 4, 2]

[2, 4, 1, 3]
[3, 1, 4, 2]
 */