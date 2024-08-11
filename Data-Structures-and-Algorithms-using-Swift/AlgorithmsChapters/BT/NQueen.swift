import Foundation

func feasible(_ Q : inout [Int], _ k : Int) -> Bool {
	var i : Int = 0
	while (i < k) {
		if (Q[k] == Q[i] || abs(Q[i] - Q[k]) == abs(i - k)) {
			return false
		}
		i += 1
	}
	return true
}

func nQueens(_ Q : inout [Int], _ k : Int, _ n : Int) {
	if (k == n) {
		print(Q)
		return
	}

	var i : Int = 0
	while (i < n) {
		Q[k] = i
		if (feasible( &Q,k)) {
			nQueens( &Q,k + 1,n)
		}
		i += 1
	}
}

// Testing code.
var Q : [Int] = Array(repeating: 0, count: 8)
nQueens( &Q,0,8)

/* 
[0, 4, 7, 5, 2, 6, 1, 3]
[0, 5, 7, 2, 6, 3, 1, 4]
...
[7, 2, 0, 5, 1, 4, 6, 3]
[7, 3, 0, 2, 5, 1, 6, 4]
 */