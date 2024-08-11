import Foundation

func minStairCost(_ cost : inout [Int], _ n : Int) -> Int {
	// base case
	if (n == 1) {
		return cost[0]
	}

	var dp : [Int] = Array(repeating: 0, count: n)
	dp[0] = cost[0]
	dp[1] = cost[1]

	var i : Int = 2
	while (i < n) {
		dp[i] = min(dp[i - 1],dp[i - 2]) + cost[i]
		i += 1
	}
	return min(dp[n - 2],dp[n - 1])
}

// Testing code.
var a : [Int] = [1, 5, 6, 3, 4, 7, 9, 1, 2, 11]
let n : Int = a.count
print("minStairCost :", minStairCost( &a,n))

/*
minStairCost : 18
*/