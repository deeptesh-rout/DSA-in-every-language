import Foundation

func min(_ x : Int, _ y : Int, _ z : Int) -> Int {
	return min(min(x,y), z)
}

func editDist(_ str1 : String, _ str2 : String) -> Int {
	let m : Int = str1.count
	let n : Int = str2.count
	return editDist(str1,str2,m,n)
}

func editDist(_ str1 : String, _ str2 : String, _ m : Int, _ n : Int) -> Int {
	// If any one string is empty, then empty the other string.
	if (m == 0 || n == 0) {
		return m + n
	}
	// If last characters of both strings are same, ignore last characters.
	if (Array(str1)[m - 1] == Array(str2)[n - 1]) {
		return editDist(str1,str2,m - 1,n - 1)
	}
	// If last characters are not same, consider all three operations:
	// (1) Insert last char of second into first.
	// (2) Remove last char of first.
	// (3) Replace last char of first with second.
	return 1 + min(editDist(str1,str2,m,n - 1), // Insert
	editDist(str1,str2,m - 1,n), // Remove
	editDist(str1,str2,m - 1,n - 1)) // Replace
}

func editDistDP(_ str1 : String, _ str2 : String) -> Int {
	let m : Int = str1.count
	let n : Int = str2.count
	var dp : [[Int]] = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)

	// Fill dp[][] in bottom up manner.
	var i : Int = 0
	while (i <= m) {
		var j : Int = 0
		while (j <= n) {
			// If any one string is empty, then empty the other string.
			if (i == 0 || j == 0) {
				dp[i][j] = (i + j)
			} else if (Array(str1)[i - 1] == Array(str2)[j - 1]) {
				dp[i][j] = dp[i - 1][j - 1]
			} else {
				dp[i][j] = 1 + min(dp[i][j - 1], // Insert
				dp[i - 1][j],  // Remove
				dp[i - 1][j - 1])
			}
			j += 1
		}
		i += 1
	} 
	return dp[m][n]
}

// Testing code.
let str1 : String = "sunday"
let str2 : String = "saturday"
print(editDist(str1,str2))
print(editDistDP(str1,str2))

/*
3
3
*/