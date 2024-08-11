function gridUniqueWays(m: number, n: number): number {
	const dp: number[][] = [];
	for (let i = 0; i < m; i++) {
		dp[i] = [];
		for (let j = 0; j < n; j++) {
			dp[i][j] = 0;
		}
	}

	dp[0][0] = 1;

	// Initialize first column.
	for (let i = 1; i < m; i++) {
		dp[i][0] = dp[i - 1][0];
	}

	// Initialize first row.
	for (let j = 1; j < n; j++) {
		dp[0][j] = dp[0][j - 1];
	}

	for (let i = 1; i < m; i++) {
		for (let j = 1; j < n; j++) {
			dp[i][j] = dp[i - 1][j] + dp[i][j - 1];
		}
	}

	return dp[m - 1][n - 1];
}

function gridUnique3Ways(m: number, n: number): number {
	const dp: number[][] = [];
	for (let i = 0; i < m; i++) {
		dp[i] = [];
		for (let j = 0; j < n; j++) {
			dp[i][j] = 0;
		}
	}

	dp[0][0] = 1;

	// Initialize first column.
	for (let i = 1; i < m; i++) {
		dp[i][0] = dp[i - 1][0];
	}

	// Initialize first row.
	for (let j = 1; j < n; j++) {
		dp[0][j] = dp[0][j - 1];
	}

	for (let i = 1; i < m; i++) {
		for (let j = 1; j < n; j++) {
			dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j] + dp[i][j - 1];
		}
	}

	return dp[m - 1][n - 1];
}

console.log(gridUniqueWays(3, 3)); // 6
console.log(gridUnique3Ways(3, 3)); // 13

/*
 * 6
 * 13
 */