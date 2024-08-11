import Foundation

func greater(_ value1 : Int, _ value2 : Int) -> Bool {
    return value1 > value2
}

func selectionSort(_ arr : inout [Int]) {
    // sorted array created in reverse order.
    let size : Int = arr.count
    var mx : Int, j : Int, i : Int = 0
    while (i < size - 1) {
        mx = 0
        j = 1
        while (j < size - i) {
            if (arr[j] > arr[mx]) {
                mx = j
            }
            j += 1
        }
        arr.swapAt(size-1-i, mx)
        i += 1
    }
}

func selectionSort2(_ arr : inout [Int]) {
    // sorted array created in forward direction
    let size : Int = arr.count
    var mn : Int, j : Int, i : Int = 0
    while (i < size - 1) {
        mn = i
        j = i + 1
        while (j < size) {
            if (arr[j] < arr[mn]) {
                mn = j
            }
            j += 1
        }
        arr.swapAt(i, mn)
        i += 1
    }
}

var array : [Int] = [9, 1, 8, 2, 7, 3, 6, 4, 5]
selectionSort(&array)
print(array)
var array2 : [Int] = [9, 1, 8, 2, 7, 3, 6, 4, 5]
selectionSort2(&array2)
print(array2)

/*
[1, 2, 3, 4, 5, 6, 7, 8, 9]
[1, 2, 3, 4, 5, 6, 7, 8, 9]
*/