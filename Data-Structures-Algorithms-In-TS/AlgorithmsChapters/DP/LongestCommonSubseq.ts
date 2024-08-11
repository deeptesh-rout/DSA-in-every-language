function LCSubStr(st1: string, st2: string): number {
	const X: string[] = st1.split("");
	const Y: string[] = st2.split("");
	const m: number = st1.length;
	const n: number = st2.length;
	const dp: number[][] = new Array(m + 1);
	const p: number[][] = new Array(m + 1);

	for (let i = 0; i <= m; i++) {
		dp[i] = new Array(n + 1).fill(0);
		p[i] = new Array(n + 1).fill(0);
	}

	for (let i = 1; i <= m; i++) {
		for (let j = 1; j <= n; j++) {
			if (X[i - 1] === Y[j - 1]) {
				dp[i][j] = dp[i - 1][j - 1] + 1;
				p[i][j] = 0;
			} else {
				dp[i][j] = dp[i - 1][j] > dp[i][j - 1] ? dp[i - 1][j] : dp[i][j - 1];
				p[i][j] = dp[i - 1][j] > dp[i][j - 1] ? 1 : 2;
			}
		}
	}

	console.log(PrintLCS(p, X, m, n));
	return dp[m][n];
}

function PrintLCS(p: number[][], X: string[], i: number, j: number): string {
	if (i === 0 || j === 0) return "";
	if (p[i][j] === 0) {
		return PrintLCS(p, X, i - 1, j - 1) + X[i - 1];
	} else if (p[i][j] === 1) {
		return PrintLCS(p, X, i - 1, j);
	} else {
		return PrintLCS(p, X, i, j - 1);
	}
}

const X = "carpenter";
const Y = "sharpener";
console.log(LCSubStr(X, Y));

// arpener
// 7
