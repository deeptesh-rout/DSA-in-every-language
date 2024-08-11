function minCoins(coins: number[], n: number, val: number): number {
	if (val <= 0) return 0;

	let count = 0;
	coins.sort((a, b) => a - b);

	for (let i = n - 1; i >= 0 && val > 0;) {
		if (coins[i] <= val) {
			count++;
			val -= coins[i];
		} else {
			i--;
		}
	}
	return val === 0 ? count : -1;
}

function minCoins2(coins: number[], n: number, val: number): number {
	if (val === 0) return 0;

	let count = Infinity;
	for (let i = 0; i < n; i++) {
		if (coins[i] <= val) {
			const subCount = minCoins2(coins, n, val - coins[i]);
			if (subCount >= 0) count = Math.min(count, subCount + 1);
		}
	}
	return count !== Infinity ? count : -1;
}

function minCoinsTD(coins: number[], n: number, val: number): number {
	const count: number[] = new Array(val + 1).fill(Infinity);
	count[0] = 0;
	return minCoinsTDUtil(count, coins, n, val);
}

function minCoinsTDUtil(count: number[], coins: number[], n: number, val: number): number {
	if (count[val] !== Infinity) {
		return count[val];
	}

	for (let i = 0; i < n; i++) {
		if (coins[i] <= val) {
			const subCount = minCoinsTDUtil(count, coins, n, val - coins[i]);
			if (subCount !== Infinity && count[val] > subCount + 1) {
				count[val] = subCount + 1;
			}
		}
	}
	return count[val];
}

function minCoinsBU(coins: number[], n: number, val: number): number {
	const count: number[] = new Array(val + 1).fill(Infinity);
	count[0] = 0;

	for (let i = 1; i <= val; i++) {
		for (let j = 0; j < n; j++) {
			if (coins[j] <= i && count[i - coins[j]] !== Infinity && count[i] > count[i - coins[j]] + 1) {
				count[i] = count[i - coins[j]] + 1;
			}
		}
	}
	return count[val] !== Infinity ? count[val] : -1;
}

function printCoinsUtil(cvalue: number[], val: number): string {
	var str = "";
	if (val > 0) {
		str = printCoinsUtil(cvalue, val - cvalue[val]);
		str += `${cvalue[val]} `;
	}
	return str;
}

function printCoins(cvalue: number[], val: number): void {
	var str = "Coins are: ";
	str += printCoinsUtil(cvalue, val);
	console.log(str);
}

function minCoinsBU2(coins: number[], n: number, val: number): number {
	const count: number[] = new Array(val + 1).fill(Infinity);
	const cvalue: number[] = new Array(val + 1).fill(Infinity);

	count[0] = 0;

	for (let i = 1; i <= val; i++) {
		for (let j = 0; j < n; j++) {
			if (coins[j] <= i && count[i - coins[j]] !== Infinity && count[i] > count[i - coins[j]] + 1) {
				count[i] = count[i - coins[j]] + 1;
				cvalue[i] = coins[j];
			}
		}
	}

	if (count[val] === Infinity) return -1;

	printCoins(cvalue, val);
	return count[val];
}

// Test example
const coins: number[] = [1, 2, 5, 10];
const value: number = 16;
const n: number = coins.length;

console.log("Count is:", minCoins(coins, n, value));
console.log("Count is:", minCoins2(coins, n, value));
console.log("Count is:", minCoinsTD(coins, n, value));
console.log("Count is:", minCoinsBU(coins, n, value));
console.log("Count is:", minCoinsBU2(coins, n, value));

/*
Count is: 3
Count is: 3
Count is: 3
Count is: 3
Coins are: 10 5 1 
Count is: 3
*/