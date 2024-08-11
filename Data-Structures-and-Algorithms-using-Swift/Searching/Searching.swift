import Foundation


func linearSearchUnsorted(_ arr : inout [Int], _ size : Int, _ value : Int) -> Bool {
	var i : Int = 0
	while (i < size) {
		if (value == arr[i]) {
			return true
		}
		i += 1
	}
	return false
}

func linearSearchSorted(_ arr : inout [Int], _ size : Int, _ value : Int) -> Bool {
	var i : Int = 0
	while (i < size) {
		if (value == arr[i]) {
			return true
		} else if (value < arr[i]) {
			return false
		}
		i += 1
	}
	return false
}

// Binary Search Algorithm - Iterative Way
func binarySearch(_ arr : inout [Int], _ size : Int, _ value : Int) -> Bool {
	var low : Int = 0
	var high : Int = size - 1
	var mid : Int
	while (low <= high) {
		mid = (low + high) / 2
		if (arr[mid] == value) {
			return true
		} else if (arr[mid] < value) {
			low = mid + 1
		} else {
			high = mid - 1
		}
	}
	return false
}

// Binary Search Algorithm - Recursive Way
func binarySearchRec(_ arr : inout [Int], _ size : Int, _ value : Int) -> Bool {
	let low : Int = 0
	let high : Int = size - 1
	return binarySearchRecUtil( &arr,low,high,value)
}

func binarySearchRecUtil(_ arr : inout [Int], _ low : Int, _ high : Int, _ value : Int) -> Bool {
	if (low > high) {
		return false
	}
	let mid : Int = (low + high) / 2
	if (arr[mid] == value) {
		return true
	} else if (arr[mid] < value) {
		return binarySearchRecUtil( &arr,mid + 1,high,value)
	} else {
		return binarySearchRecUtil( &arr,low,mid - 1,value)
	}
}

func binarySearch(_ arr : inout [Int], _ start : Int, _ end : Int, _ key : Int, _ isInc : Bool) -> Int {
	var mid : Int
	if (end < start) {
		return -1
	}
	mid = (start + end) / 2
	if (key == arr[mid]) {
		return mid
	}
	if (isInc != false && key < arr[mid] || isInc == false && key > arr[mid]) {
		return binarySearch( &arr,start,mid - 1,key,isInc)
	} else {
		return binarySearch( &arr,mid + 1,end,key,isInc)
	}
}

func fibonacciSearch(_ arr : inout [Int], _ size : Int, _ value : Int) -> Bool {
	// Initialize fibonacci numbers 
	var fibNMn2 : Int = 0
	var fibNMn1 : Int = 1
	var fibN : Int = fibNMn2 + fibNMn1
	while (fibN < size) {
		fibNMn2 = fibNMn1
		fibNMn1 = fibN
		fibN = fibNMn2 + fibNMn1
	}
	var low : Int = 0
	while (fibN > 1) {
		// fibonacci series start with 0, 1, 1, 2
		let i : Int = min(low + fibNMn2,size - 1)
		if (arr[i] == value) {
			return true
		} else if (arr[i] < value) {
			fibN = fibNMn1
			fibNMn1 = fibNMn2
			fibNMn2 = fibN - fibNMn1
			low = i
		} else {
			// for feb2 <= 1, these will be invalid.
			fibN = fibNMn2
			fibNMn1 = fibNMn1 - fibNMn2
			fibNMn2 = fibN - fibNMn1
		}
	}
	if (arr[low + fibNMn2] == value) {
		// above loop does not check when fibNMn2 = 0
		return true
	}
	return false
}

func main1() {
	var first : [Int] = [1, 3, 5, 7, 9, 25, 30]
	print(linearSearchUnsorted( &first,7,8))
	print(linearSearchSorted( &first,7,8))
	print(binarySearch( &first,7,8))
	print(binarySearchRec( &first,7,8))
	print(linearSearchUnsorted( &first,7,25))
	print(linearSearchSorted( &first,7,25))
	print(binarySearch( &first,7,25))
	print(binarySearchRec( &first,7,25))
	print(fibonacciSearch( &first,7,8))
	print(fibonacciSearch( &first,7,25))
}
// false 
// false 
// false 
// false
// 
// true 
// true 
// true 
// true

func swap(_ arr : inout [Int], _ first : Int, _ second : Int) {
	let temp : Int = arr[first]
	arr[first] = arr[second]
	arr[second] = temp
}

func firstRepeated(_ arr : inout [Int], _ size : Int) -> Int {
	var i : Int = 0
	while (i < size) {
		var j : Int = i + 1
		while (j < size) {
			if (arr[i] == arr[j]) {
				return arr[i]
			}
			j += 1
		}
		i += 1
	}
	return 0
}

func firstRepeated2(_ arr : inout [Int], _ size : Int) -> Int {
	var hm :  [Int:Int] =  [Int:Int]()
	var i : Int = 0
	while (i < size) {
		if (hm.keys.contains(arr[i])) {
			hm[arr[i]] = 2
		} else {
			hm[arr[i]] = 1
		}
		i += 1
	}
	
	i = 0
	while (i < size) {
		if (hm[arr[i]]! == 2) {
			return arr[i]
		}
		i += 1
	}
	return 0
}

func main2() {
	var first : [Int] = [1, 3, 5, 3, 9, 1, 30]
	print(firstRepeated( &first,first.count))
	print(firstRepeated2( &first,first.count))
}
// 1

func printRepeating(_ arr : inout [Int], _ size : Int) {
	print("Repeating elements are ",terminator: "")
	var i : Int = 0
	while (i < size) {
		var j : Int = i + 1
		while (j < size) {
			if (arr[i] == arr[j]) {
				print(" " + String(arr[i]),terminator: "")
			}
			j += 1
		}
		i += 1
	}
	print()
}

func printRepeating2(_ arr : inout [Int], _ size : Int) {
	arr	= arr.sorted(by: <)
	print("Repeating elements are ",terminator: "")
	var i : Int = 1
	while (i < size) {
		if (arr[i] == arr[i - 1]) {
			print(" " + String(arr[i]),terminator: "")
		}
		i += 1
	}
	print()
}

func printRepeating3(_ arr : inout [Int], _ size : Int) {
	var hs : Set<Int> = Set<Int>()
	print("Repeating elements are ",terminator: "")
	var i : Int = 0
	while (i < size) {
		if (hs.contains(arr[i])) {
			print(" " + String(arr[i]),terminator: "")
		} else {
			hs.insert(arr[i])
		}
		i += 1
	}
	print()
}

func printRepeating4(_ arr : inout [Int], _ size : Int, _ range : Int) {
	var count : [Int] = Array(repeating: 0, count: range)
	print("Repeating elements are ",terminator: "")
	var i : Int = 0
	while (i < size) {
		if (count[arr[i]] == 1) {
			print(" " + String(arr[i]),terminator: "")
		} else {
			count[arr[i]] += 1
		}
		i += 1
	}
	print()
}

func main3() {
	var first : [Int] = [1, 3, 5, 3, 9, 1, 30]
	printRepeating( &first,first.count)
	printRepeating2( &first,first.count)
	printRepeating3( &first,first.count)
	printRepeating4( &first,first.count,50)
}
// Repeating elements are 1 3 
// Repeating elements are 1 3 
// Repeating elements are 1 3 
// Repeating elements are 1 3

func removeDuplicates(_ array : inout [Int], _ size : Int) -> [Int] {
	var j : Int = 0
	var array = array.sorted(by : <)
	var i : Int = 1
	while (i < size) {
		if (array[i] != array[j]) {
			j += 1
			array[j] = array[i]
		}
		i += 1
	}
	return Array(array[0...j])
}

func removeDuplicates2(_ arr : inout [Int], _ size : Int) -> [Int] {
	var hm :  [Int:Int] =  [Int:Int]()
	var j : Int = 0
	var i : Int = 0
	while (i < size) {
		if (!hm.keys.contains(arr[i])) {
			arr[j] = arr[i]
			j += 1
			hm[arr[i]] = 1
		}
		i += 1
	}
	return Array(arr[0...j-1])
}

func main4() {
	var first : [Int] = [1, 3, 5, 3, 9, 1, 30]
	let ret : [Int] = removeDuplicates( &first,first.count)
	print(ret)
	
	var first2 : [Int] = [1, 3, 5, 3, 9, 1, 30]
	let ret2 : [Int] = removeDuplicates2( &first2,first2.count)
	print(ret2)
}

// [1, 3, 5, 9, 30]
// [1, 3, 5, 9, 30]


func findMissingNumber(_ arr : inout [Int], _ size : Int) -> Int {
	var j : Int
	var found : Int = 0
	var i : Int = 1
	while (i <= size) {
		found = 0
		j = 0
		while (j < size) {
			if (arr[j] == i) {
				found = 1
				break
			}
			j += 1
		}
		
		if (found == 0) {
			return i
		}
		i += 1
	}
	return Int.max
}

func findMissingNumber2(_ arr : inout [Int], _ size : Int) -> Int {
	arr = arr.sorted(by: <)
	var i : Int = 0
	while (i < size) {
		if (arr[i] != i + 1) {
			return i + 1
		}
		i += 1
	}
	return size
}

func findMissingNumber3(_ arr : inout [Int], _ size : Int) -> Int {
	var hm :  [Int:Int] =  [Int:Int]()
	var i : Int = 0
	while (i < size) {
		hm[arr[i]] = 1
		i += 1
	}
	
	i = 1
	while (i <= size) {
		if (!hm.keys.contains(i)) {
			return i
		}
		i += 1
	}
	return Int.max
}

func findMissingNumber4(_ arr : inout [Int], _ size : Int) -> Int {
	var count : [Int] = Array(repeating: -1, count: size + 1)
	var i : Int = 0
	while (i < size) {
		count[arr[i] - 1] = 1
		i += 1
	}
	
	i = 0
	while (i <= size) {
		if (count[i] == -1) {
			return i + 1
		}
		i += 1
	}
	return Int.max
}

func findMissingNumber5(_ arr : inout [Int], _ size : Int) -> Int {
	var sum : Int = 0
	var i : Int = 1
	// Element value range is from 1 to size+1.
	while (i < (size + 2)) {
		sum += i
		i += 1
	}
	
	i = 0
	while (i < size) {
		sum -= arr[i]
		i += 1
	}
	return sum
}

