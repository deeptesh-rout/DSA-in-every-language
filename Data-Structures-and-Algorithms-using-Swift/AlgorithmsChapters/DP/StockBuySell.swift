import Foundation
func stockBuySellProfit(_ arr : inout [Int]) -> Int {
	var buyProfit : Int = -arr[0] // Buy stock profit
	var sellProfit : Int = 0 // Sell stock profit
	let n : Int = arr.count

	var i : Int = 1
	while (i < n) {
		let newBuyProfit : Int = (sellProfit - arr[i] > buyProfit) ? sellProfit - arr[i] : buyProfit
		let newSellProfit : Int = (buyProfit + arr[i] > sellProfit) ? buyProfit + arr[i] : sellProfit
		buyProfit = newBuyProfit
		sellProfit = newSellProfit
		i += 1
	}
	return sellProfit
}

func stockBuySellProfitTC(_ arr : inout [Int], _ t : Int) -> Int {
	var buyProfit : Int = -arr[0]
	var sellProfit : Int = 0
	let n : Int = arr.count

	var i : Int = 1
	while (i < n) {
		let newBuyProfit : Int = ((sellProfit - arr[i]) > buyProfit) ? (sellProfit - arr[i]) : buyProfit
		let newSellProfit : Int = ((buyProfit + arr[i] - t) > sellProfit) ? (buyProfit + arr[i] - t) : sellProfit
		buyProfit = newBuyProfit
		sellProfit = newSellProfit
		i += 1
	}
	return sellProfit
}

func stockBuySellProfit2(_ arr : inout [Int]) -> Int {
	let n : Int = arr.count
	var dp : [[Int]] = Array(repeating: Array(repeating: 0, count: 2), count: n)
	dp[0][0] = -arr[0] // Buy stock profit
	dp[0][1] = 0 // Sell stock profit

	var i : Int = 1
	while (i < n) {
		dp[i][0] = (dp[i - 1][1] - arr[i] > dp[i - 1][0]) ? dp[i - 1][1] - arr[i] : dp[i - 1][0]
		dp[i][1] = (dp[i - 1][0] + arr[i] > dp[i - 1][1]) ? dp[i - 1][0] + arr[i] : dp[i - 1][1]
		i += 1
	}
	return dp[n - 1][1]
}

func stockBuySellProfitTC2(_ arr : inout [Int], _ t : Int) -> Int {
	let n : Int = arr.count
	var dp : [[Int]] = Array(repeating: Array(repeating: 0, count: 2), count: n)
	dp[0][0] = -arr[0]
	dp[0][1] = 0

	var i : Int = 1
	while (i < n) {
		dp[i][0] = ((dp[i - 1][1] - arr[i]) > dp[i - 1][0]) ? (dp[i - 1][1] - arr[i]) : dp[i - 1][0]
		dp[i][1] = ((dp[i - 1][0] + arr[i] - t) > dp[i - 1][1]) ? (dp[i - 1][0] + arr[i] - t) : dp[i - 1][1]
		i += 1
	}
	return dp[n - 1][1]
}

// Testing code.
var arr : [Int] = [10, 12, 9, 23, 25, 55, 49, 70]
print("Total profit: " + String(stockBuySellProfit( &arr)))
print("Total profit: " + String(stockBuySellProfit2( &arr)))
print("Total profit: " + String(stockBuySellProfitTC( &arr,2)))
print("Total profit: " + String(stockBuySellProfitTC2( &arr,2)))

/*
Total profit: 69
Total profit: 69
Total profit: 63
Total profit: 63
*/