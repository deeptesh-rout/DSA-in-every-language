import Foundation
// Palindromic Subsequence

func largestPalindromicSubseq(_ str : String) -> Int {
	let n : Int = str.count
	var dp : [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
	var i : Int = 0
	while (i < n) {
		dp[i][i] = 1 // each char is itself palindromic with length 1
		i += 1
	}
	
	var l : Int = 1
	while (l < n) {
		var i : Int = 0, j : Int = l
		while (j < n) {
			if (Array(str)[i] == Array(str)[j]) {
				dp[i][j] = dp[i + 1][j - 1] + 2
			} else {
				dp[i][j] = max(dp[i + 1][j],dp[i][j - 1])
			}
			i += 1
			j += 1
		}
		l += 1
	}
	return dp[0][n - 1]
}

// Testing code.
let str : String = "ABCAUCBCxxCBA"
print("Largest Palindromic Subseq:", largestPalindromicSubseq(str))

// Largest Palindromic Subseq: 9