func findMissingNumber6(_ arr : inout [Int], _ size : Int) -> Int {
	var i : Int = 0
	while (i < size) {
		// len(arr)+1 value should be ignored.
		if (arr[i] != size + 1 && arr[i] != size * 3 + 1) {
			// 1 should not become (len(arr)+1) so multiplied by 2
			arr[(arr[i] - 1) % size] += size * 2
		}
		i += 1
	}
	
	i = 0
	while (i < size) {
		if (arr[i] < (size * 2)) {
			return i + 1
		}
		i += 1
	}
	
	return Int.max
}

func findMissingNumber7(_ arr : inout [Int], _ size : Int) -> Int {
	var xorSum : Int = 0
	var i : Int = 1
	// Element value range is from 1 to size+1.
	while (i < (size + 2)) {
		xorSum ^= i
		i += 1
	}
	
	i = 0
	// loop through the array and get the XOR of elements
	while (i < size) {
		xorSum ^= arr[i]
		i += 1
	}
	return xorSum
}

func findMissingNumber8(_ arr : inout [Int], _ size : Int) -> Int {
	var st : Set<Int> = Set<Int>()
	var i : Int = 0
	while (i < size) {
		st.insert(arr[i])
		i += 1
	}
	i = 1
	while (i <= size) {
		if (st.contains(i) == false) {
			return i
		}
		i += 1
	}
	print("NoNumberMissing")
	return -1
}

func main5() {
	var first : [Int] = [1, 5, 4, 3, 2, 7, 8, 9]
	print(findMissingNumber( &first,first.count))
	print(findMissingNumber2( &first,first.count))
	print(findMissingNumber3( &first,first.count))
	print(findMissingNumber4( &first,first.count))
	print(findMissingNumber5( &first,first.count))
	print(findMissingNumber7( &first,first.count))
	print(findMissingNumber8( &first,first.count))
	print(findMissingNumber6( &first,first.count))
}
// 6 
//6 
//6

func missingValues(_ arr : inout [Int], _ size : Int) {
	var max : Int = arr[0]
	var min : Int = arr[0]
	var i : Int = 1
	while (i < size) {
		if (max < arr[i]) {
			max = arr[i]
		}
		if (min > arr[i]) {
			min = arr[i]
		}
		i += 1
	}
	
	var found : Bool
	i = min + 1
	while (i < max) {
		found = false
		var j : Int = 0
		while (j < size) {
			if (arr[j] == i) {
				found = true
				break
			}
			j += 1
		}
		if (!found) {
			print(String(i) + " ",terminator: "")
		}
		i += 1
	}
	print()
}

func missingValues2(_ arr : inout [Int], _ size : Int) {
	arr = arr.sorted(by:<)
	var value : Int = arr[0]
	var i : Int = 0
	while (i < size) {
		if (value == arr[i]) {
			value += 1
			i += 1
		} else {
			print(String(value) + " ",terminator: "")
			value += 1
		}
	}
	print()
}

func missingValues3(_ arr : inout [Int], _ size : Int) {
	var ht : Set<Int> = Set<Int>()
	var minVal : Int = 999999
	var maxVal : Int = -999999
	var i : Int = 0
	while (i < size) {
		ht.insert(arr[i])
		if (minVal > arr[i]) {
			minVal = arr[i]
		}
		if (maxVal < arr[i]) {
			maxVal = arr[i]
		}
		i += 1
	}
	
	i = minVal
	while (i < maxVal + 1) {
		if (ht.contains(i) == false) {
			print(String(i) + " ",terminator: "")
		}
		i += 1
	}

	print()
}

func main6() {
	var arr : [Int] = [11, 14, 13, 17, 21, 18, 19, 23, 24]
	let size : Int = arr.count
	missingValues( &arr,size)
	missingValues2( &arr,size)
	missingValues3( &arr,size)
}
// 12 15 16 20 22 
// 12 15 16 20 22
// 12 15 16 20 22

func oddCount(_ arr : inout [Int], _ size : Int) {
	var xorSum : Int = 0
	var i : Int = 0
	while (i < size) {
		xorSum ^= arr[i]
		i += 1
	}
	print("Odd values: " + String(xorSum))
}

func oddCount2(_ arr : inout [Int], _ size : Int) {
	var hm :  [Int:Int] =  [Int:Int]()
	var i : Int = 0
	while (i < size) {
		if (hm.keys.contains(arr[i])) {
			hm[arr[i]] = nil
		} else {
			hm[arr[i]] = 1
		}
		i += 1
	}
	
	print("Odd values: ",terminator: "")
	for key in Array(hm.keys) {
		print(String(key) + " ",terminator: "")
	}
	print()
	print("Odd count is :: " + String(hm.count))
}

func oddCount3(_ arr : inout [Int], _ size : Int) {
	var xorSum : Int = 0
	var first : Int = 0
	var second : Int = 0
	var setBit : Int
	var i : Int = 0
	// xor of all elements in arr[] even occurrence will cancel each other. sum will
	// contain sum of two odd elements.
	while (i < size) {
		xorSum = xorSum ^ arr[i]
		i += 1
	}
	
	// Rightmost set bit.
	setBit = xorSum & ~(xorSum - 1)
	
	// Dividing elements in two group: Elements having setBit bit as 1. Elements
	// having setBit bit as 0. Even elements cancelled themselves if group and we
	// get our numbers.
	i = 0
	while (i < size) {
		if ((arr[i] & setBit) != 0) {
			first ^= arr[i]
		} else {
			second ^= arr[i]
		}
		i += 1
	}
	
	print("Odd values: " + String(first) + " " + String(second))
}

func main7() {
	var arr : [Int] = [10, 25, 30, 10, 15, 25, 15]
	let size : Int = arr.count
	oddCount( &arr,size)
	oddCount2( &arr,size)
	var arr2 : [Int] = [10, 25, 30, 10, 15, 25, 15, 40]
	let size2 : Int = arr2.count
	oddCount3( &arr2,size2)
}
// Odd values: 30
// Odd values: 30 
// Odd count is :: 1
// Odd values: 30 40

func sumDistinct(_ arr : inout [Int], _ size : Int) {
	var sum : Int = 0
	arr = arr.sorted(by: <)
	var i : Int = 0
	while (i < (size - 1)) {
		if (arr[i] != arr[i + 1]) {
			sum += arr[i]
		}
		i += 1
	}
	
	sum += arr[size - 1]
	print("sum : " + String(sum))
}

func main8() {
	var arr : [Int] = [1, 2, 3, 1, 1, 4, 5, 6]
	let size : Int = arr.count
	sumDistinct( &arr,size)
}
// sum : 21

func minAbsSumPair(_ arr : inout [Int], _ size : Int) {
	var l : Int
	var r : Int
	var minSum : Int
	var sum : Int
	var minFirst : Int
	var minSecond : Int
	// Array should have at least two elements
	if (size < 2) {
		print("Invalid Input")
		return
	}
	// Initialisation of values
	minFirst = 0
	minSecond = 1
	minSum = abs(arr[0] + arr[1])
	l = 0
	while (l < size - 1) {
		r = l + 1
		while (r < size) {
			sum = abs(arr[l] + arr[r])
			if (sum < minSum) {
				minSum = sum
				minFirst = l
				minSecond = r
			}
			r += 1
		}
		l += 1
	}
	print("Minimum sum elements are : " + String(arr[minFirst]) + " , " + String(arr[minSecond]))
}

func minAbsSumPair2(_ arr : inout [Int], _ size : Int) {
	var l : Int
	var r : Int
	var minSum : Int
	var sum : Int
	var minFirst : Int
	var minSecond : Int
	// Array should have at least two elements
	if (size < 2) {
		print("Invalid Input")
		return
	}
	arr = arr.sorted(by: <)
	// Initialisation of values
	minFirst = 0
	minSecond = size - 1
	minSum = abs(arr[minFirst] + arr[minSecond])
	l = 0
	r = size - 1
	while (l < r) {
		sum = (arr[l] + arr[r])
		if (abs(sum) < minSum) {
			minSum = abs(sum)
			minFirst = l
			minSecond = r
		}

		if (sum < 0) {
			l += 1
		} else if (sum > 0) {
			r -= 1
		} else {
			break
		}
	}
	print("Minimum sum elements are : " + String(arr[minFirst]) + " , " + String(arr[minSecond]))
}

func main9() {
	var first : [Int] = [1, 5, -10, 3, 2, -6, 8, 9, 6]
	minAbsSumPair2( &first,first.count)
	minAbsSumPair( &first,first.count)
}
// Minimum sum elements are : -6 , 6 
// Minimum sum elements are : -6 , 6

func findPair(_ arr : inout [Int], _ size : Int, _ value : Int) -> Bool {
	var i : Int = 0
	while (i < size) {
		var j : Int = i + 1
		while (j < size) {
			if ((arr[i] + arr[j]) == value) {
				print("The pair is : " + String(arr[i]) + " & " + String(arr[j]))
				return true
			}
			j += 1
		}
		i += 1
	}
	return false
}

func findPair2(_ arr : inout [Int], _ size : Int, _ value : Int) -> Bool {
	var first : Int = 0
	var second : Int = size - 1
	var curr : Int
	arr = arr.sorted(by: <)
	while (first < second) {
		curr = arr[first] + arr[second]
		if (curr == value) {
			print("The pair is : " + String(arr[first]) + " & " + String(arr[second]))
			return true
		} else if (curr < value) {
			first += 1
		} else {
			second -= 1
		}
	}
	return false
}

func findPair3(_ arr : inout [Int], _ size : Int, _ value : Int) -> Bool {
	var hs : Set<Int> = Set<Int>()
	var i : Int = 0
	while (i < size) {
		if (hs.contains(value - arr[i])) {
			print("The pair is : " + String(arr[i]) + " & " + String((value - arr[i])))
			return true
		}
		hs.insert(arr[i])
		i += 1
	}
	return false
}

func findPair4(_ arr : inout [Int], _ size : Int, _ range : Int, _ value : Int) -> Bool {
	var count : [Int] = Array(repeating: 0, count: range + 1)
	var i : Int = 0
	while (i < size) {
		if (count[value - arr[i]] > 0) {
			print("The pair is : " + String(arr[i]) + " & " + String((value - arr[i])))
			return true
		}
		count[arr[i]] += 1
		i += 1
	}
	return false
}

