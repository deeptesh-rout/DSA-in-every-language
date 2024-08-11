import Foundation

func printSubset(_ flags : inout [Bool], _ arr : inout [Int], _ size : Int) {
	var i : Int = 0
	while (i < size) {
		if (flags[i]) {
			print(String(arr[i]), terminator: " ")
		}
		i += 1
	}
	print()
}

func subsetSum(_ arr : inout [Int], _ n : Int, _ target : Int) {
	var flags : [Bool] = Array(repeating: false, count: n)
	subsetSum( &arr,n, &flags,0,0,target)
}

func subsetSum(_ arr : inout [Int], _ n : Int, _ flags : inout [Bool], _ sum : Int, _ curr : Int, _ target : Int) {
	if (target == sum) { // Solution found.
		printSubset( &flags, &arr,n)
		return
	}

	if (curr >= n || sum > target) { // constraint check and Backtracking.
		return
	}
	
	flags[curr] = true // Current element included.
	subsetSum( &arr,n, &flags,sum + arr[curr],curr + 1,target)
	flags[curr] = false // Current element excluded.
	subsetSum( &arr,n, &flags,sum,curr + 1,target)
}

// Testing code.
var arr : [Int] = [15, 22, 14, 26, 32, 9, 16, 8]
let target : Int = 53
let n : Int = arr.count
subsetSum( &arr,n,target)

/*
15 22 16 
15 14 16 8 
22 14 9 8 
*/