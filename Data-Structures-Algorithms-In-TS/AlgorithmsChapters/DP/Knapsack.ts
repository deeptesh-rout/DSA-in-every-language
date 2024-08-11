function maxCost01Knapsack(wt: number[], cost: number[], capacity: number): number {
	const n = wt.length;
	return maxCost01KnapsackUtil(wt, cost, n, capacity);
}

function maxCost01KnapsackUtil(wt: number[], cost: number[], n: number, capacity: number): number {
	// Base Case
	if (n === 0 || capacity === 0)
		return 0;

	// Return the maximum of two cases:
	// (1) nth item is included
	// (2) nth item is not included
	let first = 0;
	if (wt[n - 1] <= capacity)
		first = cost[n - 1] + maxCost01KnapsackUtil(wt, cost, n - 1, capacity - wt[n - 1]);

	const second = maxCost01KnapsackUtil(wt, cost, n - 1, capacity);
	return Math.max(first, second);
}

function maxCost01KnapsackTD(wt: number[], cost: number[], capacity: number): number {
	const n = wt.length;
	const dp: number[][] = new Array(capacity + 1).fill(null).map(() => new Array(n + 1).fill(0));
	return maxCost01KnapsackTDUtil(dp, wt, cost, n, capacity);
}

function maxCost01KnapsackTDUtil(dp: number[][], wt: number[], cost: number[], i: number, w: number): number {
	if (i === 0 || w === 0)
		return 0;

	if (dp[w][i] !== 0)
		return dp[w][i];

	// There are two cases:
	// (1) ith item is included
	// (2) ith item is not included
	let first = 0;
	if (wt[i - 1] <= w)
		first = maxCost01KnapsackTDUtil(dp, wt, cost, i - 1, w - wt[i - 1]) + cost[i - 1];

	const second = maxCost01KnapsackTDUtil(dp, wt, cost, i - 1, w);
	return dp[w][i] = Math.max(first, second);
}

function maxCost01KnapsackBU(wt: number[], cost: number[], capacity: number): number {
	const n = wt.length;
	const dp: number[][] = new Array(capacity + 1).fill(null).map(() => new Array(n + 1).fill(0));

	// Build table dp[][] in bottom-up approach.
	// Weights considered against capacity.
	for (let w = 1; w <= capacity; w++) {
		for (let i = 1; i <= n; i++) {
			// There are two cases:
			// (1) ith item is included
			// (2) ith item is not included
			let first = 0;
			if (wt[i - 1] <= w)
				first = dp[w - wt[i - 1]][i - 1] + cost[i - 1];

			const second = dp[w][i - 1];
			dp[w][i] = Math.max(first, second);
		}
	}
	printItems(dp, wt, cost, n, capacity);
	return dp[capacity][n]; // Number of weights considered and final capacity.
}

function printItems(dp: number[][], wt: number[], cost: number[], n: number, capacity: number): void {
	let totalCost = dp[capacity][n];
	let str = "Selected items are: ";
	for (let i = n - 1; i > 0; i--) {
		if (totalCost !== dp[capacity][i - 1]) {
			str += `(wt:${wt[i]}, cost:${cost[i]}) `;
			capacity -= wt[i];
			totalCost -= cost[i];
		}
	}
	console.log(str);
}

function KS01UnboundBU(wt: number[], cost: number[], capacity: number): number {
	const n = wt.length;
	const dp: number[] = new Array(capacity + 1).fill(0);

	// Build table dp[] in bottom-up approach.
	// Weights considered against capacity.
	for (let w = 1; w <= capacity; w++) {
		for (let i = 1; i <= n; i++) {
			// There are two cases:
			// (1) ith item is included
			// (2) ith item is not included
			if (wt[i - 1] <= w)
				dp[w] = Math.max(dp[w], dp[w - wt[i - 1]] + cost[i - 1]);
		}
	}
	// printItems(dp, wt, cost, n, capacity);
	return dp[capacity]; // Number of weights considered and final capacity.
}

const wt = [10, 40, 20, 30];
const cost = [60, 40, 90, 120];
const capacity = 50;

let maxCost = KS01UnboundBU(wt, cost, capacity);
console.log("Maximum cost obtained =", maxCost);
maxCost = maxCost01Knapsack(wt, cost, capacity);
console.log("Maximum cost obtained =", maxCost);
maxCost = maxCost01KnapsackBU(wt, cost, capacity);
console.log("Maximum cost obtained =", maxCost);
maxCost = maxCost01KnapsackTD(wt, cost, capacity);
console.log("Maximum cost obtained =", maxCost);


/*
Maximum cost obtained = 300
Maximum cost obtained = 210
Selected items are: (wt:30, cost:120) (wt:20, cost:90) 
Maximum cost obtained = 210
Maximum cost obtained = 210
*/
