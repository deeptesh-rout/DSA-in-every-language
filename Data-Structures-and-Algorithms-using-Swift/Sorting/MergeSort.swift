import Foundation

func merge(_ arr : inout [Int], _ tempArray : inout [Int], _ lowerIndex : Int, _ middleIndex : Int, _ upperIndex : Int) {
    var lowerStart : Int = lowerIndex
    let lowerStop : Int = middleIndex
    var upperStart : Int = middleIndex + 1
    let upperStop : Int = upperIndex
    var count : Int = lowerIndex
    while (lowerStart <= lowerStop && upperStart <= upperStop) {
        if (arr[lowerStart] < arr[upperStart]) {
            tempArray[count] = arr[lowerStart]
            lowerStart += 1
        } else {
            tempArray[count] = arr[upperStart]
            upperStart += 1
        }
        count += 1
    }
    while (lowerStart <= lowerStop) {
        tempArray[count] = arr[lowerStart]
        count += 1
        lowerStart += 1
    }
    while (upperStart <= upperStop) {
        tempArray[count] = arr[upperStart]
        count += 1
        upperStart += 1
    }
    var  i : Int = lowerIndex
    while (i <= upperIndex) {
        arr[i] = tempArray[i]
        i += 1
    }
}


func mergeSortUtil(_ arr : inout [Int], _ tempArray : inout [Int], _ lowerIndex : Int, _ upperIndex : Int) {
    if (lowerIndex >= upperIndex) {
        return
    }
    let middleIndex : Int = (lowerIndex + upperIndex) / 2
    mergeSortUtil( &arr, &tempArray,lowerIndex,middleIndex)
    mergeSortUtil( &arr, &tempArray,middleIndex + 1,upperIndex)
    merge( &arr, &tempArray,lowerIndex,middleIndex,upperIndex)
}

func mergeSort(_ arr : inout [Int]) {
    let size : Int = arr.count
    var tempArray : [Int] = Array(repeating: 0, count: size)
    mergeSortUtil( &arr, &tempArray,0,size - 1)
}

// Testing code.
var data = [9, 1, 8, 2, 7, 3, 6, 4, 5]
mergeSort(&data)
print(data)

// [1, 2, 3, 4, 5, 6, 7, 8, 9]
