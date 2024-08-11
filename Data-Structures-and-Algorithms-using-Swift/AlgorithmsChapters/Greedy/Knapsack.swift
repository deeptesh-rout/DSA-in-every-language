import Foundation

class Items : Comparable {
    var wt : Int
    var cost : Int
    var density : Double

    init(_ w : Int, _ v : Int) {
        self.wt = w
        self.cost = v
        self.density = Double(self.cost) / Double(self.wt)
    }

    static func < (lhs: Items, rhs: Items) -> Bool {
        return lhs.density < rhs.density
    }

    static func > (lhs: Items, rhs: Items) -> Bool {
        return lhs.density > rhs.density
    }

    static func == (lhs: Items, rhs: Items) -> Bool {
        return lhs.density == rhs.density
    }
}

// Approximate solution.
func knapsackMaxCostGreedy(_ wt : inout [Int], _ cost : inout [Int], _ cap : Int) -> Int {
    var totalCost : Int = 0
    let n : Int = wt.count
    var capacity = cap
    
    var itemList : [Items] = []
    var i : Int = 0
    while (i < n) {
        itemList.append(Items(wt[i], cost[i]))
        i += 1
    }
    
    itemList.sort( by: >)// Decreasing order.

    i = 0
    while (i < n && capacity > 0) {
        if (capacity - itemList[i].wt >= 0) {
            capacity -= itemList[i].wt
            totalCost += itemList[i].cost
        }
        i += 1
    }
    return totalCost
}

// Testing code.
var wt : [Int] = [10, 40, 20, 30]
var cost : [Int] = [60, 40, 90, 120]
let capacity : Int = 50
let maxCost : Int = knapsackMaxCostGreedy( &wt, &cost,capacity)
print("Maximum cost obtained = " + String(maxCost))

/*
Maximum cost obtained = 150
*/