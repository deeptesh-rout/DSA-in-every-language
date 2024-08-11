function andEx(a: number, b: number): number {
    return a & b;
}

function orEx(a: number, b: number): number {
    return a | b;
}

function xorEx(a: number, b: number): number {
    return a ^ b;
}

function leftShiftEx(a: number): number {
    return a << 1; // multiply by 2
}

function rightShiftEx(a: number): number {
    return a >> 1; // divide by 2
}

function bitReversalEx(a: number): number {
    return ~a;
}

function twoComplementEx(a: number): number {
    return -a;
}

function kthBitCheck(a: number, k: number): boolean {
    return (a & (1 << (k - 1))) > 0;
}

function kthBitSet(a: number, k: number): number {
    return a | (1 << (k - 1));
}

function kthBitReset(a: number, k: number): number {
    return a & ~(1 << (k - 1));
}

function kthBitToggle(a: number, k: number): number {
    return a ^ (1 << (k - 1));
}

function rightMostBit(a: number): number {
    return a & -a;
}

function resetRightMostBit(a: number): number {
    return a & (a - 1);
}

function isPowerOf2(a: number): boolean {
    return (a & (a - 1)) === 0;
}

function countBits(a: number): number {
    let count = 0;
    while (a > 0) {
        count += 1;
        a = a & (a - 1);
    }
    return count;
}

// Testing code.
let a = 4;
let b = 8;
console.log(andEx(a, b));
console.log(orEx(a, b));
console.log(xorEx(a, b));
console.log(leftShiftEx(a)); // multiply by 2
console.log(rightShiftEx(a)); // divide by 2
console.log(bitReversalEx(a));
console.log(twoComplementEx(a));
console.log(kthBitCheck(a, 3));
console.log(kthBitSet(a, 2));
console.log(kthBitReset(a, 3));
console.log(kthBitToggle(a, 3));
console.log(rightMostBit(a));
console.log(resetRightMostBit(a));
console.log(isPowerOf2(a));
for (let i = 0; i < 10; i++) {
    console.log(i + " bit count: " + countBits(i));
}

/*
0
12
12
8
2
-5
-4
true
6
0
0
4
0
true
*/

/*
0 bit count: 0
1 bit count: 1
2 bit count: 1
3 bit count: 2
4 bit count: 1
5 bit count: 2
6 bit count: 2
7 bit count: 3
8 bit count: 1
9 bit count: 2
*/
