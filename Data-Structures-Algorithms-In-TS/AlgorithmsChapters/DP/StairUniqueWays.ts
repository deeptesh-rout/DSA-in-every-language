function stairUniqueWaysBU(n: number): number {
	if (n <= 2) return n;
	let first = 1,
		second = 2,
		temp = 0;

	for (let i = 3; i <= n; i++) {
		temp = first + second;
		first = second;
		second = temp;
	}
	return temp;
}

function stairUniqueWaysBU2(n: number): number {
	if (n < 2) return n;

	const ways: number[] = new Array(n);
	ways[0] = 1;
	ways[1] = 2;

	for (let i = 2; i < n; i++) {
		ways[i] = ways[i - 1] + ways[i - 2];
	}

	return ways[n - 1];
}

console.log("Unique ways to reach the top: " + stairUniqueWaysBU(4));
console.log("Unique ways to reach the top: " + stairUniqueWaysBU2(4));

/*
Unique ways to reach the top: 5
Unique ways to reach the top: 5
*/
