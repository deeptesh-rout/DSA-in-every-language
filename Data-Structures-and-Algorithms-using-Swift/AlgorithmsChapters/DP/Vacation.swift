import Foundation

// days are must travel days, costs are cost of tickets.
func minCostTravel(_ days : inout [Int], _ costs : inout [Int]) -> Int {
	let n : Int = days.count
	let mx : Int = days[n - 1]
	var dp : [Int] = Array(repeating: 0, count: mx + 1)
	var j : Int = 0
	var i : Int = 1
	while (i <= mx) {
		if (days[j] == i) { // That days is definitely travelled.
			j += 1
			dp[i] = dp[i - 1] + costs[0]
			dp[i] = min(dp[i], dp[max(0, i - 7)] + costs[1])
			dp[i] = min(dp[i], dp[max(0, i - 30)] + costs[2])
		} else {
			dp[i] = dp[i - 1]
		}
		i += 1
	}
	return dp[mx]
}

// Testing code.
var days : [Int] = [1, 3, 5, 7, 12, 20, 30]
var costs : [Int] = [2, 7, 20]
print("Min cost is:" + String(minCostTravel( &days, &costs)))

/*
Min cost is:13
*/