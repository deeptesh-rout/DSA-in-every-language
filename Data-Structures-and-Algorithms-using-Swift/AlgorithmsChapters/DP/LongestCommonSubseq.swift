import Foundation

func LCSubSeq(_ st1 : String, _ st2 : String) -> Int {
	var X : [Character] = Array(st1)
	let Y : [Character] = Array(st2)
	let m : Int = st1.count
	let n : Int = st2.count
	var dp : [[Int]] = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
	var p : [[Int]] = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)

	// Fill dp array in bottom up fashion.
	var i : Int = 1
	while (i <= m) {
		var j : Int = 1
		while (j <= n) {
			if (X[i - 1] == Y[j - 1]) {
				dp[i][j] = dp[i - 1][j - 1] + 1
				p[i][j] = 0
			} else {
				dp[i][j] = (dp[i - 1][j] > dp[i][j - 1]) ? dp[i - 1][j] : dp[i][j - 1]
				p[i][j] = (dp[i - 1][j] > dp[i][j - 1]) ? 1 : 2
			}
			j += 1
		}
		i += 1
	}
	
	PrintLCS(&p, &X,m,n)
	print()
	return dp[m][n]
}

func PrintLCS(_ p : inout [[Int]], _ X : inout [Character], _ i : Int, _ j : Int) {
	if (i == 0 || j == 0) {
		return
	}
	if (p[i][j] == 0) {
		PrintLCS( &p, &X,i - 1,j - 1)
		print(X[i - 1],terminator: "")
	} else if (p[i][j] == 1) {
		PrintLCS( &p, &X,i - 1,j)
	} else {
		PrintLCS( &p, &X,i,j - 1)
	}
}

// Testing code.
let X : String = "carpenter"
let Y : String = "sharpener"
print(LCSubSeq(X,Y))

/* 
arpener
7
 */