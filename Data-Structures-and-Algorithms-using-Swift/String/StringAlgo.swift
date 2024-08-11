import Foundation

func strcmp(_ str1 : String, _ str2 : String) -> Int {
	let a = Array(str1)
	let b = Array(str2)
	var index = 0
	let len1 = a.count
	let len2 = b.count
	let minlen : Int = (len1 < len2) ? len1 : len2

	while index < minlen && a[index] == b[index] {
		index += 1
	}

	if index == len1 && index == len2 {
		return 0
	} else if len1 == index {
		return -1
	} else if len2 == index {
		return 1
	}

	if (a[index] > b[index]) {
		return 1
	} else {
		return -1
	}
}


// Testing Code
func main1() {
	print(strcmp("apple","appke"))
	print(strcmp("apple","apple"))
	print(strcmp("apple","appme"))
}
// 	1
// 	0
// 	-1

func matchPattern(_ src : String, _ ptn : String) -> Bool {
	let source = Array(src)
	let pattern = Array(ptn)
	var iSource = 0
	var iPattern = 0
	let sourceLen = source.count
	let patternLen = pattern.count
	while iSource < sourceLen {
		if source[iSource] == pattern[iPattern] {
			iPattern += 1
		}
		if iPattern == patternLen {
			return true
		}
		iSource += 1
	}
	return false
}

// Testing Code
func main2() {
	print(matchPattern("harrypottermustnotgotoschool","potterschool"))
}
// true

func isPrime(_ n : Int) -> Bool {
	var answer : Bool = (n > 1) ? true : false
    var i : Int = 2
    while (i * i <= n) {
        if (n % i == 0) {
            answer = false
            break
        }
        i += 1
    }
	return answer
}

// Testing Code
func main3() {
	print("Prime numbers under 10 :: ",terminator: "")
    var i : Int = 0
    while (i < 10) {
        if (isPrime(i)) {
			print(String(i) + " ",terminator: "")
        }
        i += 1
    }
	print()
}
// Prime numbers under 10 :: 2 3 5 7


func isUniqueChar(_ str : String) -> Bool {
	var mp : [Character: Bool] = [:]
	for char in str {
		if mp[char] != false {
			return false
		}
		mp[char] = true
	}
	return true
}

// Testing Code
func main5() {
	print("isUniqueChar :", isUniqueChar("aple"))
	print("isUniqueChar :", isUniqueChar("apple"))
}
// 	No duplicate detected!
// 	Duplicate detected!


func isPermutation(_ s1 : String, _ s2 : String) -> Bool {
	var count : [Character:Int] = [:]
	if s2.count != s1.count {
		print(s1, "&", s2, "are not permutation")
		return false
	}
	for ch in s1  {
		if count[ch] == nil {
			count[ch] = 1
		} else {
			count[ch]! += 1
		}
	}
	for ch in s2  {
		if count[ch] == nil || count[ch] == 0 {
		print("\(s1) & \(s2) are not permutation")
			return false
		} else {
			count[ch]! -= 1
		}
	}
	print("\(s1) & \(s2) are permutation")
	return true
}

// Testing Code
func main7() {
	print(isPermutation("apple","plepa"))
}
// 	is permutation return true
// 	true

func isPalindrome(_ st : String) -> Bool {
	let str = Array(st)
	var i = 0
	var j = str.count - 1
	while i < j && str[i] == str[j] {
		i += 1
		j -= 1
	}
	if i < j {
		print("String is not a Palindrome")
		return false
	}
	print("String is a Palindrome")
	return true
}

// Testing Code
func main8() {
	_ = isPalindrome("hello")
	_ = isPalindrome("oyo")
}
// 	String is not a Palindrome
// 	String is a Palindrome

func pow(_ x : Int, _ n : Int) -> Int {
	var value : Int
	if n == 0 {
		return 1
	} else if n%2 == 0 {
		value = pow(x, n/2)
		return (value * value)
	} else {
		value = pow(x, n/2)
		return x * value * value
	}
}

// Testing Code
func main9() {
	print(pow(5,2))
}
// 25

func reverseString(_ a : String) -> String {
	var arr = Array(a)
	var lower = 0
	var upper = arr.count - 1
	while lower < upper {
		arr.swapAt(lower, upper)
		lower += 1
		upper -= 1
	}
	return String(arr)
}

func reverseStringRange(_ a : inout [Character], _ start : Int, _ stop : Int) {
	var lower = start
	var upper = stop
	while lower < upper {
		a.swapAt(lower, upper)
		lower += 1
		upper -= 1
	}
}

func reverseWords(_ st : String) -> String {
	var str = Array(st)
	let length = str.count
	var upper = -1
	var lower = 0
	var i = 0

	while i < length {
		if str[i] == " " {
			reverseStringRange(&str, lower, upper)
			lower = i + 1
			upper = i
		} else {
			upper += 1
		}
		i += 1
	}
	reverseStringRange(&str, lower, upper)
	reverseStringRange(&str, 0, length-1)
	return String(str)
}

// Testing Code
func main11() {
	print(reverseString("apple"))
	print(reverseWords("hello world"))
}
// 	elppa
// 	world hello

func printAnagram(_ a : String) {
	var arr = Array(a)
	printAnagramUtil(&arr, 0, a.count)
}

func printAnagramUtil(_ a : inout [Character], _ i : Int, _ length : Int) {
	if length == i {
		print(String(a))
		return
	}
	for j in i...length-1 {
		a.swapAt(i,j)
		printAnagramUtil(&a, i+1, length)
		a.swapAt(i,j)
	}
}


// Testing Code
func main12() {
	printAnagram("123")
}
// 	123
// 	132
// 	213
// 	231
// 	321
// 	312

func shuffle(_ str : String) -> String {
	var arr = Array(str)
	let n = arr.count / 2
	var count = 0
	var k = 1
	var temp : Character, temp2 : Character
	var i = 1
	while i < n {
		k = i
		temp = arr[i]
		while true {
			k = (2 * k) % (2*n - 1)
			temp2 = temp
			temp = arr[k]
			arr[k] = temp2
			
			count += 1
			if i == k {
				break
			}
		}
		if count == (2*n - 2) {
			break
		}
		i = i + 2
	}
	return String(arr)
}

// Testing Code
func main13() {
	print(shuffle("ABCDE12345"))
}
// A1B2C3D4E5

func matchExp(_ exp : String, _ str : String) -> Bool {
	var ex = Array(exp)
	var st = Array(str)
	return matchExpUtil(&ex, &st, 0, 0)
}

func matchExpUtil(_ exp : inout [Character], _ str : inout [Character], _ i : Int, _ j : Int) -> Bool {
	if i == exp.count && j == str.count {
		return true
	}
	if (i == exp.count && j != str.count) || (i != exp.count && j == str.count) {
		return false
	}
	if exp[i] == "?" || exp[i] == str[j] {
		return matchExpUtil(&exp, &str, i+1, j+1)
	}
	if exp[i] == "*" {
		return matchExpUtil(&exp, &str, i+1, j) || 
		matchExpUtil(&exp, &str, i, j+1) || 
		matchExpUtil(&exp, &str, i+1, j+1)
	}
	return false
}

// Testing Code
func main10() {
	print(matchExp("*llo,?World?","Hello, World!"))
}
// true

main1()
main2()
main3()
main5()
main7()
main8()
main9()
main11()
main12()
main13()
main10()
