function fastestWayBU2(a: number[][], t: number[][], e: number[], x: number[], n: number): number {
	const f1: number[] = new Array(n);
	const f2: number[] = new Array(n);

	// Time taken to leave first station.
	f1[0] = e[0] + a[0][0];
	f2[0] = e[1] + a[1][0];

	// Fill the tables f1[] and f2[] using bottom-up approach.
	for (let i = 1; i < n; ++i) {
		f1[i] = Math.min(f1[i - 1] + a[0][i], f2[i - 1] + t[1][i - 1] + a[0][i]);
		f2[i] = Math.min(f2[i - 1] + a[1][i], f1[i - 1] + t[0][i - 1] + a[1][i]);
	}

	// Consider exit times and return the minimum.
	return Math.min(f1[n - 1] + x[0], f2[n - 1] + x[1]);
}

function fastestWayBU(a: number[][], t: number[][], e: number[], x: number[], n: number): number {
	const f: number[][] = new Array(2);
	for (let i = 0; i < 2; i++) {
		f[i] = new Array(n);
	}

	// Time taken to leave first station.
	f[0][0] = e[0] + a[0][0];
	f[1][0] = e[1] + a[1][0];

	// Fill the tables f1[] and f2[] using bottom-up approach.
	for (let i = 1; i < n; ++i) {
		f[0][i] = Math.min(f[0][i - 1] + a[0][i], f[1][i - 1] + t[1][i - 1] + a[0][i]);
		f[1][i] = Math.min(f[1][i - 1] + a[1][i], f[0][i - 1] + t[0][i - 1] + a[1][i]);
	}

	// Consider exit times and return the minimum.
	return Math.min(f[0][n - 1] + x[0], f[1][n - 1] + x[1]);
}

function fastestWayTD(a: number[][], t: number[][], e: number[], x: number[], n: number): number {
	const f: number[][] = new Array(2);
	for (let i = 0; i < 2; i++) {
		f[i] = new Array(n);
	}

	// Time taken to leave first station.
	f[0][0] = e[0] + a[0][0];
	f[1][0] = e[1] + a[1][0];

	fastestWayTDHelper(f, a, t, n - 1);
	return Math.min(f[0][n - 1] + x[0], f[1][n - 1] + x[1]);
}

function fastestWayTDHelper(f: number[][], a: number[][], t: number[][], i: number): void {
	if (i === 0) {
		return;
	}
	fastestWayTDHelper(f, a, t, i - 1);
	// Fill the tables f1[] and f2[] using top-down approach.
	f[0][i] = Math.min(f[0][i - 1] + a[0][i], f[1][i - 1] + t[1][i - 1] + a[0][i]);
	f[1][i] = Math.min(f[1][i - 1] + a[1][i], f[0][i - 1] + t[0][i - 1] + a[1][i]);
}

// Driver code
const a: number[][] = [[7, 9, 3, 4, 8, 4], [8, 5, 6, 4, 5, 7]];
const t: number[][] = [[2, 3, 1, 3, 4], [2, 1, 2, 2, 1]];
const e: number[] = [2, 4];
const x: number[] = [3, 2];
const n: number = 6;
console.log("Fastest way:", fastestWayBU2(a, t, e, x, n));
console.log("Fastest way:", fastestWayBU(a, t, e, x, n));
console.log("Fastest way:", fastestWayTD(a, t, e, x, n));


/*
Fastest way: 38
Fastest way: 38
Fastest way: 38
*/