function fibonacci(n: number): number {
    if (n < 2) {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

function fibonacci2(n: number): number {
    if (n < 2) {
        return n;
    }

    let first = 0;
    let second = 1;
    let temp = 0;

    for (let i = 2; i <= n; i++) {
        temp = first + second;
        first = second;
        second = temp;
    }

    return temp;
}

function main1() {
    console.log("fibonacci(10):", fibonacci(10));
    console.log("fibonacci2(10):", fibonacci2(10));
}

main1();

/*

fibonacci(10): 55
fibonacci2(10): 55

*/

function isFeasible(Q: number[], k: number): boolean {
    for (let i = 0; i < k; i++) {
        if (Q[k] === Q[i] || Math.abs(Q[i] - Q[k]) === Math.abs(i - k)) {
            return false;
        }
    }
    return true;
}

function nQueens(Q: number[], k: number, n: number) {
    if (k === n) {
        console.log(Q);
        return;
    }

    for (let i = 0; i < n; i++) {
        Q[k] = i;
        if (isFeasible(Q, k)) {
            nQueens(Q, k + 1, n);
        }
    }
}

function main2() {
    const Q: number[] = [0, 0, 0, 0, 0, 0, 0, 0];
    nQueens(Q, 0, 8);
}

main2();

/*

[0, 4, 7, 5, 2, 6, 1, 3]
[0, 5, 7, 2, 6, 3, 1, 4]
...
[7, 2, 0, 5, 1, 4, 6, 3]
[7, 3, 0, 2, 5, 1, 6, 4]

*/

function towersOfHanoi(num: number, from: string, to: string, temp: string) {
    if (num < 1) {
        return;
    }
    towersOfHanoi(num - 1, from, temp, to);
    console.log(`Move disk ${num} from peg ${from} to peg ${to}`);
    towersOfHanoi(num - 1, temp, to, from);
}

function towersOfHanoiMain() {
    console.log("The sequence of moves involved in the Tower of Hanoi are:");
    towersOfHanoi(3, 'A', 'C', 'B');
}

towersOfHanoiMain();

/*

The sequence of moves involved in the Tower of Hanoi are:
Move disk 1 from peg A to peg C
Move disk 2 from peg A to peg B
Move disk 1 from peg C to peg B
Move disk 3 from peg A to peg C
Move disk 1 from peg B to peg A
Move disk 2 from peg B to peg C
Move disk 1 from peg A to peg C

*/

function isPrime(n: number): boolean {
    if (n <= 1) {
        return false;
    }

    for (let i = 2; i * i <= n; i++) {
        if (n % i === 0) {
            return false;
        }
    }
    return true;
}

function isPrimeMain() {
    console.log(isPrime(6));
    console.log(isPrime(11));
}

isPrimeMain();

/*

false
true

*/
