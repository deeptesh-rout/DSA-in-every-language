func fibonacci(n : Int) -> Int {
	if n <= 1 {
		return n
	}
	return fibonacci(n : n-1) + fibonacci(n : n-2)
}

func fibonacci2(n : Int) -> Int {
	var first = 0
	var second = 1
	var temp = 0
	var i = 2
	if n == 0 {
		return first
	} else if n == 1 {
		return second
	}
	while i <= n {
		temp = first + second
		first = second
		second = temp
		i+=1
	}
	return temp
}

import Foundation
let start = Date()
let val = fibonacci(n:30) 
let end = Date()
print("\(val)")
let timeElapsed: Double = end.timeIntervalSince(start)
print("time = \(timeElapsed) sec")

let startTime = Date()
let val2 = fibonacci2(n:30)
let endTime = Date()
print("\(val2)")
let timeInterval: Double = endTime.timeIntervalSince(startTime)
print("time = \(timeInterval) sec")

