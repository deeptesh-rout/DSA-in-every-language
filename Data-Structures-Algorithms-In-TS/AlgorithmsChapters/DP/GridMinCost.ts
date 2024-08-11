function min(x: number, y: number, z: number): number {
	x = Math.min(x, y);
	return Math.min(x, z);
}

function minCost(cost: number[][], m: number, n: number): number {
	if (m === 0 || n === 0) {
		return 99999;
	}

	if (m === 1 && n === 1) {
		return cost[0][0];
	}

	return (
		cost[m - 1][n - 1] +
		min(
			minCost(cost, m - 1, n - 1),
			minCost(cost, m - 1, n),
			minCost(cost, m, n - 1)
		)
	);
}

function minCostBU(cost: number[][], m: number, n: number): number {
	const tc: number[][] = [];
	for (let i = 0; i < m; i++) {
		tc[i] = [];
		for (let j = 0; j < n; j++) {
			tc[i][j] = 0;
		}
	}

	tc[0][0] = cost[0][0];

	// Initialize first column.
	for (let i = 1; i < m; i++) {
		tc[i][0] = tc[i - 1][0] + cost[i][0];
	}

	// Initialize first row.
	for (let j = 1; j < n; j++) {
		tc[0][j] = tc[0][j - 1] + cost[0][j];
	}

	for (let i = 1; i < m; i++) {
		for (let j = 1; j < n; j++) {
			tc[i][j] = cost[i][j] + min(tc[i - 1][j - 1], tc[i - 1][j], tc[i][j - 1]);
		}
	}

	return tc[m - 1][n - 1];
}

const cost: number[][] = [
	[1, 3, 4],
	[4, 7, 5],
	[1, 5, 3],
];

console.log(minCost(cost, 3, 3)); // 11
console.log(minCostBU(cost, 3, 3)); // 11

/*
11
11
*/