func main10() {
	var first : [Int] = [1, 5, 4, 3, 2, 7, 8, 9, 6]
	_ = findPair( &first,first.count,8)
	_ = findPair2( &first,first.count,8)
	_ = findPair3( &first,first.count,8)
	_ = findPair4( &first,first.count,9,8)
}
// The pair is : 1 & 7
// The pair is : 1 & 7
// The pair is : 5 & 3
// The pair is : 5 & 3

func findPairTwoLists(_ arr1 : inout [Int], _ size1 : Int, _ arr2 : inout [Int], _ size2 : Int, _ value : Int) -> Bool {
	var i : Int = 0
	while (i < size1) {
		var j : Int = 0
		while (j < size2) {
			if ((arr1[i] + arr2[j]) == value) {
				print("The pair is : " + String(arr1[i]) + " & " + String(arr2[j]))
				return true
			}
			j += 1
		}
		i += 1
	}
	return false
}

func findPairTwoLists2(_ arr1 : inout [Int], _ size1 : Int, _ arr2 : inout [Int], _ size2 : Int, _ value : Int) -> Bool {
	arr2 = arr2.sorted(by:<)
	var i : Int = 0
	while (i < size1) {
		if (binarySearch( &arr2,size2,value - arr1[i])) {
			print("The pair is : " + String(arr1[i]) + " & " + String((value - arr1[i])))
			return true
		}
		i += 1
	}
	return false
}

func findPairTwoLists3(_ arr1 : inout [Int], _ size1 : Int, _ arr2 : inout [Int], _ size2 : Int, _ value : Int) -> Bool {
	var first : Int = 0
	var second : Int = size2 - 1
	var curr : Int = 0
	arr1 = arr1.sorted(by:<)
	arr2 = arr2.sorted(by:<)
	while (first < size1 && second >= 0) {
		curr = arr1[first] + arr2[second]
		if (curr == value) {
			print("The pair is : " + String(arr1[first]) + " & " + String(arr2[second]))
			return true
		} else if (curr < value) {
			first += 1
		} else {
			second -= 1
		}
	}
	return false
}

func findPairTwoLists4(_ arr1 : inout [Int], _ size1 : Int, _ arr2 : inout [Int], _ size2 : Int, _ value : Int) -> Bool {
	var hs : Set<Int> = Set<Int>()
	var i : Int = 0
	while (i < size2) {
		hs.insert(arr2[i])
		i += 1
	}
	
	i = 0
	while (i < size1) {
		if (hs.contains(value - arr1[i])) {
			print("The pair is : " + String(arr1[i]) + " & " + String((value - arr1[i])))
			return true
		}
		i += 1
	}
	
	return false
}

func findPairTwoLists5(_ arr1 : inout [Int], _ size1 : Int, _ arr2 : inout [Int], _ size2 : Int, _ range : Int, _ value : Int) -> Bool {
	var count : [Int] = Array(repeating: 0, count: range + 1)
	var i : Int = 0
	while (i < size2) {
		count[arr2[i]] = 1
		i += 1
	}
	
	i = 0
	while (i < size1) {
		if (count[value - arr1[i]] != 0) {
			print("The pair is : " + String(arr1[i]) + " & " + String((value - arr1[i])))
			return true
		}
		i += 1
	}
	return false
}

func main10A() {
	var first : [Int] = [1, 5, 4, 3, 2, 7, 8, 9, 6]
	var second : [Int] = [1, 5, 4, 3, 2, 7, 8, 9, 6]
	print(findPairTwoLists( &first,first.count, &second,second.count,8))
	print(findPairTwoLists2( &first,first.count, &second,second.count,8))
	print(findPairTwoLists3( &first,first.count, &second,second.count,8))
	print(findPairTwoLists4( &first,first.count, &second,second.count,8))
	print(findPairTwoLists5( &first,first.count, &second,second.count,9,8))
}
// The pair is : 1 & 7
// true
// The pair is : 1 & 7
// true
// The pair is : 1 & 7
// true
// The pair is : 1 & 7
// true
// The pair is : 1 & 7
// true


func findDifference(_ arr : inout [Int], _ size : Int, _ value : Int) -> Bool {
	var i : Int = 0
	while (i < size) {
		var j : Int = i + 1
		while (j < size) {
			if (abs(arr[i] - arr[j]) == value) {
				print("The pair is : " + String(arr[i]) + " & " + String(arr[j]))
				return true
			}
			j += 1
		}
		i += 1
	}
	return false
}

func findDifference2(_ arr : inout [Int], _ size : Int, _ value : Int) -> Bool {
	var first : Int = 0
	var second : Int = 0
	var diff : Int
	arr = arr.sorted(by: <)
	while (first < size && second < size) {
		diff = abs(arr[first] - arr[second])
		if (diff == value) {
			print("The pair is : " + String(arr[first]) + " & " + String(arr[second]))
			return true
		} else if (diff > value) {
			first += 1
		} else {
			second += 1
		}
	}
	return false
}

func main11() {
	var first : [Int] = [1, 5, 4, 3, 2, 7, 8, 9, 6]
	print(findDifference( &first,first.count,6))
	print(findDifference2( &first,first.count,6))
}
// The pair is:: 1 & 7
// true
// The pair is : 1 & 7
// true

func findMinDiff(_ arr : inout [Int], _ size : Int) -> Int {
	var diff : Int = Int.max
	var i : Int = 0
	while (i < size) {
		var j : Int = i + 1
		while (j < size) {
			let value : Int = abs(arr[i] - arr[j])
			if (diff > value) {
				diff = value
			}
			j += 1
		}
		i += 1
	}
	return diff
}

func findMinDiff2(_ arr : inout [Int], _ size : Int) -> Int {
	arr = arr.sorted(by: <)
	var diff : Int = Int.max
	var i : Int = 0
	while (i < (size - 1)) {
		if ((arr[i + 1] - arr[i]) < diff) {
			diff = arr[i + 1] - arr[i]
		}
		i += 1
	}
	return diff
}

func main12() {
	var second : [Int] = [1, 6, 4, 19, 17, 20]
	print("findMinDiff : " + String(findMinDiff( &second,second.count)))
	print("findMinDiff : " + String(findMinDiff2( &second,second.count)))
}
// findMinDiff : 1
// findMinDiff : 1

func minDiffPair(_ arr1 : inout [Int], _ size1 : Int, _ arr2 : inout [Int], _ size2 : Int) -> Int {
	var diff : Int = Int.max
	var first : Int = 0
	var second : Int = 0
	var i : Int = 0
	while (i < size1) {
		var j : Int = 0
		while (j < size2) {
			let value : Int = abs(arr1[i] - arr2[j])
			if (diff > value) {
				diff = value
				first = arr1[i]
				second = arr2[j]
			}
			j += 1
		}
		i += 1
	}
	print("The pair is : " + String(first) + " & " + String(second))
	print("Minimum difference is :: " + String(diff))
	return diff
}

func minDiffPair2(_ arr1 : inout [Int], _ size1 : Int, _ arr2 : inout [Int], _ size2 : Int) -> Int {
	var minDiff : Int = Int.max
	var i : Int = 0
	var j : Int = 0
	var first : Int = 0
	var second : Int = 0
	var diff : Int
	arr1 = arr1.sorted(by:<)
	arr2 = arr2.sorted(by:<)
	while (i < size1 && j < size2) {
		diff = abs(arr1[i] - arr2[j])
		if (minDiff > diff) {
			minDiff = diff
			first = arr1[i]
			second = arr2[j]
		}

		if (arr1[i] < arr2[j]) {
			i += 1
		} else {
			j += 1
		}
	}
	print("The pair is : " + String(first) + " & " + String(second))
	print("Minimum difference is :: " + String(minDiff))
	return minDiff
}

func main13() {
	var first : [Int] = [1, 5, 4, 3, 2, 7, 8, 9, 6]
	var second : [Int] = [6, 4, 19, 17, 20]
	_ = minDiffPair( &first,first.count, &second,second.count)
	_ = minDiffPair( &first,first.count, &second,second.count)
}
// The pair is : 4 & 4
// Minimum difference is :: 0
// The pair is : 4 & 4
// Minimum difference is :: 0

func closestPair(_ arr : inout [Int], _ size : Int, _ value : Int) {
	var diff : Int = 999999
	var first : Int = -1
	var second : Int = -1
	var curr : Int
	var i : Int = 0
	while (i < size) {
		var j : Int = i + 1
		while (j < size) {
			curr = abs(value - (arr[i] + arr[j]))
			if (curr < diff) {
				diff = curr
				first = arr[i]
				second = arr[j]
			}
			j += 1
		}
		i += 1
	}
	print("closest pair is : " + String(first) + " & " + String(second))
}

func closestPair2(_ arr : inout [Int], _ size : Int, _ value : Int) {
	var first : Int = 0
	var second : Int = 0
	var start : Int = 0
	var stop : Int = size - 1
	var diff : Int
	var curr : Int
	arr = arr.sorted(by: <)
	diff = 9999999
	while (start < stop) {
		curr = (value - (arr[start] + arr[stop]))
		if (abs(curr) < diff) {
			diff = abs(curr)
			first = arr[start]
			second = arr[stop]
		}

		if (curr == 0) {
			break
		} else if (curr > 0) {
			start += 1
		} else {
			stop -= 1
		}
	}
	print("closest pair is : " + String(first) + " & " + String(second))
}

func main14() {
	var first : [Int] = [10, 20, 3, 4, 50, 80]
	closestPair( &first,first.count,47)
	closestPair2( &first,first.count,47)
}
// closest pair is : 3 & 50
// closest pair is : 3 & 50

func sumPairRestArray(_ arr : inout [Int], _ size : Int) -> Bool {
	var total : Int
	var low : Int
	var high : Int
	var curr : Int
	var value : Int
	arr = arr.sorted(by: <)
	total = 0
	var i : Int = 0
	while (i < size) {
		total += arr[i]
		i += 1
	}

	value = total / 2
	low = 0
	high = size - 1
	while (low < high) {
		curr = arr[low] + arr[high]
		if (curr == value) {
			print("Pair is :: " + String(arr[low]) + " " + String(arr[high]))
			return true
		} else if (curr < value) {
			low += 1
		} else {
			high -= 1
		}
	}
	return false
}

