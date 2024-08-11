function largestPalinSubstr(str: string): number {
	const n = str.length;
	const dp: number[][] = new Array(n);

	for (let i = 0; i < n; i++) {
		dp[i] = new Array(n).fill(0);
		dp[i][i] = 1;
	}

	let max = 1;
	let start = 0;
	for (let l = 1; l < n; l++) {
		for (let i = 0, j = i + l; j < n; i++, j++) {
			if (str.charAt(i) === str.charAt(j) && dp[i + 1][j - 1] === j - i - 1) {
				dp[i][j] = dp[i + 1][j - 1] + 2;
				if (dp[i][j] > max) {
					max = dp[i][j];
					start = i;
				}
			} else {
				dp[i][j] = 0;
			}
		}
	}
	console.log("Max Length Palindromic Substrings:", str.substring(start, start + max));
	return max;
}

const str = "ABCAUCBCxxCBA";
console.log("Max Palindromic Substrings len:", largestPalinSubstr(str));


/*
Max Length Palindromic Substrings: BCxxCB
Max Palindromic Substrings len: 6
*/

/*
 * If asked to find how many different palindromic substrings are possible.
 * 
 * int count = 0; 
 * for(int i=0;i<n;i++) 
 * 	for(int j=0;j<n;j++) 
 * 		if(dp[i][j] > 0)
 * 			count++; return count;
 */
