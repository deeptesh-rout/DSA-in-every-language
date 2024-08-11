function minStairCost(cost: number[], n: number): number {
	// base case
	if (n === 1) return cost[0];

	const dp: number[] = new Array(n);
	dp[0] = cost[0];
	dp[1] = cost[1];

	for (let i = 2; i < n; i++) {
		dp[i] = Math.min(dp[i - 1], dp[i - 2]) + cost[i];
	}

	return Math.min(dp[n - 1], dp[n - 2]);
}

const a: number[] = [1, 5, 6, 3, 4, 7, 9, 1, 2, 11];
const n: number = a.length;
console.log("minStairCost: " + minStairCost(a, n));

/*
minStairCost: 18
*/
