import Foundation

func min(_ x : Int, _ y : Int, _ z : Int) -> Int {
	return min(min(x,y), z)
}

func minCost(_ cost : inout [[Int]], _ m : Int, _ n : Int) -> Int {
	if (m == 0 || n == 0) {
		return 99999
	}
	if (m == 1 && n == 1) {
		return cost[0][0]
	}
	return cost[m - 1][n - 1] + min(minCost( &cost,m - 1,n - 1),minCost( &cost,m - 1,n),minCost( &cost,m,n - 1))
}

func minCostBU(_ cost : inout [[Int]], _ m : Int, _ n : Int) -> Int {
	var tc : [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)
	tc[0][0] = cost[0][0]
	
	var i : Int = 1 // Initialize first column.
	while (i < m) {
		tc[i][0] = tc[i - 1][0] + cost[i][0]
		i += 1
	}

	var j : Int = 1 // Initialize first row.
	while (j < n) {
		tc[0][j] = tc[0][j - 1] + cost[0][j]
		j += 1
	}

	i = 1
	while (i < m) {
		j = 1
		while (j < n) {
			tc[i][j] = cost[i][j] + min(tc[i - 1][j - 1],tc[i - 1][j],tc[i][j - 1])
			j += 1
		}
		i += 1
	}
	
	return tc[m - 1][n - 1]
}

// Testing code.
var cost : [[Int]] = [[1, 3, 4],[4, 7, 5],[1, 5, 3]]
print(minCost( &cost,3,3))
print(minCostBU( &cost,3,3))

/* 
11
11
 */
