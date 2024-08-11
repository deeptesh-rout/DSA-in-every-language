import Foundation
// Palindromic Substrings

func largestPalinSubstr(_ str : String) -> Int {
	let n : Int = str.count
	var dp : [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
	var i : Int = 0
	while (i < n) {
		dp[i][i] = 1
		i += 1
	}
	
	var max : Int = 1
	var start : Int = 0
	var l : Int = 1
	while (l < n) {
		var i : Int = 0, j : Int = i + l
		while (j < n) {
			if (Array(str)[i] == Array(str)[j] && dp[i + 1][j - 1] == j - i - 1) {
				dp[i][j] = dp[i + 1][j - 1] + 2
				if (dp[i][j] > max) {
					max = dp[i][j]
					// Keeping track of max length and
					start = i
				}
			} else {
				dp[i][j] = 0
			}
			i += 1
			j += 1
		}
		l += 1
	}
	let str2 = (str.prefix(start + max)).suffix(max)
	print("Max Length Palindromic Substrings : " + str2)
	return max
}

// Testing code.
let str : String = "ABCAUCBCxxCBA"
print("Max Palindromic Substrings len:", largestPalinSubstr(str))

/* 
Max Length Palindromic Substrings : BCxxCB
Max Palindromic Substrings len: 6
 */
