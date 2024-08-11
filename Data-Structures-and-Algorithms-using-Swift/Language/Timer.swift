import Foundation

public class Timer {
    public init() { 
        startTime = Date()
        endTime = Date()
    }
    private var startTime: Date;
    private var endTime: Date;
    
    public func start() {
        startTime = Date()
    }
    
    public func stop() -> Double {
        endTime = Date()
        let timeInterval: Double = endTime.timeIntervalSince(startTime)
        return timeInterval
    }
    
}
func fibonacci2(n : Int) -> Int {
	var first = 0
	var second = 1
	var temp = 0

	if n == 0 {
		return first
	} else if n == 1 {
		return second
	}

	var i = 2
	while i <= n {
		temp = first + second
		first = second
		second = temp
		i+=1
	}
	return temp
}
func fibonacci(n : Int) -> Int {
	if n <= 1 {
		return n
	}
	return fibonacci(n : n-1) + fibonacci(n : n-2)
}

let timer = Timer()
timer.start()
let result = fibonacci(n:50)
let duration = timer.stop()
print(duration)
let timer2 = Timer()
timer2.start()
let result2 = fibonacci2(n:50)
let duration2 = timer2.stop()
print(duration2)


