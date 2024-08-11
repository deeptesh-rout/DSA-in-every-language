import Foundation

func gridUniqueWays(_ m : Int, _ n : Int) -> Int {
	var dp : [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)
	dp[0][0] = 1
	// Initialize first column.
	var i : Int = 1
	while (i < m) {
		dp[i][0] = dp[i - 1][0]
		i += 1
	}
	// Initialize first row.
	var j : Int = 1
	while (j < n) {
		dp[0][j] = dp[0][j - 1]
		j += 1
	}

	i = 1
	while (i < m) {
		j = 1
		while (j < n) {
			dp[i][j] = dp[i - 1][j] + dp[i][j - 1]
			j += 1
		}
		i += 1
	}
	return dp[m - 1][n - 1]
}

// Diagonal movement allowed.
func gridUnique3Ways(_ m : Int, _ n : Int) -> Int {
	var dp : [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: m)
	dp[0][0] = 1
	
	// Initialize first column.
	var i : Int = 1
	while (i < m) {
		dp[i][0] = dp[i - 1][0]
		i += 1
	}

	// Initialize first row.
	var j : Int = 1
	while (j < n) {
		dp[0][j] = dp[0][j - 1]
		j += 1
	}

	i = 1
	while (i < m) {
		j = 1
		while (j < n) {
			dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j] + dp[i][j - 1]
			j += 1
		}
		i += 1
	}
	return dp[m - 1][n - 1]
}

// Testing code.
print(gridUniqueWays(3,3))
print(gridUnique3Ways(3,3))
/* 
6
13
 */