func main15() {
	var first : [Int] = [1, 2, 4, 8, 16, 15]
	print(sumPairRestArray( &first,first.count))
}
// Pair is :: 8 15
// true

func zeroSumTriplets(_ arr : inout [Int], _ size : Int) {
	var i : Int = 0
	while (i < (size - 2)) {
		var j : Int = i + 1
		while (j < (size - 1)) {
			var k : Int = j + 1
			while (k < size) {
				if (arr[i] + arr[j] + arr[k] == 0) {
					print("Triplet:: " + String(arr[i]) + " " + String(arr[j]) + " " + String(arr[k]))
				}
				k += 1
			}
			j += 1
		}
		i += 1
	}
}

func zeroSumTriplets2(_ arr : inout [Int], _ size : Int) {
	var start : Int
	var stop : Int
	arr = arr.sorted(by: <)
	var i : Int = 0
	while (i < (size - 2)) {
		start = i + 1
		stop = size - 1
		while (start < stop) {
			if (arr[i] + arr[start] + arr[stop] == 0) {
				print("Triplet :: " + String(arr[i]) + " " + String(arr[start]) + " " + String(arr[stop]))
				start += 1
				stop -= 1
			} else if (arr[i] + arr[start] + arr[stop] > 0) {
				stop -= 1
			} else {
				start += 1
			}
		}
		i += 1
	}
}

func main16() {
	var first : [Int] = [0, -1, 2, -3, 1]
	zeroSumTriplets( &first,first.count)
	zeroSumTriplets2( &first,first.count)
}
// Triplet:: 0 -1 1 
// Triplet:: 2 -3 1 
// Triplet :: -3 1 2 
// Triplet :: -1 0 1

func findTriplet(_ arr : inout [Int], _ size : Int, _ value : Int) {
	var i : Int = 0
	while (i < (size - 2)) {
		var j : Int = i + 1
		while (j < (size - 1)) {
			var k : Int = j + 1
			while (k < size) {
				if ((arr[i] + arr[j] + arr[k]) == value) {
					print("Triplet :: " + String(arr[i]) + " " + String(arr[j]) + " " + String(arr[k]))
				}
				k += 1
			}
			j += 1
		}
		i += 1
	}
}

func findTriplet2(_ arr : inout [Int], _ size : Int, _ value : Int) {
	var start : Int
	var stop : Int
	arr = arr.sorted(by: <)
	var i : Int = 0
	while (i < size - 2) {
		start = i + 1
		stop = size - 1
		while (start < stop) {
			if (arr[i] + arr[start] + arr[stop] == value) {
				print("Triplet ::" + String(arr[i]) + " " + String(arr[start]) + " " + String(arr[stop]))
				start += 1
				stop -= 1
			} else if (arr[i] + arr[start] + arr[stop] > value) {
				stop -= 1
			} else {
				start += 1
			}
		}
		i += 1
	}
}

func main17() {
	var first : [Int] = [1, 5, 15, 6, 9, 8]
	findTriplet( &first,first.count,22)
	findTriplet2( &first,first.count,22)
}
// Triplet :: 1 15 6 
// Triplet :: 5 9 8 
// Triplet ::1 6 15 
// Triplet ::5 8 9

func abcTriplet(_ arr : inout [Int], _ size : Int) {
	var i : Int = 0
	while (i < size - 1) {
		var j : Int = i + 1
		while (j < size) {
			var k : Int = 0
			while (k < size) {
				if (k != i && k != j && arr[i] + arr[j] == arr[k]) {
					print("abcTriplet:: " + String(arr[i]) + " " + String(arr[j]) + " " + String(arr[k]))
				}
				k += 1
			}
			j += 1
		}
		i += 1
	}
}

func abcTriplet2(_ arr : inout [Int], _ size : Int) {
	var start : Int
	var stop : Int
	arr = arr.sorted(by: <)
	var i : Int = 0
	while (i < size) {
		start = 0
		stop = size - 1
		while (start < stop) {
			if (arr[i] == arr[start] + arr[stop]) {
				print("abcTriplet:: " + String(arr[start]) + " " + String(arr[stop]) + " " + String(arr[i]))
				start += 1
				stop -= 1
			} else if (arr[i] < arr[start] + arr[stop]) {
				stop -= 1
			} else {
				start += 1
			}
		}
		i += 1
	}
}

func main18() {
	var first : [Int] = [1, 5, 15, 6, 9, 8]
	abcTriplet( &first,first.count)
	abcTriplet2( &first,first.count)
}
// abcTriplet:: 1 5 6 
// abcTriplet:: 1 8 9 
// abcTriplet:: 6 9 15

func smallerThenTripletCount(_ arr : inout [Int], _ size : Int, _ value : Int) {
	var count : Int = 0
	var i : Int = 0
	while (i < size - 1) {
		var j : Int = i + 1
		while (j < size) {
			var k : Int = j + 1
			while (k < size) {
				if (arr[i] + arr[j] + arr[k] < value) {
					count += 1
				}
				k += 1
			}
			j += 1
		}
		i += 1
	}
	print("smallerThenTripletCount:: " + String(count))
}

func smallerThenTripletCount2(_ arr : inout [Int], _ size : Int, _ value : Int) {
	var start : Int
	var stop : Int
	var count : Int = 0
	arr = arr.sorted(by: <)
	var i : Int = 0
	while (i < (size - 2)) {
		start = i + 1
		stop = size - 1
		while (start < stop) {
			if (arr[i] + arr[start] + arr[stop] >= value) {
				stop -= 1
			} else {
				count += stop - start
				start += 1
			}
		}
		i += 1
	}
	print("smallerThenTripletCount:: " + String(count))
}

func main19() {
	var first : [Int] = [-2, -1, 0, 1]
	smallerThenTripletCount( &first,first.count,2)
	smallerThenTripletCount( &first,first.count,2)
}
/*
smallerThenTripletCount:: 4
smallerThenTripletCount:: 4
*/

func apTriplets(_ arr : inout [Int], _ size : Int) {
	var i : Int = 1, j : Int, k : Int
	while (i < size - 1) {
		j = i - 1
		k = i + 1
		while (j >= 0 && k < size) {
			if (arr[j] + arr[k] == 2 * arr[i]) {
				print("AP Triplet:: " + String(arr[j]) + " " + String(arr[i]) + " " + String(arr[k]))
				k += 1
				j -= 1
			} else if (arr[j] + arr[k] < 2 * arr[i]) {
				k += 1
			} else {
				j -= 1
			}
		}
		i += 1
	}
}

func main20() {
	var arr : [Int] = [2, 4, 10, 12, 14, 18, 36]
	apTriplets( &arr,arr.count)
}
// AP Triplet:: 2 10 18 
// AP Triplet:: 10 12 14 
// AP Triplet:: 10 14 18

func gpTriplets(_ arr : inout [Int], _ size : Int) {
	var i : Int = 1, j : Int, k : Int
	while (i < size - 1) {
		j = i - 1
		k = i + 1
		while (j >= 0 && k < size) {
			if (arr[j] * arr[k] == arr[i] * arr[i]) {
				print("GP Triplet:: " + String(arr[j]) + " " + String(arr[i]) + " " + String(arr[k]))
				k += 1
				j -= 1
			} else if (arr[j] + arr[k] < 2 * arr[i]) {
				k += 1
			} else {
				j -= 1
			}
		}
		i += 1
	}
}

func main21() {
	var arr : [Int] = [1, 2, 4, 8, 16]
	gpTriplets( &arr,arr.count)
}
// GP Triplet:: 1 2 4 
// GP Triplet:: 2 4 8 
// GP Triplet:: 1 4 16 
// GP Triplet:: 4 8 16

func numberOfTriangles(_ arr : inout [Int], _ size : Int) -> Int {
	var i : Int = 0, j : Int, k : Int
	var count : Int = 0
	while (i < (size - 2)) {
		j = i + 1
		while (j < (size - 1)) {
			k = j + 1
			while (k < size) {
				if (arr[i] + arr[j] > arr[k]) {
					count += 1
				}
				k += 1
			}
			j += 1
		}
		i += 1
	}
	return count
}

func numberOfTriangles2(_ arr : inout [Int], _ size : Int) -> Int {
	var i : Int = 0, j : Int, k : Int
	var count : Int = 0
	arr = arr.sorted(by: <)
	while (i < (size - 2)) {
		k = i + 2
		j = i + 1
		while (j < (size - 1)) {
			// if sum of arr[i] & arr[j] is greater arr[k] then sum of arr[i] & arr[j + 1]
			// is also greater than arr[k] this improvement make algo O(n2)
			while (k < size && arr[i] + arr[j] > arr[k]) {
				k += 1
			}
			count += k - j - 1
			j += 1
		}
		i += 1
	}
	return count
}

func main22() {
var arr : [Int] = [1, 2, 3, 4, 5]
print(numberOfTriangles( &arr,arr.count))
	print(numberOfTriangles2( &arr,arr.count))
}
// 3 
// 3

func getMax(_ arr : inout [Int], _ size : Int) -> Int {
	var mx : Int = arr[0], count : Int = 1, maxCount : Int = 1
	var i : Int = 0
	while (i < size) {
		count = 1
		var j : Int = i + 1
		while (j < size) {
			if (arr[i] == arr[j]) {
				count += 1
			}
			j += 1
		}
		
		if (count > maxCount) {
			mx = arr[i]
			maxCount = count
		}
		i += 1
	}
	return mx
}

func getMax2(_ arr : inout [Int], _ size : Int) -> Int {
	var mx : Int = arr[0], maxCount : Int = 1
	var curr : Int = arr[0], currCount : Int = 1
	arr = arr.sorted(by: <)
	var i : Int = 1
	while (i < size) {
		if (arr[i] == arr[i - 1]) {
			currCount += 1
		} else {
			currCount = 1
			curr = arr[i]
		}

		if (currCount > maxCount) {
			maxCount = currCount
			mx = curr
		}
		i += 1
	}
	return mx
}

