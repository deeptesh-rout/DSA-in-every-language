func bruteforceSearch(text : String, pattern : String) -> Int {
	var i = 0, j = 0
	let pattern = pattern.flatMap { $0.unicodeScalars }
    let text = text.flatMap { $0.unicodeScalars }
	let n = text.count
	let m = pattern.count

	while i <= n-m {
		j = 0
		while j < m && pattern[j] == text[i+j] {
			j+=1
		}
		if j == m {
			return i
		}
		i+=1
	}
	return -1
}

func robinKarp(text : String, pattern : String) -> Int {
	let n = text.count
	let m = pattern.count
	let prime = 101
	var powm = 1
	var TextHash = 0
	var PatternHash = 0
	var i = 0, j = 0
	let pattern = pattern.unicodeScalars.map { $0.value }
	let text = text.unicodeScalars.map { $0.value }
	if m == 0 || m > n {
		return -1
	}

	while i < m-1 {
		powm = (powm << 1) % prime
		i+=1
	}

	i = 0
	while i < m {
		PatternHash = ((PatternHash << 1) + Int(pattern[i])) 
		PatternHash %= prime
		TextHash = ((TextHash << 1) + Int(text[i])) 
		TextHash %= prime
		i+=1
	}

	i = 0
	while i <= (n - m) {
		if TextHash == PatternHash {
			j = 0
			while j < m {
				if text[i+j] != pattern[j] {
					break
				}
				j+=1
			}
			if j == m {
				return i
			}
		i+=1
		}
		TextHash = (((TextHash - Int(text[i])*powm) << 1) + Int(text[i+m])) 
		TextHash %= prime
		if TextHash < 0 {
			TextHash = (TextHash + prime)
		}
	}
	return -1
}

func kmpPreprocess(pattern : [UInt32], ShiftArr : inout [Int]) {
	let m = pattern.count
	var i = 0
	var j = -1
	ShiftArr[i] = -1
	while i < m {
		while j >= 0 && pattern[i] != pattern[j] {
			j = ShiftArr[j]
		}
		i+=1
		j+=1
		ShiftArr[i] = j
	}
}

func kmp(text : String, pattern : String) -> Int {
	var i = 0, j = 0
	let n = text.count
	let m = pattern.count
	let pattern = pattern.unicodeScalars.map { $0.value }
	let text = text.unicodeScalars.map { $0.value }
	var ShiftArr = Array(repeating : 0, count: m+1)
	kmpPreprocess(pattern : pattern, ShiftArr : &ShiftArr)
	while i < n {
		while j >= 0 && text[i] != pattern[j] {
			j = ShiftArr[j]
		}
		i+=1
		j+=1
		if j == m {
			return (i - m)
		}
	}
	return -1
}

func kmpFindCount(text : String, pattern : String) -> Int {
	var i = 0, j = 0
	var count = 0
	let n = text.count
	let m = pattern.count
	let pattern = pattern.unicodeScalars.map { $0.value }
	let text = text.unicodeScalars.map { $0.value }
	var ShiftArr = Array(repeating : 0, count: m+1)
	kmpPreprocess(pattern : pattern, ShiftArr : &ShiftArr)
	while i < n {
		while j >= 0 && text[i] != pattern[j] {
			j = ShiftArr[j]
		}
		i+=1
		j+=1
		if j == m {
			count+=1
			j = ShiftArr[j]
		}
	}
	return count
}

// Testing code.
let st1 = "hello, world! world hello wor world"
let st2 = "world"
print("Bruteforce search return : \(bruteforceSearch(text : st1, pattern : st2))")
print("RobinKarp search return : \(robinKarp(text : st1, pattern : st2))")
print("KMP search return : \(kmp(text : st1, pattern : st2))")
let st3 = "Only time will tell if we stand the test of time"
print("Frequency of 'time' is : \(kmpFindCount(text : st3, pattern : "time"))")

/*
Bruteforce search return : 7
RobinKarp search return : 7
KMP search return : 7
Frequency of 'time' is : 2
*/
