import Foundation
 
func greater(_ value1 : Int, _ value2 : Int) -> Bool {
    return value1 > value2
}

func shellSort(_ arr : inout [Int]) {
    let n : Int = arr.count
    var gap : Int = n / 2 // Gap starts with n/2 and half in each iteration.
    while (gap > 0) {
        var i : Int = gap // Do a gapped insertion sort.
        while (i < n) {
            let curr : Int = arr[i]
            // Shift elements of already sorted list
            // to find right position for curr value.
            var j : Int = i
            while (j >= gap && greater(arr[j - gap],curr)) {
                arr[j] = arr[j - gap]
                j -= gap
            }
            
            // Put current value in its correct location
            arr[j] = curr
            i += 1
        }
        gap /= 2
    }
}

var array : [Int] = [36, 32, 11, 6, 19, 31, 17, 3]
shellSort( &array)
print(array)

// [3, 6, 11, 17, 19, 31, 32, 36]
