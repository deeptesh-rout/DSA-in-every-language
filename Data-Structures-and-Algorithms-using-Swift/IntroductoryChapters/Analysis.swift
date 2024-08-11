import Foundation

func fun1(_ n : Int) -> Int {
	var m : Int = 0
	var i : Int = 0 
	while i < n { 
		m += 1
		i+=1
	}
	return m
}

func fun2(_ n : Int) -> Int {
	var m : Int = 0
	var i : Int = 0 
	while i < n { 
		var j : Int = 0
		while j < n{
			m += 1
			j+=1 
		}
		i+=1
	}
	return m
}

func fun3(_ n : Int) -> Int {
	var m : Int = 0
	var i : Int = 0 
	while i < n { 
		var j : Int = 0
		while j < n {
			var k = 0
			while k < n{
				m += 1
				k += 1
			}
			j+=1
		}
		i+=1
	}
	return m
}

func fun4(_ n : Int) -> Int {
	var m : Int = 0
	var i : Int = 0 
	while i < n { 
		var j = i
		while j < n {
			var k = j + 1
			while k < n {
				m += 1
				k += 1
			}
			j+=1
		}
		i+=1
	}
	return m
}

func fun5(_ n : Int) -> Int {
	var m : Int = 0
	var i : Int = 0 
	while i < n {
		var j : Int = 0 
		while j < i {
			m += 1
			j += 1
		}
		i += 1
	}
	return m
}

func fun6(_ n : Int) -> Int {
	var m : Int = 0
	var i : Int = 0 
	while i < n { 
		var j = i
		while j > 0 {
			m += 1
			j -= 1
		}
		i+=1
	}
	return m
}

func fun7(_ n : Int) -> Int {
	var m : Int = 0
	var i : Int = n
	while i > 0 {
		var j : Int = 0 
		while j < i {  
			m += 1
			j+=1
		}
		i /= 2
	}
	return m
}

func fun8(_ n : Int) -> Int {
	var m : Int = 0
	var i : Int = 1
	while i <= n {
		var j : Int = 0
		while j <= i {
			m += 1
			j+=1
		}
		i *= 2
	}
	return m
}

func fun9(_ n : Int) -> Int {
	var m : Int = 0
	var i : Int = 1
	while i < n {
		m += 1
		i = i * 2
	}
	return m
}

func fun10(_ n : Int) -> Int {
	var m : Int = 0
	var i : Int = n
	while i > 0 {
		m += 1
		i = i / 2
	}
	return m
}

func fun11(_ n : Int) -> Int {
	var m : Int = 0
	var i : Int = 0 
	while i < n { 
		var j : Int = 0
		while j < n {
			m += 1
			j+=1
		}
		i+=1
	}
	i = 0 
	while i < n { 
		var k = 0
		while k < n {
			m += 1
			k += 1
		}
		i+=1
	}
	return m
}

func fun12(_ n : Int) -> Int {
	var m : Int = 0
	var i : Int = 0 
	while i < n { 
		let sq = sqrt(Double(n))
		var j : Int = 0
		while j < Int(sq) {
			m += 1
			j += 1
		}
		i+=1
	}

	return m
}

func fun13(_ n : Int) -> Int {
	var j = 0
	var m : Int = 0
	var i : Int = 0 
	while i < n { 
		while j < n {
			m += 1
			j+=1
		}
		i+=1
	}
	return m
}

print("N = 100, Number of instructions in O(n):: \(fun1(100))")
print("N = 100, Number of instructions in O(n^2):: \(fun2(100))")
print("N = 100, Number of instructions in O(n^3):: \(fun3(100))")
print("N = 100, Number of instructions in O(n^3):: \(fun4(100))")
print("N = 100, Number of instructions in O(n^2):: \(fun5(100))")
print("N = 100, Number of instructions in O(n^2):: \(fun6(100))")
print("N = 100, Number of instructions in O(n):: \(fun7(100))")
print("N = 100, Number of instructions in O(n):: \(fun8(100))")
print("N = 100, Number of instructions in O(log(n)):: \(fun9(100))")
print("N = 100, Number of instructions in O(log(n)):: \(fun10(100))")
print("N = 100, Number of instructions in O(n^2):: \(fun11(100))")
print("N = 100, Number of instructions in O(n^(3/2)):: \(fun12(100))")
print("N = 100, Number of instructions in O(n):: \(fun13(100))")

/*
N = 100, Number of instructions in O(n):: 100
N = 100, Number of instructions in O(n^2):: 10000
N = 100, Number of instructions in O(n^3):: 1000000
N = 100, Number of instructions in O(n^3):: 166650
N = 100, Number of instructions in O(n^2):: 4950
N = 100, Number of instructions in O(n^2):: 4950
N = 100, Number of instructions in O(n):: 197
N = 100, Number of instructions in O(n):: 134
N = 100, Number of instructions in O(log(n)):: 7
N = 100, Number of instructions in O(log(n)):: 7
N = 100, Number of instructions in O(n^2):: 20000
N = 100, Number of instructions in O(n^(3/2)):: 1000
N = 100, Number of instructions in O(n):: 100
*/
