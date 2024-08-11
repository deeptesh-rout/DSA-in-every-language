function largestPalindromicSubseq(str: string): number {
	const n = str.length;
	const dp: number[][] = new Array(n);

	for (let i = 0; i < n; i++) {
		dp[i] = new Array(n).fill(0);
		dp[i][i] = 1; // each char is itself palindromic with length 1
	}

	for (let l = 1; l < n; l++) {
		for (let i = 0, j = l; j < n; i++, j++) {
			if (str.charAt(i) === str.charAt(j))
				dp[i][j] = dp[i + 1][j - 1] + 2;
			else
				dp[i][j] = Math.max(dp[i + 1][j], dp[i][j - 1]);
		}
	}
	return dp[0][n - 1];
}

const str = "ABCAUCBCxxCBA";
console.log("Largest Palindromic Subseq: " + largestPalindromicSubseq(str));

/*
Largest Palindromic Subseq: 9 
*/