func getMax3(_ arr : inout [Int], _ size : Int, _ range : Int) -> Int {
	var mx : Int = arr[0], maxCount : Int = 1
	var count : [Int] = Array(repeating: 0, count: range)
	var i : Int = 0
	while (i < size) {
		count[arr[i]] += 1
		if (count[arr[i]] > maxCount) {
			maxCount = count[arr[i]]
			mx = arr[i]
		}
		i += 1
	}
	return mx
}

func main23() {
var first : [Int] = [1, 30, 5, 13, 9, 31, 5]
print(getMax( &first,first.count))
	print(getMax2( &first,first.count))
	print(getMax3( &first,first.count,50))
}
// 5 
// 5 
// 5

func getMajority(_ arr : inout [Int], _ size : Int) -> Int {
	var mx : Int = 0, count : Int = 0, maxCount : Int = 0
	var i : Int = 0
	while (i < size) {
		var j : Int = i + 1
		while (j < size) {
			if (arr[i] == arr[j]) {
				count += 1
			}
			j += 1
		}
		
		if (count > maxCount) {
			mx = arr[i]
			maxCount = count
		}
		i += 1
	}
	
	if (maxCount > size / 2) {
		return mx
	} else {
		return 0
	}
}

func getMajority2(_ arr : inout [Int], _ size : Int) -> Int {
	let majIndex : Int = size / 2
	var candidate : Int, count : Int = 0
	arr = arr.sorted(by: <)
	candidate = arr[majIndex]
	var i : Int = 0
	while (i < size) {
		if (arr[i] == candidate) {
			count += 1
		}
		i += 1
	}
	
	if (count > size / 2) {
		return arr[majIndex]
	} else {
		return Int.min
	}
}

func getMajority3(_ arr : inout [Int], _ size : Int) -> Int {
	var majIndex : Int = 0, count : Int = 1, candidate : Int
	var i : Int = 1
	while (i < size) {
		if (arr[majIndex] == arr[i]) {
			count += 1
		} else {
			count -= 1
		}

		if (count == 0) {
			majIndex = i
			count = 1
		}
		i += 1
	}
	
	candidate = arr[majIndex]
	count = 0
	i = 0
	while (i < size) {
		if (arr[i] == candidate) {
			count += 1
		}
		i += 1
	}
	
	if (count > size / 2) {
		return arr[majIndex]
	} else {
		return 0
	}
}

func main24() {
var first : [Int] = [1, 5, 5, 13, 5, 31, 5]
print(getMajority( &first,first.count))
	print(getMajority2( &first,first.count))
	print(getMajority3( &first,first.count))
}
// 5 
// 5 
// 5

func getMedian(_ arr : inout [Int], _ size : Int) -> Int {
	arr = arr.sorted(by: <)
	return arr[size / 2]
}

func getMedian2(_ arr : inout [Int], _ size : Int) -> Int {
	quickSelectUtil( &arr,0,size - 1,size / 2)
	return arr[size / 2]
}

func main25() {
var first : [Int] = [1, 5, 6, 6, 6, 6, 6, 6, 7, 8, 10, 13, 20, 30]
print(getMedian( &first,first.count))
	print(getMedian( &first,first.count))
}
// 6

func searchBitonicArrayMax(_ arr : inout [Int], _ size : Int) -> Int {
	var i : Int = 0
	while (i < size - 2) {
		if (arr[i] > arr[i + 1]) {
			return arr[i]
		}
		i += 1
	}
	print("error not a bitonic array")
	return 0
}

func searchBitonicArrayMax2(_ arr : inout [Int], _ size : Int) -> Int {
	var start : Int = 0, end : Int = size - 1
	var mid : Int = (start + end) / 2
	var maximaFound : Int = 0
	if (size < 3) {
		print("error")
		return 0
	}

	while (start <= end) {
		mid = (start + end) / 2
		if (arr[mid - 1] < arr[mid] && arr[mid + 1] < arr[mid]) { // maxima
			maximaFound = 1
			break
		} else if (arr[mid - 1] < arr[mid] && arr[mid] < arr[mid + 1]) { // increasing
			start = mid + 1
		} else if (arr[mid - 1] > arr[mid] && arr[mid] > arr[mid + 1]) { // decreasing
			end = mid - 1
		} else {
			break
		}
	}

	if (maximaFound == 0) {
		print("error not a bitonic array")
		return 0
	}
	return arr[mid]
}

func searchBitonicArray(_ arr : inout [Int], _ size : Int, _ key : Int) -> Int {
	let max : Int = findMaxBitonicArray( &arr,size)
	let k : Int = binarySearch( &arr,0,max,key,true)
	if (k != -1) {
		return k
	} else {
		return binarySearch( &arr,max + 1,size - 1,key,false)
	}
}

func findMaxBitonicArray(_ arr : inout [Int], _ size : Int) -> Int {
	var start : Int = 0, end : Int = size - 1, mid : Int
	if (size < 3) {
		print("error")
		return -1
	}

	while (start <= end) {
		mid = (start + end) / 2
		if (arr[mid - 1] < arr[mid] && arr[mid + 1] < arr[mid]) { // maxima
			return mid
		} else if (arr[mid - 1] < arr[mid] && arr[mid] < arr[mid + 1]) { // increasing
			start = mid + 1
		} else if (arr[mid - 1] > arr[mid] && arr[mid] > arr[mid + 1]) { // decreasing
			end = mid - 1
		} else {
			break
		}
	}
	print("error")
	return -1
}

func main26() {
var first : [Int] = [1, 5, 10, 13, 20, 30, 8, 7, 6]
print(searchBitonicArrayMax( &first,first.count))
	print(searchBitonicArrayMax2( &first,first.count))
print(searchBitonicArray( &first,first.count,7))
}
// 30
// 30
// 7

func findKeyCount(_ arr : inout [Int], _ size : Int, _ key : Int) -> Int {
	var count : Int = 0, i : Int = 0
	while (i < size) {
		if (arr[i] == key) {
			count += 1
		}
		i += 1
	}
	return count
}

func findFirstIndex(_ arr : inout [Int], _ start : Int, _ end : Int, _ key : Int) -> Int {
	if (end < start) {
		return -1
	}

	let mid : Int = (start + end) / 2
	if (key == arr[mid] && (mid == start || arr[mid - 1] != key)) {
		return mid
	}

	if (key <= arr[mid]) {
		return findFirstIndex( &arr,start,mid - 1,key)
	} else {
		return findFirstIndex( &arr,mid + 1,end,key)
	}
}

func findLastIndex(_ arr : inout [Int], _ start : Int, _ end : Int, _ key : Int) -> Int {
	if (end < start) {
		return -1
	}

	let mid : Int = (start + end) / 2
	if (key == arr[mid] && (mid == end || arr[mid + 1] != key)) {
		return mid
	}

	if (key < arr[mid]) {
		return findLastIndex( &arr,start,mid - 1,key)
	} else {
		return findLastIndex( &arr,mid + 1,end,key)
	}
}

func findKeyCount2(_ arr : inout [Int], _ size : Int, _ key : Int) -> Int {
	let firstIndex : Int = findFirstIndex( &arr,0,size - 1,key)
	let lastIndex : Int = findLastIndex( &arr,0,size - 1,key)
	return (lastIndex - firstIndex + 1)
}

func main27() {
var first : [Int] = [1, 5, 10, 13, 20, 30, 8, 7, 6]
print(findKeyCount( &first,first.count,6))
	print(findKeyCount2( &first,first.count,6))
}
// 1 
// 1

// Using binary search method.
func firstIndex(_ arr : inout [Int], _ size : Int, _ low : Int, _ high : Int, _ value : Int) -> Int {
	var mid : Int = 0
	if (high >= low) {
		mid = (low + high) / 2
	}
	// Find first occurrence of value, either it should be the first element of the
	// array or the value before it is smaller than it.
	if ((mid == 0 || arr[mid - 1] < value) && (arr[mid] == value)) {
		return mid
	} else if (arr[mid] < value) {
		return firstIndex( &arr,size,mid + 1,high,value)
	} else {
		return firstIndex( &arr,size,low,mid - 1,value)
	}
}

func isMajority2(_ arr : inout [Int], _ size : Int) -> Bool {
	let majority : Int = arr[size / 2]
	let i : Int = firstIndex( &arr,size,0,size - 1,majority)
	// we are using majority element form array so we will get some 
	// valid index always.
	if (((i + size / 2) <= (size - 1)) && arr[i + size / 2] == majority) {
		return true
	} else {
		return false
	}
}

func isMajority(_ arr : inout [Int], _ size : Int) -> Bool {
	var count : Int = 0
	let mid : Int = arr[size / 2]
	var i : Int = 0
	while (i < size) {
		if (arr[i] == mid) {
			count += 1
		}
		i += 1
	}
	
	if (count > size / 2) {
		return true
	}
	return false
}

func main28() {
var arr : [Int] = [3, 3, 3, 3, 4, 5, 10]
print(isMajority( &arr,arr.count))
	print(isMajority2( &arr,arr.count))
}
// true

func maxProfit(_ stocks : inout [Int], _ size : Int) -> Int {
	var maxProfit : Int = 0, buy : Int = 0, sell : Int = 0
	var i : Int = 0
	while (i < size - 1) {
		var j : Int = i + 1
		while (j < size) {
			if (maxProfit < stocks[j] - stocks[i]) {
				maxProfit = stocks[j] - stocks[i]
				buy = i
				sell = j
			}
			j += 1
		}
		i += 1
	}
	
	print("Purchase day is " + String(buy) + " at price " + String(stocks[buy]))
	print("Sell day is " + String(sell) + " at price " + String(stocks[sell]))
	return maxProfit
}

func maxProfit2(_ stocks : inout [Int], _ size : Int) -> Int {
	var buy : Int = 0, sell : Int = 0, curMin : Int = 0
	var currProfit : Int = 0, maxProfit : Int = 0
	var i : Int = 0
	while (i < size) {
		if (stocks[i] < stocks[curMin]) {
			curMin = i
		}
		currProfit = stocks[i] - stocks[curMin]
		if (currProfit > maxProfit) {
			buy = curMin
			sell = i
			maxProfit = currProfit
		}
		i += 1
	}

	print("Purchase day is " + String(buy) + " at price " + String(stocks[buy]))
	print("Sell day is " + String(sell) + " at price " + String(stocks[sell]))
	return maxProfit
}

