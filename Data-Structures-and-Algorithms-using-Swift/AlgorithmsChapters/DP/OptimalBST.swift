import Foundation
func optBstCost(_ freq : inout [Int], _ i : Int, _ j : Int) -> Int {
	if (i > j) {
		return 0
	}

	if (j == i) {
		return freq[i] // one element in this subarray
	}

	var mini : Int = Int.max
	var r : Int = i
	while (r <= j) {
		mini = min(mini, optBstCost( &freq,i,r - 1) + optBstCost( &freq,r + 1,j))
		r += 1
	}
	return mini + sum( &freq,i,j)
}

func optBstCost(_ keys : inout [Int], _ freq : inout [Int]) -> Int {
	let n : Int = freq.count
	return optBstCost( &freq,0,n - 1)
}

func optBstCostTD(_ keys : inout [Int], _ freq : inout [Int]) -> Int {
	let n : Int = freq.count
	var cost : [[Int]] = Array(repeating: Array(repeating: Int.max, count: n), count: n)
	var i : Int = 0
	while (i < n) {
		cost[i][i] = freq[i]
		i += 1
	}
	return optBstCostTD( &freq, &cost,0,n - 1)
}

func optBstCostTD(_ freq : inout [Int], _ cost : inout [[Int]], _ i : Int, _ j : Int) -> Int {
	if (i > j) {
		return 0
	}

	if (cost[i][j] != Int.max) {
		return cost[i][j]
	}

	let s : Int = sum( &freq,i,j)
	var r : Int = i
	while (r <= j) {
		cost[i][j] = min(cost[i][j],optBstCostTD( &freq, &cost,i,r - 1) + optBstCostTD( &freq, &cost,r + 1,j) + s)
		r += 1
	}
	return cost[i][j]
}

func sum(_ freq : inout [Int], _ i : Int, _ j : Int) -> Int {
	var s : Int = 0
	var k : Int = i
	while (k <= j) {
		s += freq[k]
		k += 1
	}
	return s
}

func sumInit(_ freq : inout [Int], _ n : Int) -> [Int] {
	var sum : [Int] = Array(repeating: 0, count: n)
	sum[0] = freq[0]
	var i : Int = 1
	while (i < n) {
		sum[i] = sum[i - 1] + freq[i]
		i += 1
	}
	return sum
}

func sumRange(_ sum : inout [Int], _ i : Int, _ j : Int) -> Int {
	if (i == 0) {
		return sum[j]
	}
	return sum[j] - sum[i - 1]
}

func optBstCostBU(_ keys : inout [Int], _ freq : inout [Int]) -> Int {
	let n : Int = freq.count
	var cost : [[Int]] = Array(repeating: Array(repeating: Int.max, count: n), count: n)
	var i : Int = 0
	while (i < n) {
		cost[i][i] = freq[i]
		i += 1
	}
	
	var sm : Int = 0
	var l : Int = 1
	while (l < n) { // l is length of range.
		var i : Int = 0, j : Int = i + l
		while (j < n) {
			sm = sum( &freq,i,j)
			var r : Int = i
			while (r <= j) {
				cost[i][j] = min(cost[i][j],sm + ((r - 1 >= i) ? cost[i][r - 1] : 0) + ((r + 1 <= j) ? cost[r + 1][j] : 0))
				r += 1
			}
			i += 1
			j += 1
		}
		l += 1
	}
	return cost[0][n - 1]
}

func optBstCostBU2(_ keys : inout [Int], _ freq : inout [Int]) -> Int {
	let n : Int = freq.count
	var cost : [[Int]] = Array(repeating: Array(repeating: Int.max, count: n), count: n)
	var sumArr : [Int] = sumInit( &freq,n)
	var i : Int = 0
	while (i < n) {
		cost[i][i] = freq[i]
		i += 1
	}
	
	var sm : Int = 0
	var l : Int = 1
	while (l < n) { // l is length of range.
		var i : Int = 0, j : Int = i + l
		while (j < n) {
			sm = sumRange( &sumArr,i,j)
			var r : Int = i
			while (r <= j) {
				cost[i][j] = min(cost[i][j],sm + ((r - 1 >= i) ? cost[i][r - 1] : 0) + ((r + 1 <= j) ? cost[r + 1][j] : 0))
				r += 1
			}
			i += 1
			j += 1
		}
		l += 1
	}
	return cost[0][n - 1]
}

// Testing code.
var keys : [Int] = [9, 15, 25]
var freq : [Int] = [30, 10, 40]
print("OBST cost:" + String(optBstCost( &keys, &freq)))
print("OBST cost:" + String(optBstCostTD( &keys, &freq)))
print("OBST cost:" + String(optBstCostBU( &keys, &freq)))
print("OBST cost:" + String(optBstCostBU2( &keys, &freq)))

/*
OBST cost:130
OBST cost:130
OBST cost:130
OBST cost:130
*/