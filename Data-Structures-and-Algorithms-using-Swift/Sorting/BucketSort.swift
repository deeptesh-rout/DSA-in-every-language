import Foundation

// Allowed values from 0 to maxValue.
func bucketSort(_ arr : inout [Int], _ maxValue : Int) {
    let numBucket : Int = 5
    bucketSortUtil( &arr,maxValue,numBucket)
}

func bucketSortUtil(_ arr : inout [Int], _ maxValue : Int, _ numBucket : Int) {
    let length : Int = arr.count
    if (length == 0) {
        return
    }

    var bucket :  [ [Int]] =  [ [Int]]()
    var i : Int = 0
    // Create empty buckets
    while (i < numBucket) {
        bucket.append( [Int]())
        i += 1
    }
    
    let div : Int = Int(ceil(Double(maxValue) / Double(numBucket)))
    
    // Add elements into the buckets
    i = 0
    while (i < length) {
        if (arr[i] < 0 || arr[i] > maxValue) {
            print("Value out of range.")
            return
        }
        var bucketIndex : Int = (arr[i] / div)
        // Maximum value will be assigned to last bucket.
        if (bucketIndex >= numBucket) {
            bucketIndex = numBucket - 1
        }
        bucket[bucketIndex].append(arr[i])
        i += 1
    }
    
    // Sort the elements of each bucket.
    i = 0
    while (i < numBucket) {
        bucket[i] = bucket[i].sorted(by: <)
        i += 1
    }
    
    // Populate output from the sorted subarray.
    var index : Int = 0
    var count : Int

    i = 0
    while (i < numBucket) {
        let temp :  [Int] = bucket[i]
        count = temp.count
        var  j : Int = 0
        while (j < count) {
            arr[index] = temp[j]
            index += 1
            j += 1
        }
        i += 1
    }
}

// Testing Code.
var array : [Int] = [1, 34, 7, 99, 5, 23, 45, 88, 77, 19, 91, 100]
let maxValue : Int = 100
bucketSort( &array, maxValue)
print(array)

// [1, 5, 7, 19, 23, 34, 45, 77, 88, 91, 99, 100]
