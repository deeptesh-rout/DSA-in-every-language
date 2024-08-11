import Foundation

// Greedy may be wrong.
func minCoins(_ coins : inout [Int], _ n : Int, _ value : Int) -> Int {
	var val : Int = value
	if (val <= 0) {
		return 0
	}
	var count : Int = 0
	coins = coins.sorted()
	var i : Int = n - 1
	while (i >= 0 && val > 0) {
		if (coins[i] <= val) {
			count += 1
			val -= coins[i]
		} else {
			i -= 1
		}
	}
	return (val == 0) ? count : -1
}

// Brute force.
func minCoins2(_ coins : inout [Int], _ n : Int, _ value : Int) -> Int {
	let val : Int = value
	if (val == 0) {
		return 0
	}
	var count : Int = Int.max
	var i : Int = 0
	while (i < n) {
		if (coins[i] <= val) {
			let subCount : Int = minCoins2( &coins,n,val - coins[i])
			if (subCount >= 0) {
				count = min(count,subCount + 1)
			}
		}
		i += 1
	}
	return (count != Int.max) ? count : -1
}

func minCoinsTD(_ coins : inout [Int], _ n : Int, _ val : Int) -> Int {
	var count : [Int] = Array(repeating: Int.max, count: val + 1)
	count[0] = 0 // zero val need zero coins.
	return minCoinsTD( &count, &coins,n,val)
}

func minCoinsTD(_ count : inout [Int], _ coins : inout [Int], _ n : Int, _ val : Int) -> Int {
	// Base Case
	if (count[val] != Int.max) {
		return count[val]
	}

	// Recursion
	var i : Int = 0
	while (i < n) {
		if (coins[i] <= val) { // For all possible coins
			// check validity of a sub-problem
			let subCount : Int = minCoinsTD( &count, &coins,n,val - coins[i])
			if (subCount != Int.max && count[val] > (subCount + 1)) {
				count[val] = subCount + 1
			}
		}
		i += 1
	}
	return count[val]
}
func minCoinsBU(_ coins : inout [Int], _ n : Int, _ val : Int) -> Int {
	// DP bottom up approach.
	var count : [Int] = Array(repeating: Int.max, count: val + 1)
	count[0] = 0

	// Base value.
	var i : Int = 1
	while (i <= val) {
		var j : Int = 0
		while (j < n) {
			// For all coins smaller than or equal to i.
			if (coins[j] <= i && count[i - coins[j]] != Int.max && count[i] > count[i - coins[j]] + 1) {
				count[i] = count[i - coins[j]] + 1
			}
			j += 1
		}
		i += 1
	}
	return (count[val] != Int.max) ? count[val] : -1
}

func printCoinsUtil(_ cvalue : inout [Int], _ val : Int) {
	if (val > 0) {
		printCoinsUtil( &cvalue,val - cvalue[val])
		print(String(cvalue[val]), terminator: " ")
	}
}

func printCoins(_ cvalue : inout [Int], _ val : Int) {
	print("Coins are : ",terminator: "")
	printCoinsUtil( &cvalue,val)
	print()
}

// DP bottom up approach.
func minCoinsBU2(_ coins : inout [Int], _ n : Int, _ val : Int) -> Int {
	var count : [Int] = Array(repeating: Int.max, count: val + 1)
	var cvalue : [Int] = Array(repeating: Int.max, count: val + 1)
	count[0] = 0 // Base value.
	var i : Int = 1
	while (i <= val) {
		var j : Int = 0
		while (j < n) {
			// For all coins smaller than or equal to i.
			if (coins[j] <= i && count[i - coins[j]] != Int.max && count[i] > count[i - coins[j]] + 1) {
				count[i] = count[i - coins[j]] + 1
				cvalue[i] = coins[j]
			}
			j += 1
		}	
		i += 1
	}
	
	if (count[val] == Int.max) {
		return -1
	}
	printCoins( &cvalue,val)
	return count[val]
}

// Testing code.
var coins : [Int] = [5, 6]
let value : Int = 16
let n : Int = coins.count
print("Count is : " + String(minCoins( &coins,n,value)))
print("Count is : " + String(minCoins2( &coins,n,value)))
print("Count is : " + String(minCoinsTD( &coins,n,value)))
print("Count is : " + String(minCoinsBU( &coins,n,value)))
print("Count is : " + String(minCoinsBU2( &coins,n,value)))

/* 
Count is : -1
Count is : 3
Count is : 3
Count is : 3
Coins are : 6 5 5 
Count is : 3
 */