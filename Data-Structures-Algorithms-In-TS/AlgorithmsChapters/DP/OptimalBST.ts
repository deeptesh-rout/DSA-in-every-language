function optBstCost(freq: number[], i: number, j: number): number {
	if (i > j) return 0;

	if (j === i) return freq[i];

	let min = Infinity;
	for (let r = i; r <= j; r++) {
		min = Math.min(
			min,
			optBstCost(freq, i, r - 1) + optBstCost(freq, r + 1, j)
		);
	}
	return min + sum(freq, i, j);
}

function optBstCostRecursive(keys: number[], freq: number[]): number {
	const n = freq.length;
	return optBstCost(freq, 0, n - 1);
}

function optBstCostTopDown(keys: number[], freq: number[]): number {
	const n = freq.length;
	const cost: number[][] = new Array(n).fill(0).map(() => new Array(n).fill(Infinity));
	for (let i = 0; i < n; i++) {
		cost[i][i] = freq[i];
	}
	return optBstCostTD(freq, cost, 0, n - 1);
}

function optBstCostTD(freq: number[], cost: number[][], i: number, j: number): number {
	if (i > j) return 0;

	if (cost[i][j] !== Infinity) return cost[i][j];

	const s = sum(freq, i, j);
	for (let r = i; r <= j; r++) {
		cost[i][j] = Math.min(
			cost[i][j],
			optBstCostTD(freq, cost, i, r - 1) + optBstCostTD(freq, cost, r + 1, j) + s
		);
	}
	return cost[i][j];
}

function sum(freq: number[], i: number, j: number): number {
	let s = 0;
	for (let k = i; k <= j; k++) {
		s += freq[k];
	}
	return s;
}

function sumInit(freq: number[], n: number): number[] {
	const sum: number[] = new Array(n).fill(0);
	sum[0] = freq[0];
	for (let i = 1; i < n; i++) {
		sum[i] = sum[i - 1] + freq[i];
	}
	return sum;
}

function sumRange(sum: number[], i: number, j: number): number {
	if (i === 0) return sum[j];
	return sum[j] - sum[i - 1];
}

function optBstCostBU(keys: number[], freq: number[]): number {
	const n = freq.length;
	const cost: number[][] = new Array(n).fill(0).map(() => new Array(n).fill(Infinity));

	for (let i = 0; i < n; i++) {
		cost[i][i] = freq[i];
	}

	let sm = 0;
	for (let l = 1; l < n; l++) {
		for (let i = 0, j = i + l; j < n; i++, j++) {
			sm = sum(freq, i, j);
			for (let r = i; r <= j; r++) {
				cost[i][j] = Math.min(
					cost[i][j],
					sm +
					((r - 1 >= i) ? cost[i][r - 1] : 0) +
					((r + 1 <= j) ? cost[r + 1][j] : 0)
				);
			}
		}
	}
	return cost[0][n - 1];
}

function optBstCostBU2(keys: number[], freq: number[]): number {
	const n = freq.length;
	const cost: number[][] = new Array(n).fill(0).map(() => new Array(n).fill(Infinity));

	const sumArr = sumInit(freq, n);
	for (let i = 0; i < n; i++) {
		cost[i][i] = freq[i];
	}

	let sm = 0;
	for (let l = 1; l < n; l++) {
		for (let i = 0, j = i + l; j < n; i++, j++) {
			sm = sumRange(sumArr, i, j);
			for (let r = i; r <= j; r++) {
				cost[i][j] = Math.min(
					cost[i][j],
					sm +
					((r - 1 >= i) ? cost[i][r - 1] : 0) +
					((r + 1 <= j) ? cost[r + 1][j] : 0)
				);
			}
		}
	}
	return cost[0][n - 1];
}

// Testing code.
const keys: number[] = [9, 15, 25];
const freq: number[] = [30, 10, 40];
console.log("OBST cost: " + optBstCostRecursive(keys, freq));
console.log("OBST cost: " + optBstCostTopDown(keys, freq));
console.log("OBST cost: " + optBstCostBU(keys, freq));
console.log("OBST cost: " + optBstCostBU2(keys, freq));

/*
OBST cost: 130
OBST cost: 130
OBST cost: 130
OBST cost: 130
*/
