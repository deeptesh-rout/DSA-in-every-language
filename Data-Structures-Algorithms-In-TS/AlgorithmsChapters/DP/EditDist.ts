function editDist(str1: string, str2: string): number {
	const m = str1.length;
	const n = str2.length;
	return editDistRecursive(str1, str2, m, n);
}

function editDistRecursive(str1: string, str2: string, m: number, n: number): number {
	if (m === 0 || n === 0) {
		// If any one string is empty, then empty the other string.
		return m + n;
	}

	// If last characters of both strings are the same, ignore the last characters.
	if (str1[m - 1] === str2[n - 1]) {
		return editDistRecursive(str1, str2, m - 1, n - 1);
	}

	// If last characters are not the same, consider all three operations:
	// (1) Insert last char of the second string into the first.
	// (2) Remove last char of the first string.
	// (3) Replace last char of the first string with the second.
	return 1 + Math.min(
		editDistRecursive(str1, str2, m, n - 1), // Insert
		editDistRecursive(str1, str2, m - 1, n), // Remove
		editDistRecursive(str1, str2, m - 1, n - 1) // Replace
	);
}

function editDistDP(str1: string, str2: string): number {
	const m = str1.length;
	const n = str2.length;
	const dp: number[][] = new Array(m + 1).fill(0).map(() => new Array(n + 1).fill(0));

	// Fill dp[][] in bottom-up manner.
	for (let i = 0; i <= m; i++) {
		for (let j = 0; j <= n; j++) {
			if (i === 0 || j === 0) {
				// If any one string is empty, then empty the other string.
				dp[i][j] = i + j;
			} else if (str1[i - 1] === str2[j - 1]) {
				// If last characters of both strings are the same, ignore the last characters.
				dp[i][j] = dp[i - 1][j - 1];
			} else {
				// If last characters are not the same, consider all three operations:
				// (1) Insert last char of the second string into the first.
				// (2) Remove last char of the first string.
				// (3) Replace last char of the first string with the second.
				dp[i][j] = 1 + Math.min(dp[i][j - 1], dp[i - 1][j], dp[i - 1][j - 1]);
			}
		}
	}
	return dp[m][n];
}

const str1 = "sunday";
const str2 = "saturday";
console.log(editDist(str1, str2));
console.log(editDistDP(str1, str2));
/*
3
3
*/
