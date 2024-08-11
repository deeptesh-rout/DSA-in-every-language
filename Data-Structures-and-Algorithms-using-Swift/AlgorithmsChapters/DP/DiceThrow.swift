import Foundation
func findWays(_ n : Int, _ m : Int, _ V : Int) -> Int {
	var dp : [[Int]] = Array(repeating: Array(repeating: 0, count: V + 1), count: n + 1)
	var j : Int = 1, i : Int, k : Int 
	// Table entries for only one dice.
	while (j <= m && j <= V) {
		dp[1][j] = 1
		j += 1
	}

	// i is number of dice, j is Value, k value of dice.
	i = 2
	while (i <= n) {
		j = 1
		while (j <= V) {
			k = 1
			while (k <= j && k <= m) {
				dp[i][j] += dp[i - 1][j - k]
				k += 1
			}
			j += 1
		}
		i += 1
	}
	return dp[n][V]
}

// Testing code.
print(findWays(3,6,6))

// 10
