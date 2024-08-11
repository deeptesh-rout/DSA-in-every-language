import Foundation

func maxCost01Knapsack(_ wt : inout [Int], _ cost : inout [Int], _ capacity : Int) -> Int {
	let n : Int = wt.count
	return maxCost01KnapsackUtil( &wt, &cost,n,capacity)
}

func maxCost01KnapsackUtil(_ wt : inout [Int], _ cost : inout [Int], _ n : Int, _ capacity : Int) -> Int {
	// Base Case
	if (n == 0 || capacity == 0) {
		return 0
	}

	// Return the maximum of two cases:
	// (1) nth item is included
	// (2) nth item is not included
	var first : Int = 0
	if (wt[n - 1] <= capacity) {
		first = cost[n - 1] + maxCost01KnapsackUtil( &wt, &cost,n - 1,capacity - wt[n - 1])
	}
	let second : Int = maxCost01KnapsackUtil( &wt, &cost,n - 1,capacity)
	return max(first,second)
}

func maxCost01KnapsackTD(_ wt : inout [Int], _ cost : inout [Int], _ capacity : Int) -> Int {
	let n : Int = wt.count
	var dp : [[Int]] = Array(repeating: Array(repeating: 0, count: n + 1), count: capacity + 1)
	return maxCost01KnapsackTD( &dp, &wt, &cost,n,capacity)
}

func maxCost01KnapsackTD(_ dp : inout [[Int]], _ wt : inout [Int], _ cost : inout [Int], _ i : Int, _ w : Int) -> Int {
	if (w == 0 || i == 0) {
		return 0
	}

	if (dp[w][i] != 0) {
		return dp[w][i]
	}

	// Their are two cases:
	// (1) ith item is included
	// (2) ith item is not included
	var first : Int = 0
	if (wt[i - 1] <= w) {
		first = maxCost01KnapsackTD( &dp, &wt, &cost,i - 1,w - wt[i - 1]) + cost[i - 1]
	}
	let second : Int = maxCost01KnapsackTD( &dp, &wt, &cost,i - 1,w)
	dp[w][i] = max(first,second)
	return dp[w][i]
}

func maxCost01KnapsackBU(_ wt : inout [Int], _ cost : inout [Int], _ capacity : Int) -> Int {
	let n : Int = wt.count
	var dp : [[Int]] = Array(repeating: Array(repeating: 0, count: n + 1), count: capacity + 1)

	// Build table dp[][] in bottom up approach.
	// Weights considered against capacity.
	var w : Int = 1
	while (w <= capacity) {
		var i : Int = 1
		while (i <= n) {
			// Their are two cases:
			// (1) ith item is included
			// (2) ith item is not included
			var first : Int = 0
			if (wt[i - 1] <= w) {
				first = dp[w - wt[i - 1]][i - 1] + cost[i - 1]
			}
			let second : Int = dp[w][i - 1]
			dp[w][i] = max(first,second)
			i += 1
		}
		w += 1
	}
	printItems( &dp, &wt, &cost,n,capacity)
	return dp[capacity][n]
}

func printItems(_ dp : inout [[Int]], _ wt : inout [Int], _ cost : inout [Int], _ n : Int, _ capa : Int) {
	var capacity : Int = capa
	var totalCost : Int = dp[capacity][n]
	print("Selected items are:",terminator: "")
	var i : Int = n - 1
	while (i > 0) {
		if (totalCost != dp[capacity][i - 1]) {
			print(" (wt:" + String(wt[i]) + ", cost:" + String(cost[i]) + ")",terminator: "")
			capacity -= wt[i]
			totalCost -= cost[i]
		}
		i -= 1
	}
}

func KS01UnboundBU(_ wt : inout [Int], _ cost : inout [Int], _ capacity : Int) -> Int {
	let n : Int = wt.count
	var dp : [Int] = Array(repeating: 0, count: capacity + 1)
	
	// Build table dp[] in bottom up approach.
	// Weights considered against capacity.
	var w : Int = 1
	while (w <= capacity) {
		var i : Int = 1
		while (i <= n) {
			// Their are two cases:
			// (1) ith item is included
			// (2) ith item is not included
			if (wt[i - 1] <= w) {
				dp[w] = max(dp[w],dp[w - wt[i - 1]] + cost[i - 1])
			}
			i += 1
		}
		w += 1
	}
	return dp[capacity]
}

// Testing code.
var wt : [Int] = 	[10, 40, 20, 30]
var cost : [Int] = 	[60, 40, 90, 120]
let capacity : Int = 50
var maxCost = maxCost01Knapsack( &wt, &cost,capacity)
print("Maximum cost obtained =", maxCost)
maxCost = maxCost01KnapsackBU( &wt, &cost,capacity)
print("Maximum cost obtained =", maxCost)
maxCost = maxCost01KnapsackTD( &wt, &cost,capacity)
print("Maximum cost obtained =", maxCost)
maxCost = KS01UnboundBU( &wt, &cost,capacity)
print("Maximum cost obtained =", maxCost)

/* 
Maximum cost obtained = 300
Maximum cost obtained = 210
Selected items are: (wt:30, cost:120) (wt:20, cost:90)
Maximum cost obtained = 210
Maximum cost obtained = 210
 */
