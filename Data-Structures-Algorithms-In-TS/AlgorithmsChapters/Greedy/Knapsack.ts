class Item {
	wt: number;
	cost: number;
	density: number;

	constructor(w: number, v: number) {
		this.wt = w;
		this.cost = v;
		this.density = v / w;
	}
}

function knapsack01Greedy(wt: number[], cost: number[], capacity: number): number {
	let totalCost = 0;
	const n = wt.length;
	const itemList: Item[] = [];

	for (let i = 0; i < n; i++) {
		itemList.push(new Item(wt[i], cost[i]));
	}

	itemList.sort((a, b) => b.density - a.density);

	for (let i = 0; i < n && capacity > 0; i++) {
		if (capacity - itemList[i].wt >= 0) {
			capacity -= itemList[i].wt;
			totalCost += itemList[i].cost;
		}
	}

	return totalCost;
}

/* Testing code */
const wt: number[] = [10, 40, 20, 30];
const cost: number[] = [60, 40, 90, 120];
const capacity: number = 50;
const maxCost: number = knapsack01Greedy(wt, cost, capacity);
console.log("Maximum cost obtained:", maxCost);

/*
Maximum cost obtained: 150
*/
