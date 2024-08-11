func factorial(_ i : Int) -> Int {
	// Termination Condition
	if i <= 1 {
		return 1
	}
	// Body, Recursive Expansion
	return i * factorial(i-1)
}

// Testing code.
print("factorial 5 is :: \(factorial(5))")

/*
factorial 5 is :: 120
*/

func printInt(_ number : Int, _ base : Int) {
	let conversion = Array("0123456789ABCDEF")
	let digit : Int = (number % base)
	let number = number / base
	
	if (number != 0) {
		printInt(number, base)
	}
	print(conversion[digit], terminator:"")
}

// Testing code.
printInt(500, 16)

/*
1F4
*/

func TowersOfHanoi(_ num : Int) {
	print("The sequence of moves involved in the Tower of Hanoi are :")
	TOHUtil(num : num, from :"A", to : "C", temp : "B")
}

func TOHUtil(num : Int, from : String, to : String, temp : String) {
	if num < 1 {
		return
	}

	TOHUtil(num : num-1, from : from, to : temp, temp : to)
	print("Move disk ", num, " from peg ", from, " to peg ", to)
	TOHUtil(num : num-1, from : temp, to : to, temp : from)
}

// Testing code.
TowersOfHanoi(3)

/*
The sequence of moves involved in the Tower of Hanoi are :
Move disk  1  from peg  A  to peg  C
Move disk  2  from peg  A  to peg  B
Move disk  1  from peg  C  to peg  B
Move disk  3  from peg  A  to peg  C
Move disk  1  from peg  B  to peg  A
Move disk  2  from peg  B  to peg  C
Move disk  1  from peg  A  to peg  C
*/

func fibonacci(_ n : Int) -> Int {
	if n <= 1 {
		return n
	}
	return fibonacci(n-1) + fibonacci(n-2)
}

// Testing code.
print(fibonacci(10))

/*
55
*/

func isPrime(_ n : Int) -> Bool {
	if( n < 1){
		return false
	} 
	var i = 2
	while (i*i <= n) {
		if(n%i == 0){
			return false
		}
	i += 1
	}
	return true
}

// Testing code.
print("isPrime :: \(isPrime(23))")
print("isPrime :: \(isPrime(5))")
print("isPrime :: \(isPrime(7))")

/*
isPrime :: true
isPrime :: true
isPrime :: true
*/

func gcd(_ m : Int, _ n : Int) -> Int {
	if (n == 0) {
		return m
	}
	if (m == 0) {
		return n
	}
	return gcd(n, m % n)
}

// Testing code.
print("Gcd is ::", gcd(5, 2))

/*
Gcd is :: 1
*/
