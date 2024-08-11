import Foundation

func quickSortUtil(_ arr : inout [Int], _ start : Int, _ stop : Int) {
    if stop <= start {
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
    
    arr.swapAt(upper, start) // upper is the pivot position
    quickSortUtil( &arr,start,upper - 1) // pivot -1 is the upper for left sub array.
    quickSortUtil( &arr,upper + 1,stop)
}

func quickSort(_ arr : inout [Int]) {
    let size : Int = arr.count
    quickSortUtil( &arr,0,size - 1)
}

// Testing Code.
var data = [9, 1, 8, 2, 7, 3, 6, 4, 5]
quickSort(&data)
print(data)

// [1, 2, 3, 4, 5, 6, 7, 8, 9]