import Foundation

func less(_ value1 : Int, _ value2 : Int) -> Bool {
    return value1 < value2
}

func greater(_ value1 : Int, _ value2 : Int) -> Bool {
    return value1 > value2
}

func bubbleSort(_ arr : inout [Int]) {
    let size : Int = arr.count
    var i : Int = 0
    while (i < (size - 1)) {
        var j : Int = 0
        while (j < size - i - 1) {
            if greater(arr[j],arr[j + 1]) {
                arr.swapAt(j, j+1) 
            }
            j += 1
        }
        i += 1
    }
}

func bubbleSort2(_ arr : inout [Int]) {
    let size : Int = arr.count
    var swapped : Int = 1
    var i : Int = 0
    while (i < (size - 1) && swapped == 1) {
        swapped = 0
        var j : Int = 0
        while (j < size - i - 1) {
            if greater(arr[j],arr[j + 1]) {
                arr.swapAt(j, j+1)
                swapped = 1
            }
            j += 1
        }
        i += 1
    }
}

// Testing Code.
var array : [Int] = [9, 1, 8, 2, 7, 3, 6, 4, 5]
bubbleSort( &array)
print(array)

var array2 : [Int] = [9, 1, 8, 2, 7, 3, 6, 4, 5]
bubbleSort2( &array2)
print(array2)

/*
[1, 2, 3, 4, 5, 6, 7, 8, 9]
[1, 2, 3, 4, 5, 6, 7, 8, 9]
*/