import Foundation

func maxRobbery(_ house : inout [Int]) -> Int {
	let n : Int = house.count
	var dp : [Int] = Array(repeating: 0, count: n)
	dp[0] = house[0]
	dp[1] = house[1]
	dp[2] = dp[0] + house[2]

	var i : Int = 3
	while (i < n) {
		dp[i] = max(dp[i - 2],dp[i - 3]) + house[i]
		i += 1
	}
	return max(dp[n - 1],dp[n - 2])
}

func maxRobbery2(_ house : inout [Int]) -> Int {
	let n : Int = house.count
	var dp : [[Int]] = Array(repeating: Array(repeating: 0, count: 2), count: n)
	dp[0][1] = house[0]
	dp[0][0] = 0

	var i : Int = 1
	while (i < n) {
		dp[i][1] = max(dp[i - 1][0] + house[i],dp[i - 1][1])
		dp[i][0] = dp[i - 1][1]
		i += 1
	}
	return max(dp[n - 1][1],dp[n - 1][0])
}

// Testing code.
var arr : [Int] = [10, 12, 9, 23, 25, 55, 49, 70]
print("Total cash: " + String(maxRobbery( &arr)))
print("Total cash: " + String(maxRobbery2( &arr)))

/* 
Total cash: 160
Total cash: 160
*/