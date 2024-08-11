func isAnagram(_ str1 : String, _ str2 : String) -> Bool {
	if str1.count != str2.count {
		return false
	}
	var cntr : [Character:Int] = [Character:Int]()
	for ch in str1 {
		if (cntr[ch] != nil) {
			cntr[ch] = cntr[ch]! + 1
		} else {
			cntr[ch] = 1
		}
	}
	for ch in str2 {
		if (cntr[ch] == nil || cntr[ch]! == 0) {
			return false
		}
		cntr[ch] = cntr[ch]! - 1
	}
	return true
}

// Testing code.
let var1 = "hello"
let var2 = "elloh"
let var3 = "world"
print("isAnagram : \(isAnagram(var1, var2))")
print("isAnagram : \(isAnagram(var1, var3))")

/*
isAnagram : true
isAnagram : false
*/

func removeDuplicate(_ str : String) -> String {
	let input = str
	var hs = Set<Character>()

	var output = ""
	for ch in input {
		if hs.contains(ch) == false {
			output.append(ch)
			hs.insert(ch)
		}
	}
	return output
}

// Testing code.
print(removeDuplicate(var1))
/*
helo
*/

func findMissing(arr : [Int], start : Int, end : Int) -> (value:Int, flag:Bool) {
	var hs = Set<Int>()
	for i in arr {
		hs.insert(i)
	}
	var curr = start
	while curr <= end {
		if hs.contains(curr) == false {
			return (curr, true)
		}
		curr += 1
	}
	return (0, false)
}

// Testing code.
let arr = [1, 2, 3, 5, 6, 7, 9, 8, 10]
print("Missing number is ::", findMissing(arr:arr, start:1, end:10).value)
/*
Missing number is :: 4
*/

func printRepeating(_ arr : [Int]) {
	var hs = Set<Int>()
	print("Repeating elements are :: ", terminator:"")
	for val in arr {
		if hs.contains(val) {
			print(val, terminator:" ")
		} else {
			hs.insert(val)
		}
	}
	print()
}

// Testing code.
let arr1 = [1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 1]
printRepeating(arr1)
/*
Repeating elements are :: 4 1
*/

func printFirstRepeating(_ arr : [Int]) {
	var cntr : [Int:Int] = [Int:Int]()
	for val in arr {
		if (cntr[val] != nil) {
			cntr[val] = cntr[val]! + 1
		} else {
			cntr[val] = 1
		}
	}

	for val in arr {
		if (cntr[val]! > 1) {
			print("First Repeating number is :", val)
			return
		} 
	}
}

// Testing code.
printFirstRepeating(arr1)
/*
First Repeating number is : 1
*/


func hornerHash(key  : [Int], tableSize : Int) -> Int {
	let size = key.count
	var h = 0
	var i = 0
	while i < size {
		h = (32*h + key[i]) % tableSize
		i += 1
	}
	return h
}









