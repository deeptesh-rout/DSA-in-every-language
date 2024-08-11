import Foundation

func countSort(_ arr : inout [Int], _ lowerRange : Int, _ upperRange : Int) {
    var j : Int
    let size : Int = arr.count
    let range : Int = upperRange - lowerRange
    var count : [Int] = Array(repeating: 0, count: range)
    var i : Int = 0
    while (i < size) {
        count[arr[i] - lowerRange] += 1
        i += 1
    }
    
    j = 0
    i = 0
    while (i < range) {
        while (count[i] > 0) {
            arr[j] = i + lowerRange
            j += 1
            count[i] -= 1
        }
        i += 1
    }
}

// Testing Code.
var array : [Int] = [23, 24, 22, 21, 26, 25, 27, 28, 21, 21]
countSort( &array,20,30)
print(array)

// [21, 21, 21, 22, 23, 24, 25, 26, 27, 28]
