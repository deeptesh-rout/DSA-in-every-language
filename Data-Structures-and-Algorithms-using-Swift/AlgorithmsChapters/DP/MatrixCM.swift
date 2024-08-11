import Foundation

func matrixChainMulBruteForce(_ p : inout [Int], _ i : Int, _ j : Int) -> Int {
	if (i == j) {
		return 0
	}
	var min : Int = Int.max
	
	// place parenthesis at different places between
	// first and last matrix, recursively calculate
	// count of multiplications for each parenthesis
	// placement and return the minimum count
	var k : Int = i
	while (k < j) {
		let count : Int = matrixChainMulBruteForce( &p,i,k) + 
		matrixChainMulBruteForce( &p,k+1,j) + p[i-1]*p[k]*p[j]

		if (count < min) {
			min = count
		}
		k += 1
	}
	return min // Return minimum count
}

func matrixChainMulBruteForce(_ p : inout [Int], _ n : Int) -> Int {
	return matrixChainMulBruteForce( &p, 1, n - 1)
}

func matrixChainMulTD(_ p : inout [Int], _ n : Int) -> Int {
	var dp : [[Int]] = Array(repeating: Array(repeating: Int.max, count: n), count: n)
	var i : Int = 1
	while (i < n) {
		dp[i][i] = 0
		i += 1
	}
	return matrixChainMulTD( &dp, &p,1,n - 1)
}

func matrixChainMulTD(_ dp : inout [[Int]], _ p : inout [Int], _ i : Int, _ j : Int) -> Int {
	// Base Case
	if (dp[i][j] != Int.max) {
		return dp[i][j]
	}
	// Recursion
	var k : Int = i
	while (k < j) {
		dp[i][j] = min(dp[i][j],matrixChainMulTD( &dp, &p,i,k) + matrixChainMulTD( &dp, &p,k + 1,j) + p[i - 1] * p[k] * p[j])
		k += 1
	}
	return dp[i][j]
}

func matrixChainMulBU(_ p : inout [Int], _ n : Int) -> Int {
	var dp : [[Int]] = Array(repeating: Array(repeating: Int.max, count: n), count: n)
	var i : Int = 1
	while (i < n) {
		dp[i][i] = 0
		i += 1
	}

	var l : Int = 1
	while (l < n) { // l is length of range.
		var i : Int = 1, j : Int = i + l
		while (j < n) {
			var k : Int = i
			while (k < j) {
				dp[i][j] = min(dp[i][j],dp[i][k] + p[i-1]*p[k]*p[j] + dp[k+1][j])
				k += 1
			}
			i += 1
			j += 1
		}
		l += 1
	}
	return dp[1][n - 1]
}

func PrintOptPar(_ n : Int, _ pos : inout [[Int]], _ i : Int, _ j : Int) {
	if (i == j)	{
		print("M" + String(pos[i][i]) + " ",terminator: "")
	} else {
		print("( ",terminator: "")
		PrintOptPar(n, &pos,i,pos[i][j])
		PrintOptPar(n, &pos,pos[i][j] + 1,j)
		print(") ",terminator: "")
	}
}

func PrintOptimalParenthesis(_ n : Int, _ pos : inout [[Int]]) {
	print("OptimalParenthesis : ",terminator: "")
	PrintOptPar(n, &pos,1,n - 1)
	print("")
}

func matrixChainMulBU2(_ p : inout [Int], _ n : Int) -> Int {
	var dp : [[Int]] = Array(repeating: Array(repeating: Int.max, count: n), count: n)
	var pos : [[Int]] = Array(repeating: Array(repeating: Int.max, count: n), count: n)

	var i : Int = 1
	while (i < n) {
		dp[i][i] = 0
		pos[i][i] = i
		i += 1
	}

	var l : Int = 1
	while (l < n) {  // l is length of range.
		var i : Int = 1, j : Int = i + l
		while (j < n) {
			var k : Int = i
			while (k < j) {
				dp[i][j] = min(dp[i][j],dp[i][k] + p[i - 1] * p[k] * p[j] + dp[k + 1][j])
				pos[i][j] = k
				k += 1
			}
			i += 1
			j += 1
		}
		l += 1
	}
	PrintOptimalParenthesis(n, &pos)
	return dp[1][n - 1]
}

// Testing code.
var arr : [Int] = [1, 2, 3, 4]
let n : Int = arr.count
print("Matrix Chain Multiplication is: ", matrixChainMulBruteForce( &arr,n))
print("Matrix Chain Multiplication is: ", matrixChainMulTD( &arr,n))
print("Matrix Chain Multiplication is: ", matrixChainMulBU( &arr,n))
print("Matrix Chain Multiplication is: ", matrixChainMulBU2( &arr,n))

/*
Matrix Chain Multiplication is: 18
Matrix Chain Multiplication is: 18
Matrix Chain Multiplication is: 18
OptimalParenthesis : ( ( M1 M2 ) M3 ) 
Matrix Chain Multiplication is: 18
 */