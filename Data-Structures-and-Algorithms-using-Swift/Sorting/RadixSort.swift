import Foundation

func getMax(_ arr : inout [Int], _ n : Int) -> Int {
    var max : Int = arr[0]
    var  i : Int = 1
    while (i < n) {
        if (max < arr[i]) {
            max = arr[i]
        }
        i += 1
    }
    return max
}

func countSort(_ arr : inout [Int], _ n : Int, _ dividend : Int) {
    let temp : [Int] = arr
    var count : [Int] = Array(repeating: 0, count: 10)
    var  i : Int = 0
    // Store count of occurrences in count array.
    // (number / dividend) % 10 is used to find the working digit.
    while (i < n) {
        count[(temp[i] / dividend) % 10] += 1
        i += 1
    }

    i = 1
    // Change count[i] so that count[i] contains
    // number of elements till index i in output.
    while (i < 10) {
        count[i] += count[i - 1]
        i += 1
    }
    
    i = n - 1
    // Copy content to input arr.
    while (i >= 0) {
        let index : Int = (temp[i] / dividend) % 10
        arr[count[index] - 1] = temp[i]
        count[index] -= 1
        i -= 1
    }
}

func radixSort(_ arr : inout [Int]) {
    let n : Int = arr.count
    let m : Int = getMax( &arr,n)
    var div : Int = 1
    // Counting sort for every digit.
    // The dividend passed is used to calculate current working digit.
    while (m / div > 0) {
        countSort( &arr,n,div)
        div *= 10
    }
}

// Testing Code.
var array : [Int] = [100, 49, 65, 91, 702, 29, 4, 55]
radixSort( &array)
print(array)

// [4, 29, 49, 55, 65, 91, 100, 702]
