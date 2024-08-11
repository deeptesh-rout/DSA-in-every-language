class Item {
  wt: number;
  cost: number;
  density: number;

  constructor(w: number, v: number) {
    this.wt = w;
    this.cost = v;
    this.density = this.cost / this.wt;
  }

  compareTo(s2: Item): number { // decreasing order.
    return s2.density - this.density;
  }
}

function getMaxCostFractional(wt: number[], cost: number[], capacity: number): number {
  let totalCost = 0;
  const n = wt.length;
  const itemList: Item[] = [];
  for (let i = 0; i < n; i++) {
    itemList.push(new Item(wt[i], cost[i]));
  }

  itemList.sort((a, b) => a.compareTo(b));
  for (let i = 0; i < n; i++) {
    if (capacity >= itemList[i].wt) {
      capacity -= itemList[i].wt;
      totalCost += itemList[i].cost;
    } else {
      totalCost += itemList[i].density * capacity;
      break;
    }
  }
  return totalCost;
}

// Testing code.
const wt = [10, 40, 20, 30];
const cost = [60, 40, 90, 120];
const capacity = 50;
const maxCost = getMaxCostFractional(wt, cost, capacity);
console.log("Maximum cost obtained =", maxCost);


/*
Maximum cost obtained = 230
*/
