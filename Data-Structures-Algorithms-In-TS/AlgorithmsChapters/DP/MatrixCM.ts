function MatrixChainMulBruteForceUtil(p: number[], i: number, j: number): number {
	if (i === j) return 0;

	let min = Infinity;

	for (let k = i; k < j; k++) {
		const count =
			MatrixChainMulBruteForceUtil(p, i, k) +
			MatrixChainMulBruteForceUtil(p, k + 1, j) +
			p[i - 1] * p[k] * p[j];

		if (count < min) min = count;
	}

	return min;
}

function MatrixChainMulBruteForce(p: number[]): number {
	const i = 1;
	const j = p.length - 1;
	return MatrixChainMulBruteForceUtil(p, i, j);
}

function MatrixChainMulTD(p: number[], n: number): number {
	const dp: number[][] = new Array(n).fill(0).map(() => new Array(n).fill(Infinity));
	for (let i = 1; i < n; i++) dp[i][i] = 0;
	return MatrixChainMulTDUtil(dp, p, 1, n - 1);
}

function MatrixChainMulTDUtil(dp: number[][], p: number[], i: number, j: number): number {
	if (dp[i][j] !== Infinity) return dp[i][j];

	for (let k = i; k < j; k++) {
		dp[i][j] = Math.min(
			dp[i][j],
			MatrixChainMulTDUtil(dp, p, i, k) +
			MatrixChainMulTDUtil(dp, p, k + 1, j) +
			p[i - 1] * p[k] * p[j]
		);
	}

	return dp[i][j];
}

function MatrixChainMulBU(p: number[], n: number): number {
	const dp: number[][] = new Array(n).fill(0).map(() => new Array(n).fill(Infinity));

	for (let i = 1; i < n; i++) dp[i][i] = 0;

	for (let l = 1; l < n; l++) {
		for (let i = 1, j = i + l; j < n; i++, j++) {
			for (let k = i; k < j; k++) {
				dp[i][j] = Math.min(
					dp[i][j],
					dp[i][k] + p[i - 1] * p[k] * p[j] + dp[k + 1][j]
				);
			}
		}
	}

	return dp[1][n - 1];
}

function PrintOptimalParenthesis(n: number, pos: number[][]): void {
	const str = PrintOptPar(pos, 1, n - 1);
	console.log("OptimalParenthesis: " + str);
}

function PrintOptPar(pos: number[][], i: number, j: number): string {
	if (i === j) {
		return `M${i}`;
	}

	return ("(" +
		PrintOptPar(pos, i, pos[i][j]) +
		" " +
		PrintOptPar(pos, pos[i][j] + 1, j) +
		")");
}

function MatrixChainMulBU2(p: number[], n: number): number {
	const dp: number[][] = new Array(n).fill(0).map(() => new Array(n).fill(Infinity));
	const pos: number[][] = new Array(n).fill(0).map(() => new Array(n).fill(0));

	for (let i = 1; i < n; i++) {
		dp[i][i] = 0;
	}

	for (let l = 1; l < n; l++) {
		for (let i = 1, j = i + l; j < n; i++, j++) {
			for (let k = i; k < j; k++) {
				dp[i][j] = Math.min(
					dp[i][j],
					dp[i][k] + p[i - 1] * p[k] * p[j] + dp[k + 1][j]
				);
				pos[i][j] = k;
			}
		}
	}

	PrintOptimalParenthesis(n, pos);
	return dp[1][n - 1];
}

const arr: number[] = [1, 2, 3, 4];
const n: number = arr.length;
console.log("Matrix Chain Multiplication is: " + MatrixChainMulBruteForce(arr));
console.log("Matrix Chain Multiplication is: " + MatrixChainMulTD(arr, n));
console.log("Matrix Chain Multiplication is: " + MatrixChainMulBU(arr, n));
console.log("Matrix Chain Multiplication is: " + MatrixChainMulBU2(arr, n));

/*
Matrix Chain Multiplication is: 18
Matrix Chain Multiplication is: 18
Matrix Chain Multiplication is: 18
OptimalParenthesis: ((M1 M2) M3)
Matrix Chain Multiplication is: 18
*/
