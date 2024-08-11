import Foundation

func quickSelectUtil(_ arr : inout [Int], _ start : Int, _ stop : Int, _ k : Int) {
    if (stop <= start) {
        return
    }
    
    let pivot = arr[start]
	var lower = start
	var upper = stop

    while (lower < upper) {
        while (arr[lower] <= pivot && lower < upper) {
            lower += 1
        }
        while (arr[upper] > pivot && lower <= upper) {
            upper -= 1
        }
        if (lower < upper) {
            arr.swapAt(upper,lower)
        }
    }
    arr.swapAt(upper,start) 
    // upper is the pivot position
    if (k < upper) {
        quickSelectUtil( &arr,start,upper - 1,k)
    }
    // pivot -1 is the upper for left sub array.
    if (k > upper) {
        quickSelectUtil( &arr,upper + 1,stop,k)
    }
}

func quickSelect(_ arr : inout [Int], _ k : Int) -> Int {
    quickSelectUtil( &arr, 0, arr.count - 1, k - 1)
    return arr[k - 1]
}

// Testing Code.
var array : [Int] = [3, 4, 2, 1, 6, 5, 7, 8]
print("value at index 5 is : " + String(quickSelect( &array,5)))

// value at index 5 is : 5
