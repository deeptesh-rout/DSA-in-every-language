function maxRobbery(house: number[]): number {
	const n = house.length;
	const dp: number[] = [];

	dp[0] = house[0];
	dp[1] = house[1];
	dp[2] = dp[0] + house[2];

	for (let i = 3; i < n; i++) {
		dp[i] = Math.max(dp[i - 2], dp[i - 3]) + house[i];
	}

	return Math.max(dp[n - 1], dp[n - 2]);
}

function maxRobbery2(house: number[]): number {
	const n = house.length;
	const dp: number[][] = [];

	dp[0] = [0, house[0]];

	for (let i = 1; i < n; i++) {
		dp[i] = [
			Math.max(dp[i - 1][0], dp[i - 1][1]),
			dp[i - 1][0] + house[i],
		];
	}

	return Math.max(dp[n - 1][0], dp[n - 1][1]);
}

const arr = [10, 12, 9, 23, 25, 55, 49, 70];
console.log("Total cash: " + maxRobbery(arr)); // Total cash: 160
console.log("Total cash: " + maxRobbery2(arr)); // Total cash: 160

/*
Total cash: 160
Total cash: 160
*/