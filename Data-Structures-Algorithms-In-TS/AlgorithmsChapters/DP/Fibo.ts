function fibonacci(n: number): number {
	if (n < 2) {
		return n;
	}
	return fibonacci(n - 1) + fibonacci(n - 2);
}

function fibonacciBU(n: number): number {
	if (n < 2) {
		return n;
	}

	const dp: number[] = new Array(n + 1);
	dp[0] = 0;
	dp[1] = 1;

	for (let i = 2; i <= n; i++) {
		dp[i] = dp[i - 2] + dp[i - 1];
	}

	return dp[n];
}

function fibonacciBU2(n: number): number {
	if (n < 2) {
		return n;
	}

	let first = 0;
	let second = 1;
	let temp = 0;

	for (let i = 2; i <= n; i++) {
		temp = first + second;
		first = second;
		second = temp;
	}

	return temp;
}

function fibonacciTD(n: number): number {
	const dp: number[] = new Array(n + 1);
	return fibonacciTDRecursive(n, dp);
}

function fibonacciTDRecursive(n: number, dp: number[]): number {
	if (n < 2) {
		return (dp[n] = n);
	}

	if (dp[n] !== undefined) {
		return dp[n];
	}

	dp[n] = fibonacciTDRecursive(n - 1, dp) + fibonacciTDRecursive(n - 2, dp);
	return dp[n];
}

console.log(fibonacci(10));
console.log(fibonacciBU(10));
console.log(fibonacciBU2(10));
console.log(fibonacciTD(10));
/*
55
55
55
55
*/