func main29() {
var first : [Int] = [10, 150, 6, 67, 61, 16, 86, 6, 67, 78, 150, 3, 28, 143]
print(maxProfit( &first,first.count))
	print(maxProfit2( &first,first.count))
}
// Purchase day is- 2 at price 6 
// Sell day is- 10 at price 150 
// 144

func findMedian(_ arrFirst : inout [Int], _ sizeFirst : Int, _ arrSecond : inout [Int], _ sizeSecond : Int) -> Int {
	let medianIndex : Int = ((sizeFirst + sizeSecond) + (sizeFirst + sizeSecond) % 2) / 2 // ceiling function.
	var i : Int = 0, j : Int = 0
	var count : Int = 0
	while (count < medianIndex - 1) {
		if (i < sizeFirst - 1 && arrFirst[i] < arrSecond[j]) {
			i += 1
		} else {
			j += 1
		}
		count += 1
	}

	if (arrFirst[i] < arrSecond[j]) {
		return arrFirst[i]
	} else {
		return arrSecond[j]
	}
}

func main30() {
var first : [Int] = [1, 5, 6, 6, 6, 6, 6, 6, 7, 8, 10, 13, 20, 30]
var second : [Int] = [1, 5, 6, 6, 6, 6, 6, 6, 7, 8, 10, 13, 20, 30]
print(findMedian( &first,first.count, &second,second.count))
}
// 6

func search01(_ arr : inout [Int], _ size : Int) -> Int {
	var i : Int = 0
	while (i < size) {
		if (arr[i] == 1) {
			return i
		}
		i += 1
	}
	return -1
}

func binarySearch01(_ arr : inout [Int], _ size : Int) -> Int {
	if (size == 1 && arr[0] == 1) {
		return 0
	}
	return binarySearch01Util( &arr,0,size - 1)
}

func binarySearch01Util(_ arr : inout [Int], _ start : Int, _ end : Int) -> Int {
	if (end < start) {
		return -1
	}
	let mid : Int = (start + end) / 2
	if (1 == arr[mid] && 0 == arr[mid - 1]) {
		return mid
	}

	if (0 == arr[mid]) {
		return binarySearch01Util( &arr,mid + 1,end)
	} else {
		return binarySearch01Util( &arr,start,mid - 1)
	}
}

func main31() {
var first : [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1]
print(search01( &first,first.count))
	print(binarySearch01( &first,first.count))
}
// 8

func rotationMax(_ arr : inout [Int], _ size : Int) -> Int {
	var i : Int = 0
	while (i < size - 1) {
		if (arr[i] > arr[i + 1]) {
			return arr[i]
		}
		i += 1
	}
	return -1
}

func rotationMaxUtil(_ arr : inout [Int], _ start : Int, _ end : Int) -> Int {
	if (end <= start) {
		return arr[start]
	}

	let mid : Int = (start + end) / 2
	if (arr[mid] > arr[mid + 1]) {
		return arr[mid]
	}

	if (arr[start] <= arr[mid]) { // increasing part.
		return rotationMaxUtil( &arr,mid + 1,end)
	} else {
		return rotationMaxUtil( &arr,start,mid - 1)
	}
}

func rotationMax2(_ arr : inout [Int], _ size : Int) -> Int {
	return rotationMaxUtil( &arr,0,size - 1)
}

func main32() {
var first : [Int] = [34, 56, 77, 1, 5, 6, 6, 8, 10, 20, 30, 34]
print(rotationMax( &first,first.count))
	print(rotationMax2( &first,first.count))
}
// 77
// 77

func findRotationMax(_ arr : inout [Int], _ size : Int) -> Int {
	var i : Int = 0
	while (i < size - 1) {
		if (arr[i] > arr[i + 1]) {
			return i
		}
		i += 1
	}
	return -1
}

func findRotationMaxUtil(_ arr : inout [Int], _ start : Int, _ end : Int) -> Int {
	// single element case.
	if (end <= start) {
		return start
	}
	let mid : Int = (start + end) / 2
	if (arr[mid] > arr[mid + 1]) {
		return mid
	}

	if (arr[start] <= arr[mid]) { // increasing part.
		return findRotationMaxUtil( &arr,mid + 1,end)
	} else {
		return findRotationMaxUtil( &arr,start,mid - 1)
	}
}

func findRotationMax2(_ arr : inout [Int], _ size : Int) -> Int {
	return findRotationMaxUtil( &arr,0,size - 1)
}

func main33() {
	var first : [Int] = [34, 56, 77, 1, 5, 6, 6, 8, 10, 20, 30, 34]
	print(findRotationMax( &first,first.count))
	print(findRotationMax2( &first,first.count))
}
// 2

func countRotation(_ arr : inout [Int], _ size : Int) -> Int {
	let maxIndex : Int = findRotationMaxUtil( &arr,0,size - 1)
	return (maxIndex + 1) % size
}

func main34() {
var first : [Int] = [34, 56, 77, 1, 5, 6, 6, 8, 10, 20, 30, 34]
print(countRotation( &first,first.count))
}
// 3

func searchRotateArray(_ arr : inout [Int], _ size : Int, _ key : Int) -> Int {
	var i : Int = 0
	while (i < size - 1) {
		if (arr[i] == key) {
			return i
		}
		i += 1
	}
	return -1
}

func binarySearchRotateArrayUtil(_ arr : inout [Int], _ start : Int, _ end : Int, _ key : Int) -> Int {
	if (end < start) {
		return -1
	}
	let mid : Int = (start + end) / 2
	if (key == arr[mid]) {
		return mid
	}

	if (arr[mid] > arr[start]) {
		if (arr[start] <= key && key < arr[mid]) {
			return binarySearchRotateArrayUtil( &arr,start,mid - 1,key)
		} else {
			return binarySearchRotateArrayUtil( &arr,mid + 1,end,key)
		}
	} else {
		if (arr[mid] < key && key <= arr[end]) {
			return binarySearchRotateArrayUtil( &arr,mid + 1,end,key)
		} else {
			return binarySearchRotateArrayUtil( &arr,start,mid - 1,key)
		}
	}
}

func binarySearchRotateArray(_ arr : inout [Int], _ size : Int, _ key : Int) -> Int {
	return binarySearchRotateArrayUtil( &arr,0,size - 1,key)
}

func main35() {
var first : [Int] = [34, 56, 77, 1, 5, 6, 6, 6, 6, 6, 6, 7, 8, 10, 13, 20, 30]
print(searchRotateArray( &first,first.count,20))
	print(binarySearchRotateArray( &first,first.count,20))
	print(countRotation( &first,first.count))
	print(first[findRotationMax( &first,first.count)])
}
// 15 
// 3 
// 7
// 7

func minAbsDiffAdjCircular(_ arr : inout [Int], _ size : Int) -> Int {
	var diff : Int = 9999999
	if (size < 2) {
		return -1
	}
	var i : Int = 0
	while (i < size) {
		diff = min(diff,abs(arr[i] - arr[(i + 1) % size]))
		i += 1
	}
	return diff
}

// Testing code
func main36() {
var arr : [Int] = [5, 29, 18, 51, 11]
print(minAbsDiffAdjCircular( &arr,arr.count))
}
// 6

func transformArrayAB1(_ str : String, _ size : Int) -> String {
	var arr : [Character] = Array(str)
	let N : Int = size / 2
	var i : Int = 1, j : Int
	while (i < N) {
		j = 0
		while (j < i) {
			arr.swapAt(N - i + 2 * j, N - i + 2 * j + 1)
			j += 1
		}
		i += 1
	}
	return String(arr)
}

// Testing code
func main37() {
var str : String = "aaaabbbb"
str = transformArrayAB1( str,str.count)
print(str)
}
// abababab

func quickSelectUtil(_ arr : inout [Int], _ start : Int, _ stop : Int, _ key : Int) {
	if stop <= start {
		return
	}
	let pivot = arr[start]
	var lower = start
	var upper = stop

	while lower <= upper {
		if(arr[lower] > pivot) {
			arr.swapAt(upper, lower)
			upper -= 1
		} else {
			lower += 1
		}
	}
	arr.swapAt(upper, start) // upper is the pivot position
	if(upper > key) {
		quickSelectUtil(&arr, start, upper-1, key) // pivot -1 is the upper for left sub array.
	} else {
		quickSelectUtil(&arr, upper+1, stop, key)  // pivot + 1 is the lower for right sub array.
	}
}


func checkPermutation(_ array1 : inout [Character], _ size1 : Int, _ array2 : inout [Character], _ size2 : Int) -> Bool {
	if (size1 != size2) {
		return false
	}
	array1 = array1.sorted(by:<)
	array2 = array2.sorted(by:<)
	var i : Int = 0
	while (i < size1) {
		if (array1[i] != array2[i]) {
			return false
		}
		i += 1
	}
	return true
}

func checkPermutation2(_ arr1 : inout [Character], _ size1 : Int, _ arr2 : inout [Character], _ size2 : Int) -> Bool {
	if (size1 != size2) {
		return false
	}
	var hm :  [Character:Int] =  [Character:Int]()
	var i : Int = 0
	while (i < size1) {
		if (hm.keys.contains(arr1[i])) {
			hm[arr1[i]] = hm[arr1[i]]! + 1
		} else {
			hm[arr1[i]] = 1
		}
		i += 1
	}
	i = 0
	while (i < size2) {
		if (hm.keys.contains(arr2[i]) && !(hm[arr2[i]]! == 0)) {
			hm[arr2[i]] = hm[arr2[i]]! - 1
		} else {
			return false
		}
		i += 1
	}
	return true
}

func checkPermutation3(_ array1 : inout [Character], _ size1 : Int, _ array2 : inout [Character], _ size2 : Int) -> Bool {
	if (size1 != size2) {
		return false
	}

	var count : [Int] = Array(repeating: 0, count: 256)
	var i : Int = 0
	while (i < size1) {
		count[Int(UnicodeScalar(String(array1[i]))!.value)] += 1
		count[Int(UnicodeScalar(String(array2[i]))!.value)] -= 1
		i += 1
	}

	i = 0
	while (i < size1) {
		if (count[i] != 0) {
			return false
		}
		i += 1
	}
	return true
}

