import Foundation

class Items {
    var wt : Int
    var cost : Int
    var density : Double

    init(_ w : Int, _ v : Int) {
        self.wt = w
        self.cost = v
        self.density = Double(self.cost) / Double(self.wt)
    }
}

func compareItems(_ s1 : Items?, _ s2 : Items?) -> Bool { // decreasing order.
    return (s1!.density > s2!.density)
}

func getMaxCostFractional(_ wt : inout [Int], _ cost : inout [Int], _ capacityIn : Int) -> Double {
    var totalCost : Double = 0
    let n : Int = wt.count
    var capacity : Int = capacityIn
    var itemList : [Items?] = Array(repeating: nil, count: n)
    var i : Int = 0
    while (i < n) {
        itemList[i] = Items(wt[i], cost[i])
        i += 1
    }
    itemList = itemList.sorted(by: compareItems)
    
    i = 0
    while (i < n) {
        if (capacity - itemList[i]!.wt >= 0) {
            capacity -= itemList[i]!.wt
            totalCost += Double(itemList[i]!.cost)
        } else {
            totalCost += itemList[i]!.density * Double(capacity)
            break
        }
        i += 1
    }
    return totalCost
}

// Testing code.
var wt : [Int] = [10, 40, 20, 30]
var cost : [Int] = [60, 40, 90, 120]
let capacity : Int = 50
let maxCost : Double = getMaxCostFractional( &wt, &cost,capacity)
print("Maximum cost obtained = " + String(maxCost))

/*
Maximum cost obtained = 230.0
*/