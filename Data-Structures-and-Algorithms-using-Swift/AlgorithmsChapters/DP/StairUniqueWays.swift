import Foundation

func stairUniqueWaysBU(_ n : Int) -> Int {
	if (n <= 2) {
		return n
	}

	var first : Int = 1
	var second : Int = 2
	var temp : Int = 0
	var i : Int = 3
	while (i <= n) {
		temp = first + second
		first = second
		second = temp
		i += 1
	}
	return temp
}

func stairUniqueWaysBU2(_ n : Int) -> Int {
	if (n < 2) {
		return n
	}
	var ways : [Int] = Array(repeating: 0, count: n)
	ways[0] = 1
	ways[1] = 2

	var i : Int = 2
	while (i < n) {
		ways[i] = ways[i - 1] + ways[i - 2]
		i += 1
	}
	return ways[n - 1]
}

// Testing code.
print("Unique way to reach top::" , stairUniqueWaysBU(4))
print("Unique way to reach top::", stairUniqueWaysBU2(4))

/*
Unique way to reach top:: 5
Unique way to reach top:: 5
*/