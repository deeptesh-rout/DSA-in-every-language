import java.util.Arrays

fun printArray(arr: IntArray, count: Int) {
    print("[")
    for (i in 0 until count) {
        print(" " + arr[i])
    }
    println(" ]")
}

fun swap(arr: IntArray, x: Int, y: Int) {
    val temp = arr[x]
    arr[x] = arr[y]
    arr[y] = temp
    return
}

fun partition01(arr: IntArray, size: Int): Int {
    var left = 0
    var right = size - 1
    var count = 0
    while (left < right) {
        while (arr[left] == 0) left += 1
        while (arr[right] == 1) right -= 1
        if (left < right) {
            swap(arr, left, right)
            count += 1
        }
    }
    return count
}

fun partition012_(arr: IntArray, size: Int) {
    var zero = 0
    var one = 0
    var two = 0
    for (i in 0 until size) {
        if (arr[i] == 0) {
            zero += 1
        } else if (arr[i] == 1) {
            one += 1
        } else {
            two += 1
        }
    }
    var index = 0
    while (zero > 0) {
        arr[index++] = 0
        zero -= 1
    }
    while (one > 0) {
        arr[index++] = 1
        one -= 1
    }
    while (two > 0) {
        arr[index++] = 2
        two -= 1
    }
}

fun partition012(arr: IntArray, size: Int) {
    var left = 0
    var right = size - 1
    var i = 0
    while (i <= right) {
        if (arr[i] == 0) {
            swap(arr, i, left)
            i += 1
            left += 1
        } else if (arr[i] == 2) {
            swap(arr, i, right)
            right -= 1
        } else {
            i += 1
        }
    }
}

// Testing code
fun main1() {
    val arr = intArrayOf(0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1)
    partition01(arr, arr.size)
    printArray(arr, arr.size)
    val arr2 = intArrayOf(0, 1, 1, 0, 1, 2, 1, 2, 0, 0, 0, 1)
    partition012(arr2, arr2.size)
    printArray(arr2, arr2.size)
    val arr3 = intArrayOf(0, 1, 1, 0, 1, 2, 1, 2, 0, 0, 0, 1)
    partition012_(arr3, arr3.size)
    printArray(arr3, arr3.size)
}

/*
[ 0 0 0 0 0 0 1 1 1 1 1 1 ]
[ 0 0 0 0 0 1 1 1 1 1 2 2 ]
*/

fun rangePartition(arr: IntArray, size: Int, lower: Int, higher: Int) {
    var start = 0
    var end = size - 1
    var i = 0
    while (i <= end) {
        if (arr[i] < lower) {
            swap(arr, i, start)
            i += 1
            start += 1
        } else if (arr[i] > higher) {
            swap(arr, i, end)
            end -= 1
        } else {
            i += 1
        }
    }
}

// Testing code
fun main2() {
    val arr = intArrayOf(1, 2, 3, 4, 18, 5, 17, 6, 16, 7, 15, 8, 14, 9, 13, 10, 12, 11)
    rangePartition(arr, arr.size, 9, 12)
    printArray(arr, arr.size)
}

/*
[ 1 2 3 4 5 6 7 8 10 12 9 11 14 13 15 16 17 18 ]
*/

fun minSwaps(arr: IntArray, size: Int, `val`: Int): Int {
    var swapCount = 0
    var first = 0
    var second = size - 1
    var temp: Int
    while (first < second) {
        if (arr[first] <= `val`) first += 1 else if (arr[second] > `val`) second -= 1 else {
            temp = arr[first]
            arr[first] = arr[second]
            arr[second] = temp
            swapCount += 1
        }
    }
    return swapCount
}

//Testing code
fun main3() {
    val array = intArrayOf(1, 2, 3, 4, 18, 5, 17, 6, 16, 7, 15, 8, 14, 9, 13, 10, 12, 11)
    println("minSwaps " + minSwaps(array, array.size, 10))
}

