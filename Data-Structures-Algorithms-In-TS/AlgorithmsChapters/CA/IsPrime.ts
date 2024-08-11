function isPrime(n: number): boolean {
	let answer: boolean = n > 1;
	for (let i = 2; i * i <= n; ++i) {
		if (n % i === 0) {
			answer = false;
			break;
		}
	}
	return answer;
}

console.log(isPrime(8));
console.log(isPrime(11));


/*
false
true
*/