// Testing code
func main38() {
var str1 : [Character] = [Character] ()
var str2 : [Character] = [Character] ()
print(checkPermutation( &str1,str1.count, &str2,str2.count))
	print(checkPermutation2( &str1,str1.count, &str2,str2.count))
	print(checkPermutation3( &str1,str1.count, &str2,str2.count))
}
// true
// true
// true

func findElementIn2DArray(_ arr : inout [[Int]], _ r : Int, _ c : Int, _ value : Int) -> Bool {
	var row : Int = 0
	var column : Int = c - 1
	while (row < r && column >= 0) {
		if (arr[row][column] == value) {
			return true
		} else if (arr[row][column] > value) {
			column -= 1
		} else {
			row += 1
		}
	}
	return false
}

func isAP(_ arr : inout [Int], _ size : Int) -> Bool {
	if (size <= 1) {
		return true
	}

	arr = arr.sorted(by: <)
	let diff : Int = arr[1] - arr[0]
	var i : Int = 2
	while (i < size) {
		if (arr[i] - arr[i - 1] != diff) {
			return false
		}
		i += 1
	}
	return true
}

func isAP2(_ arr : inout [Int], _ size : Int) -> Bool {
	var first : Int = 9999999
	var second : Int = 9999999
	var value : Int
	var hs : Set<Int> = Set<Int>()
	var i : Int = 0
	while (i < size) {
		if (arr[i] < first) {
			second = first
			first = arr[i]
		} else if (arr[i] < second) {
			second = arr[i]
		}
		i += 1
	}

	let diff : Int = second - first
	i = 0
	while (i < size) {
		if (hs.contains(arr[i])) {
			return false
		}
		hs.insert(arr[i])
		i += 1
	}
	
	i = 0
	while (i < size) {
		value = first + i * diff
		if (!hs.contains(value)) {
			return false
		}
		i += 1
	}
	
	return true
}

func isAP3(_ arr : inout [Int], _ size : Int) -> Bool {
	var first : Int = 9999999
	var second : Int = 9999999
	var count : [Int] = Array(repeating: 0, count: size)
	var index : Int = -1
	var i : Int = 0
	while (i < size) {
		if (arr[i] < first) {
			second = first
			first = arr[i]
		} else if (arr[i] < second) {
			second = arr[i]
		}
		i += 1
	}
	
	let diff : Int = second - first
	i = 0
	while (i < size) {
		index = (arr[i] - first) / diff
		if (index > size - 1 || count[index] != 0) {
			return false
		}
		count[index] = 1
		i += 1
	}
	
	i = 0
	while (i < size) {
		if (count[i] != 1) {
			return false
		}
		i += 1
	}
	
	return true
}

// Testing code
func main39() {
var arr : [Int] = [20, 25, 15, 5, 0, 10, 35, 30]
print(isAP( &arr,arr.count))
	print(isAP2( &arr,arr.count))
	print(isAP3( &arr,arr.count))
}
// true 
// true 
// true

func findBalancedPoint(_ arr : inout [Int], _ size : Int) -> Int {
	var first : Int = 0
	var second : Int = 0
	var i : Int = 1
	while (i < size) {
		second += arr[i]
		i += 1
	}
	
	i = 0
	while (i < size) {
		if (first == second) {
			return i
		}
		if (i < size - 1) {
			first += arr[i]
			second -= arr[i + 1]
		}
		i += 1
	}
	
	return -1
}

// Testing code
func main40() {
var arr : [Int] = [-7, 1, 5, 2, -4, 3, 0]
print(findBalancedPoint( &arr,arr.count))
}
// 3

func findFloor(_ arr : inout [Int], _ size : Int, _ value : Int) -> Int {
	var start : Int = 0
	var stop : Int = size - 1
	var mid : Int
	while (start <= stop) {
		mid = (start + stop) / 2
		// search value is equal to arr[mid] value.. search value is greater than mid
		// index value and less than mid+1 index value. value is greater than
		// arr[size-1] then floor is arr[size-1]
		if (arr[mid] == value || (arr[mid] < value && (mid == size - 1 || arr[mid + 1] > value))) {
			return arr[mid]
		} else if (arr[mid] < value) {
			start = mid + 1
		} else {
			stop = mid - 1
		}
	}
	return -1
}

func findCeil(_ arr : inout [Int], _ size : Int, _ value : Int) -> Int {
	var start : Int = 0
	var stop : Int = size - 1
	var mid : Int
	while (start <= stop) {
		mid = (start + stop) / 2
		// search value is equal to arr[mid] value.. search value is less than mid index
		// value and greater than mid-1 index value. value is less than arr[0] then ceil
		// is arr[0]
		if (arr[mid] == value || (arr[mid] > value && (mid == 0 || arr[mid - 1] < value))) {
			return arr[mid]
		} else if (arr[mid] < value) {
			start = mid + 1
		} else {
			stop = mid - 1
		}
	}
	return -1
}

// Testing code
func main41() {
	var arr : [Int] = [2, 4, 8, 16]
	print("Floor :  " + String(findFloor( &arr,arr.count,5)))
	print("Ceil :  " + String(findCeil( &arr,arr.count,5)))
}
// Floor :  4
// Ceil :  8

func closestNumber(_ arr : inout [Int], _ size : Int, _ num : Int) -> Int {
	var start : Int = 0
	var stop : Int = size - 1
	var output : Int = -1
	var minDist : Int = Int.max
	var mid : Int
	while (start <= stop) {
		mid = (start + stop) / 2
		if (minDist > abs(arr[mid] - num)) {
			minDist = abs(arr[mid] - num)
			output = arr[mid]
		}

		if (arr[mid] == num) {
			break
		} else if (arr[mid] > num) {
			stop = mid - 1
		} else {
			start = mid + 1
		}
	}
	return output
}

// Testing code
func main42() {
var arr : [Int] = [2, 4, 8, 16]
print(closestNumber( &arr,arr.count,9))
}
// 8

func duplicateKDistance(_ arr : inout [Int], _ size : Int, _ k : Int) -> Bool {
	var hm :  [Int:Int] =  [Int:Int]()
	var i : Int = 0
	while (i < size) {
		if (hm.keys.contains(arr[i]) && i - hm[arr[i]]! <= k) {
			print("Value:" + String(arr[i]) + " Index: " + String(hm[arr[i]]!) + " & " + String(i))
			return true
		} else {
			hm[arr[i]] = i
		}
		i += 1
	}
	return false
}

// Testing code
func main43() {
	var arr : [Int] = [1, 2, 3, 1, 4, 5]
	_ = duplicateKDistance( &arr,arr.count,3)
}
// Value:1 Index: 0 & 3

func frequencyCounts(_ arr : inout [Int], _ size : Int) {
	var hm :  [Int:Int] =  [Int:Int]()
	var i : Int = 0
	while (i < size) {
		if (hm.keys.contains(arr[i])) {
			hm[arr[i]] = hm[arr[i]]! + 1
		} else {
			hm[arr[i]] = 1
		}
		i += 1
	}
	
	for key in Array(hm.keys) {
		print("(" + String(key) + " : " + String(hm[key]!) + ") ",terminator: "")
	}
	print()
}

func frequencyCounts2(_ arr : inout [Int], _ size : Int) {
	arr = arr.sorted(by: <)
	var count : Int = 1
	var i : Int = 1
	while (i < size) {
		if (arr[i] == arr[i - 1]) {
			count += 1
		} else {
			print("(" + String(arr[i - 1]) + " : " + String(count) + ") ",terminator: "")
			count = 1
		}
		i += 1
	}
	
	print("(" + String(arr[size - 1]) + " : " + String(count) + ") ",terminator: "")
	print()
}

func frequencyCounts3(_ arr : inout [Int], _ size : Int) {
	var aux : [Int] = Array(repeating: 0, count: size + 1)
	var i : Int = 0
	while (i < size) {
		aux[arr[i]] += 1
		i += 1
	}
	
	i = 0
	while (i < size + 1) {
		if (aux[i] > 0) {
			print("(" + String(i) + " : " + String(aux[i]) + ") ",terminator: "")
		}
		i += 1
	}
	print()
}

func frequencyCounts4(_ arr : inout [Int], _ size : Int) {
	var index : Int
	var i : Int = 0
	while (i < size) {
		while (arr[i] > 0) {
			index = arr[i] - 1
			if (arr[index] > 0) {
				arr[i] = arr[index]
				arr[index] = -1
			} else {
				arr[index] -= 1
				arr[i] = 0
			}
		}
		i += 1
	}
	
	i = 0
	while (i < size) {
		if (arr[i] != 0) {
			print("(" + String((i + 1)) + " : " + String(abs(arr[i])) + ") ",terminator: "")
		}
		i += 1
	}
	print()
}

// Testing code
func main44() {
var arr : [Int] = [1, 2, 2, 2, 1]
frequencyCounts( &arr,arr.count)
	frequencyCounts2( &arr,arr.count)
	frequencyCounts3( &arr,arr.count)
	frequencyCounts4( &arr,arr.count)
}
// (1 : 2) (2 : 3) 
// (1 : 2) (2 : 3) 
// (1 : 2) (2 : 3) 
// (1 : 2) (2 : 3)

func kLargestElements(_ arrIn : inout [Int], _ size : Int, _ k : Int) {
	var arr : [Int] = Array(repeating: 0, count: size)
	var i : Int = 0
	while (i < size) {
		arr[i] = arrIn[i]
		i += 1
	}
	
	arr = arr.sorted(by: <)
	i = 0
	while (i < size) {
		if (arrIn[i] >= arr[size - k]) {
			print(String(arrIn[i]) + " ",terminator: "")
		}
		i += 1
	}	
	print()
}

func kLargestElements2(_ arrIn : inout [Int], _ size : Int, _ k : Int) {
	var arr : [Int] = Array(repeating: 0, count: size)
	var i : Int = 0
	while (i < size) {
		arr[i] = arrIn[i]
		i += 1
	}
	
	quickSelectUtil( &arr,0,size - 1,size - k)
	i = 0
	while (i < size) {
		if (arrIn[i] >= arr[size - k]) {
			print(String(arrIn[i]) + " ",terminator: "")
		}
		i += 1
	}
	
	print()
}

// Testing code
func main45() {
var arr : [Int] = [10, 50, 30, 60, 15]
kLargestElements( &arr,arr.count,2)
	kLargestElements2( &arr,arr.count,2)
}
// 50 60 
// 50 60