// minSwaps 3

fun separateEvenAndOdd(data: IntArray, size: Int) {
    var left = 0
    var right = size - 1
    val aux = IntArray(size)
    for (i in 0 until size) {
        if (data[i] % 2 == 0) {
            aux[left] = data[i]
            left++
        } else if (data[i] % 2 == 1) {
            aux[right] = data[i]
            right--
        }
    }
    for (i in 0 until size) data[i] = aux[i]
}

fun separateEvenAndOdd2(data: IntArray, size: Int) {
    var left = 0
    var right = size - 1
    while (left < right) {
        if (data[left] % 2 == 0) left++ else if (data[right] % 2 == 1) right-- else {
            swap(data, left, right)
            left++
            right--
        }
    }
}

// Testing code
fun main4() {
    val array = intArrayOf(9, 1, 8, 2, 7, 3, 6, 4, 5)
    separateEvenAndOdd(array, array.size)
    printArray(array, array.size)
    val array2 = intArrayOf(9, 1, 8, 2, 7, 3, 6, 4, 5)
    separateEvenAndOdd2(array2, array2.size)
    printArray(array2, array2.size)
}

// [ 8 2 6 4 5 3 7 1 9 ]
// [ 4 6 8 2 7 3 1 9 5 ]

fun absGreater(value1: Int, value2: Int, ref: Int): Boolean {
    return java.lang.Math.abs(value1 - ref) > java.lang.Math.abs(value2 - ref)
}

fun absBubbleSort(arr: IntArray, size: Int, ref: Int) {
    for (i in 0 until size - 1) {
        for (j in 0 until size - i - 1) {
            if (absGreater(arr[j], arr[j + 1], ref)) {
                swap(arr, j, j + 1)
            }
        }
    }
}

// Testing code
fun main5() {
    val array = intArrayOf(9, 1, 8, 2, 7, 3, 6, 4, 5)
    val ref = 5
    absBubbleSort(array, array.size, ref)
    printArray(array, array.size)
}

/*
[ 5 6 4 7 3 8 2 9 1 ]
*/

fun eqGreater(value1: Int, value2: Int, A: Int): Boolean {
    return A * value1 * value1 > A * value2 * value2
}

fun arrayReduction(arr: IntArray, size: Int) {
    Arrays.sort(arr)
    var count = 1
    var reduction = arr[0]
    for (i in 0 until size) {
        if (arr[i] - reduction > 0) {
            reduction = arr[i]
            count += 1
        }
    }
    println("Total number of reductions: $count")
}

// Testing code
fun main6() {
    val arr = intArrayOf(5, 1, 1, 1, 2, 3, 5)
    arrayReduction(arr, arr.size)
}

// Total number of reductions: 4

fun sortByOrder(arr: IntArray, size: Int, arr2: IntArray, size2: Int) {
    val ht: HashMap<Int, Int> = HashMap<Int, Int>()
    var value: Int
    for (i in 0 until size) {
        if (ht.containsKey(arr[i])) {
            value = ht.get(arr[i])!!
            ht.put(arr[i], value + 1)
        } else {
            ht.put(arr[i], 1)
        }
    }
    for (j in 0 until size2) {
        if (ht.containsKey(arr2[j])) {
            value = ht.get(arr2[j])!!
            for (k in 0 until value) {
                print(arr2[j].toString() + " ")
            }
            ht.remove(arr2[j])
        }
    }
    for (i in 0 until size) {
        if (ht.containsKey(arr[i])) {
            value = ht.get(arr[i])!!
            for (k in 0 until value) {
                print(arr[i].toString() + " ")
            }
            ht.remove(arr[i])
        }
    }
}

// Testing code
fun main7() {
    val arr = intArrayOf(2, 1, 2, 5, 7, 1, 9, 3, 6, 8, 8)
    val arr2 = intArrayOf(2, 1, 8, 3)
    sortByOrder(arr, arr.size, arr2, arr2.size)
    println()
}

