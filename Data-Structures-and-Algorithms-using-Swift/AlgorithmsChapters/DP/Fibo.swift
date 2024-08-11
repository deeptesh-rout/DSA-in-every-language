import Foundation

func fibonacci(_ n : Int) -> Int {
	if (n < 2) {
		return n
	}
	return fibonacci(n - 1) + fibonacci(n - 2)
}

func fibonacciBU(_ n : Int) -> Int {
	if (n < 2) {
		return n
	}

	var dp : [Int] = Array(repeating: 0, count: n + 1)
	dp[0] = 0
	dp[1] = 1

	var i : Int = 2
	while (i <= n) {
		dp[i] = dp[i - 2] + dp[i - 1]
		i += 1
	}
	
	return dp[n]
}

func fibonacciBU2(_ n : Int) -> Int {
	if (n < 2) {
		return n
	}

	var first : Int = 0
	var second : Int = 1
	var temp : Int = 0

	var i : Int = 2
	while (i <= n) {
		temp = first + second
		first = second
		second = temp
		i += 1
	}
	
	return temp
}

func fibonacciTD(_ n : Int) -> Int {
	var dp : [Int] = Array(repeating: 0, count: n + 1)
	return fibonacciTD(n, &dp)
}

func fibonacciTD(_ n : Int, _ dp : inout [Int]) -> Int {
	if (n < 2) {
		dp[n] = n
		return dp[n]
	}
	
	if (dp[n] != 0) {
		return dp[n]
	}

	dp[n] = fibonacciTD(n - 1, &dp) + fibonacciTD(n - 2, &dp)
	return dp[n]
}

// Testing code.
print(fibonacci(10))
print(fibonacciBU(10))
print(fibonacciBU2(10))
print(fibonacciTD(10))

/* 
55
55
55
55
 */
