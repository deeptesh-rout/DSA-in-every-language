import Foundation

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

// Testing code.
print(isPrime(8))
print(isPrime(11))
/* 
false
true
 */