/*
2 2 1 1 8 8 3 5 7 9 6 
*/

fun merge(arr1: IntArray, size1: Int, arr2: IntArray, size2: Int) {
    var index = 0
    var temp: Int
    while (index < size1) {
        if (arr1[index] <= arr2[0]) {
            index += 1
        } else {
            // always first element of arr2 is compared.
            temp = arr1[index]
            arr1[index] = arr2[0]
            arr2[0] = temp
            index += 1
            // After swap arr2 may be unsorted.
            // Insertion of the element in proper sorted position.
            for (i in 0 until size2 - 1) {
                if (arr2[i] < arr2[i + 1]) break
                temp = arr2[i]
                arr2[i] = arr2[i + 1]
                arr2[i + 1] = temp
            }
        }
    }
}

// Testing code.
fun main8() {
    val arr1 = intArrayOf(1, 5, 9, 10, 15, 20)
    val arr2 = intArrayOf(2, 3, 8, 13)
    merge(arr1, arr1.size, arr2, arr2.size)
    printArray(arr1, arr1.size)
    printArray(arr2, arr2.size)
}

/*
[ 1 2 3 5 8 9 ]
[ 10 13 15 20 ]
*/

fun checkReverse(arr: IntArray, size: Int): Boolean {
    var start = -1
    var stop = -1
    for (i in 0 until size - 1) {
        if (arr[i] > arr[i + 1]) {
            start = i
            break
        }
    }
    if (start == -1) return true
    for (i in start until size - 1) {
        if (arr[i] < arr[i + 1]) {
            stop = i
            break
        }
    }
    if (stop == -1) return true

    // increasing property
    // after reversal the sub array should fit in the array.
    if (arr[start - 1] > arr[stop] || arr[stop + 1] < arr[start]) return false
    for (i in stop + 1 until size - 1) {
        if (arr[i] > arr[i + 1]) {
            return false
        }
    }
    return true
}

// Testing code.
fun main9() {
    val arr1 = intArrayOf(1, 2, 6, 5, 4, 7)
    println(checkReverse(arr1, arr1.size))
}

// true

fun unionIntersectionSorted(arr1: IntArray, size1: Int, arr2: IntArray, size2: Int) {
    var first = 0
    var second = 0
    val unionArr = IntArray(size1 + size2)
    val interArr = IntArray(Math.min(size1, size2))
    var uIndex = 0
    var iIndex = 0
    while (first < size1 && second < size2) {
        if (arr1[first] == arr2[second]) {
            unionArr[uIndex++] = arr1[first]
            interArr[iIndex++] = arr1[first]
            first += 1
            second += 1
        } else if (arr1[first] < arr2[second]) {
            unionArr[uIndex++] = arr1[first]
            first += 1
        } else {
            unionArr[uIndex++] = arr2[second]
            second += 1
        }
    }
    while (first < size1) {
        unionArr[uIndex++] = arr1[first]
        first += 1
    }
    while (second < size2) {
        unionArr[uIndex++] = arr2[second]
        second += 1
    }
    printArray(unionArr, uIndex)
    printArray(interArr, iIndex)
}

fun unionIntersectionUnsorted(arr1: IntArray, size1: Int, arr2: IntArray, size2: Int) {
    Arrays.sort(arr1)
    Arrays.sort(arr2)
    unionIntersectionSorted(arr1, size1, arr2, size2)
}

// Testing code.
fun main10() {
    val arr1 = intArrayOf(1, 11, 2, 3, 14, 5, 6, 8, 9)
    val arr2 = intArrayOf(2, 4, 5, 12, 7, 8, 13, 10)
    unionIntersectionUnsorted(arr1, arr1.size, arr2, arr2.size)
}

/*
[ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 ]
[ 2 5 8 ]
*/

fun main() {
    main1()
    main2()
    main3()
    main4()
    main5()
    main6()
    main7()
    main8()
    main9()
    main10()
}