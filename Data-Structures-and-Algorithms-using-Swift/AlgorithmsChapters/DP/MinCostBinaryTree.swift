import Foundation

func maxVal(_ maxi: inout [[Int]], _ i : Int, _ j : Int) -> Int {
	if (maxi[i][j] != Int.min) {
		return maxi[i][j]
	}

	var k : Int = i
	while (k < j) {
		maxi[i][j] = max(maxi[i][j], max(maxVal( &maxi,i,k), maxVal( &maxi,k + 1,j)))
		k += 1
	}
	return maxi[i][j]
}

func minCostBstTD(_ dp : inout [[Int]], _ maxi: inout [[Int]], _ i : Int, _ j : Int, _ arr : inout [Int]) -> Int {
	if (j <= i) {
		return 0
	}

	if (dp[i][j] != Int.max) {
		return dp[i][j]
	}

	var k : Int = i
	while (k < j) {
		dp[i][j] = min(dp[i][j],minCostBstTD( &dp, &maxi,i,k, &arr) + minCostBstTD( &dp, &maxi,k + 1,j, &arr) + maxVal( &maxi,i,k) * maxVal( &maxi,k + 1,j))
		k += 1
	}
	return dp[i][j]
}

func minCostBstTD(_ arr : inout [Int]) -> Int {
	let n : Int = arr.count
	var dp : [[Int]] = Array(repeating: Array(repeating: Int.max, count: n), count: n)
	var maxi: [[Int]] = Array(repeating: Array(repeating: Int.min, count: n), count: n)
	var i : Int = 0
	while (i < n) {
		maxi[i][i] = arr[i]
		i += 1
	}
	return minCostBstTD( &dp, &maxi,0,n - 1, &arr)
}

func minCostBstBU(_ arr : inout [Int]) -> Int {
	let n : Int = arr.count
	var dp : [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
	var maxi: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)

	var i : Int = 0
	while (i < n) {
		maxi[i][i] = arr[i]
		i += 1
	}

	var l : Int = 1
	while (l < n) { // l is length of range.
		var i : Int = 0, j : Int = i + l
		while (j < n) {
			dp[i][j] = Int.max
			var k : Int = i
			while (k < j) {
				dp[i][j] = min(dp[i][j],dp[i][k] + dp[k + 1][j] + maxi[i][k] * maxi[k + 1][j])
				maxi[i][j] = max(maxi[i][k], maxi[k + 1][j])
				k += 1
			}
			i += 1
			j += 1
		}
		l += 1
	}
	return dp[0][n - 1]
}

// Testing code.
var arr : [Int] = [6, 2, 4]
print("Total cost: " + String(minCostBstTD( &arr)))
print("Total cost: " + String(minCostBstBU( &arr)))

/*
Total cost: 32
Total cost: 32
*/