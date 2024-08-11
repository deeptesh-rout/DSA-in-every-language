function minCostTravel(days: number[], costs: number[]): number {
	const n = days.length;
	const max = days[n - 1];
	const dp: number[] = new Array(max + 1).fill(Infinity);

	let j = 0;
	dp[0] = 0; // Initialize the cost for day 0 as 0

	for (let i = 1; i <= max; i++) {
		if (days[j] === i) {
			j++;
			dp[i] = dp[i - 1] + costs[0];
			dp[i] = Math.min(dp[i], dp[Math.max(0, i - 7)] + costs[1]);
			dp[i] = Math.min(dp[i], dp[Math.max(0, i - 30)] + costs[2]);
		} else {
			dp[i] = dp[i - 1];
		}
	}

	return dp[max];
}

const days = [1, 3, 5, 7, 12, 20, 30];
const costs = [2, 7, 20];
console.log("Min cost is: " + minCostTravel(days, costs));

/*
 * Min cost is: 13
 */