// linear search method
func fixPoint(_ arr : inout [Int], _ size : Int) -> Int {
	var i : Int = 0
	while (i < size) {
		if (arr[i] == i) {
			return i
		}
		i += 1
	}
	// fix point not found so return invalid index
	return -1
}

// Binary search method
func fixPoint2(_ arr : inout [Int], _ size : Int) -> Int {
	var low : Int = 0
	var high : Int = size - 1
	var mid : Int
	while (low <= high) {
		mid = (low + high) / 2
		if (arr[mid] == mid) {
			return mid
		} else if (arr[mid] < mid) {
			low = mid + 1
		} else {
			high = mid - 1
		}
	}
	// fix point not found so return invalid index
	return -1
}

// Testing code
func main46() {
var arr : [Int] = [-10, -2, 0, 3, 11, 12, 35, 51, 200]
print(fixPoint( &arr,arr.count))
	print(fixPoint2( &arr,arr.count))
}
// 3 
// 3

func subArraySums(_ arr : inout [Int], _ size : Int, _ value : Int) {
	var start : Int = 0, end : Int = 0,sum : Int = 0
	while (start < size && end < size) {
		if (sum < value) {
			sum += arr[end]
			end += 1
		} else {
			sum -= arr[start]
			start += 1
		}

		if (sum == value) {
			print("(" + String(start) + " to " + String((end - 1)) + ") ",terminator: "")
		}
	}
}

// Testing code
func main47() {
var arr : [Int] = [15, 5, 5, 20, 10, 5, 5, 20, 10, 10]
subArraySums( &arr,arr.count,20)
	print()
}
// (0 to 1) (3 to 3) (4 to 6) (7 to 7) (8 to 9)

func maxConSub(_ arr : inout [Int], _ size : Int) -> Int {
	var currMax : Int = 0
	var maximum : Int = 0
	var i : Int = 0
	while (i < size) {
		currMax += arr[i]
		if (currMax < 0) {
			currMax = 0
		}
		if (maximum < currMax) {
			maximum = currMax
		}
		i += 1
	}	
	print(maximum)
	return maximum
}

func maxConSubArr(_ A : inout [Int], _ sizeA : Int, _ B : inout [Int], _ sizeB : Int) -> Int {
	var currMax : Int = 0
	var maximum : Int = 0
	var hs : Set<Int> = Set<Int>()
	var i : Int = 0
	while (i < sizeB) {
		hs.insert(B[i])
		i += 1
	}
	
	i = 0
	while (i < sizeA) {
		if (hs.contains(A[i])) {
			currMax = 0
		} else {
			currMax = currMax + A[i]
			if (currMax < 0) {
				currMax = 0
			}
			if (maximum < currMax) {
				maximum = currMax
			}
		}
		i += 1
	}
	
	print(maximum)
	return maximum
}

func maxConSubArr2(_ A : inout [Int], _ sizeA : Int, _ B : inout [Int], _ sizeB : Int) -> Int {
	B = B.sorted(by: <)
	var currMax : Int = 0
	var maximum : Int = 0
	var i : Int = 0
	while (i < sizeA) {
		if (binarySearch( &B,sizeB,A[i])) {
			currMax = 0
		} else {
			currMax = currMax + A[i]
			if (currMax < 0) {
				currMax = 0
			}
			if (maximum < currMax) {
				maximum = currMax
			}
		}
		i += 1
	}
	
	print(maximum)
	return maximum
}

// Testing code
func main48() {
var arr : [Int] = [1, 2, -3, 4, 5, -10, 6, 7]
_ = maxConSub( &arr,arr.count)
var arr2 : [Int] = [1, 2, 3, 4, 5, -10, 6, 7, 3]
var arr3 : [Int] = [1, 3]
_ = maxConSubArr( &arr2,arr2.count, &arr3,arr3.count)
	_ = maxConSubArr2( &arr2,arr2.count, &arr3,arr3.count)
}
// 13 
// 13 
// 13

func rainWater(_ arr : inout [Int], _ size : Int) -> Int {
	var leftHigh : [Int] = Array(repeating: 0, count: size)
	var rightHigh : [Int] = Array(repeating: 0, count: size)
	var max : Int = arr[0]
	leftHigh[0] = arr[0]
	var i : Int = 1
	while (i < size) {
		if (max < arr[i]) {
			max = arr[i]
		}
		leftHigh[i] = max
		i += 1
	}
	
	max = arr[size - 1]
	rightHigh[size - 1] = arr[size - 1]
	i = (size - 2)
	while (i >= 0) {
		if (max < arr[i]) {
			max = arr[i]
		}
		rightHigh[i] = max
		i -= 1
	}
	
	var water : Int = 0
	i = 0
	while (i < size) {
		water += min(leftHigh[i],rightHigh[i]) - arr[i]
		i += 1
	}
	
	print("Water : " + String(water))
	return water
}

func rainWater2(_ arr : inout [Int], _ size : Int) -> Int {
	var water : Int = 0
	var leftMax : Int = 0, rightMax : Int = 0
	var left : Int = 0, right : Int = size - 1
	while (left <= right) {
		if (arr[left] < arr[right]) {
			if (arr[left] > leftMax) {
				leftMax = arr[left]
			} else {
				water += leftMax - arr[left]
			}
			left += 1
		} else {
			if (arr[right] > rightMax) {
				rightMax = arr[right]
			} else {
				water += rightMax - arr[right]
			}
			right -= 1
		}
	}
	print("Water : " + String(water))
	return water
}

// Testing code
func main49() {
var arr : [Int] = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
_ = rainWater( &arr,arr.count)
	_ = rainWater2( &arr,arr.count)
}
// Water : 6 
// Water : 6

func separateEvenAndOdd(_ arr : inout [Int], _ size : Int) {
	var left : Int = 0
	var right : Int = size - 1
	while (left < right) {
		if (arr[left] % 2 == 0) {
			left += 1
		} else if (arr[right] % 2 == 1) {
			right -= 1
		} else {
			swap( &arr,left,right)
			left += 1
			right -= 1
		}
	}
}

// Testing code
func main50() {
	var first : [Int] = [1, 5, 6, 6, 6, 6, 6, 6, 7, 8, 10, 13, 20, 30]
	separateEvenAndOdd( &first,first.count)
	for val in first{
		print(String(val) + " ",terminator: "")
	}
}
// 30 20 6 6 6 6 6 6 10 8 7 13 5 1

func arrayIndexMaxDiff(_ arr : inout [Int], _ size : Int) -> Int {
	var maxDiff : Int = -1
	var i : Int = 0, j : Int
	while (i < size) {
		j = size - 1
		while (i < j) {
			if (arr[i] <= arr[j]) {
				maxDiff = max(maxDiff,j - i)
				break
			}
			j -= 1
		}
		i += 1
	}
	return maxDiff
}

func arrayIndexMaxDiff2(_ arr : inout [Int], _ size : Int) -> Int {
	var rightMax : [Int] = Array(repeating: 0, count: size)
	rightMax[size - 1] = arr[size - 1]
	var i : Int = size - 2
	while (i >= 0) {
		rightMax[i] = max(rightMax[i + 1],arr[i])
		i -= 1
	}
	
	var maxDiff : Int = -1
	i = 0
	var j : Int = 1
	while (i < size && j < size) {
		if (arr[i] <= rightMax[j]) {
			if (i < j) {
				maxDiff = max(maxDiff,j - i)
			}
			j = j + 1
		} else {
			i = i + 1
		}
	}
	return maxDiff
}

// Testing code
func main51() {
var arr : [Int] = [33, 9, 10, 3, 2, 60, 30, 33, 1]
print("arrayIndexMaxDiff : " + String(arrayIndexMaxDiff( &arr,arr.count)))
	print("arrayIndexMaxDiff : " + String(arrayIndexMaxDiff2( &arr,arr.count)))
}
// arrayIndexMaxDiff : 7
// arrayIndexMaxDiff : 7

func maxPathSum(_ arr1 : inout [Int], _ size1 : Int, _ arr2 : inout [Int], _ size2 : Int) -> Int {
	var i : Int = 0, j : Int = 0
	var result : Int = 0, sum1 : Int = 0, sum2 : Int = 0
	while (i < size1 && j < size2) {
		if (arr1[i] < arr2[j]) {
			sum1 += arr1[i]
			i += 1
		} else if (arr1[i] > arr2[j]) {
			sum2 += arr2[j]
			j += 1
		} else {
			result += max(sum1,sum2)
			result = result + arr1[i]
			sum1 = 0
			sum2 = 0
			i += 1
			j += 1
		}
	}

	while (i < size1) {
		sum1 += arr1[i]
		i += 1
	}

	while (j < size2) {
		sum2 += arr2[j]
		j += 1
	}

	result += max(sum1,sum2)
	return result
}

// Testing code
func main52() {
var arr1 : [Int] = [12, 13, 18, 20, 22, 26, 70]
var arr2 : [Int] = [11, 15, 18, 19, 20, 26, 30, 31]
print("Max Path Sum:: " + String(maxPathSum( &arr1,arr1.count, &arr2,arr2.count)))
}
// Max Path Sum:: 201

func maxSubArraySum(_ a : inout [Int], _ size : Int) -> Int {
	var maxSoFar : Int = 0
	var maxEndingHere : Int = 0
	var i : Int = 0
	while (i < size) {
		maxEndingHere = maxEndingHere + a[i]
		if (maxEndingHere < 0) {
			maxEndingHere = 0
		}

		if (maxSoFar < maxEndingHere) {
			maxSoFar = maxEndingHere
		}
		i += 1
	}
	return maxSoFar
}

// Testing code
func main53() {
var arr : [Int] = [1, -2, 3, 4, -4, 6, -4, 3, 2]
print("Max sub array sum :" + String(maxSubArraySum( &arr,9)))
}

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
main10A()
main11()
main12()
main13()
main14()
main15()
main16()
main17()
main18()
main19()
main20() 
main21() 
main22() 
main23() 
main24() 
main25()
main26()
main27() 
main28() 
main29()
main30() 
main31()
main32()
main33() 
main34() 
main35() 
main36() 
main37() 
main38() 
main39()
main40()
main41() 
main42()
main43()
main44()
main45()
main46()
main47()
main48()
main49()
main50()
main51()
main52()
main53()