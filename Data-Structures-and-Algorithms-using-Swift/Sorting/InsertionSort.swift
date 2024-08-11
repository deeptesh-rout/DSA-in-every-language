import Foundation

func greater(_ value1 : Int, _ value2 : Int) -> Bool {
    return value1 > value2
}

func insertionSort(_ arr : inout [Int]) {
    let size : Int = arr.count
    var temp : Int, j : Int, i : Int = 1
    while (i < size) {
        temp = arr[i]
        j = i
        while (j > 0 && greater(arr[j - 1],temp)) {
            arr[j] = arr[j - 1]
            j -= 1
        }
        arr[j] = temp
        i += 1
    }
}

// Testing Code.
var array : [Int] = [9, 1, 8, 2, 7, 3, 6, 4, 5]
insertionSort( &array)
print(array)

// [1, 2, 3, 4, 5, 6, 7, 8, 9]
