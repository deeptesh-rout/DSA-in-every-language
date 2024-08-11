function matchExpUtil(exp: string, str: string, i: number, j: number): boolean {
    if (i === exp.length && j === str.length) {
        return true;
    }
    if ((i === exp.length && j !== str.length) || (i !== exp.length && j === str.length)) {
        return false;
    }
    if (exp[i] === '?' || exp[i] === str[j]) {
        return matchExpUtil(exp, str, i + 1, j + 1);
    }
    if (exp[i] === '*') {
        return (
            matchExpUtil(exp, str, i + 1, j) ||
            matchExpUtil(exp, str, i, j + 1) ||
            matchExpUtil(exp, str, i + 1, j + 1)
        );
    }
    return false;
}

function matchExp(exp: string, str: string): boolean {
    return matchExpUtil(exp, str, 0, 0);
}

// Testing code.
function test1(): void {
    console.log(matchExp("hello*", "helloworld"));
    console.log(matchExp("hello?d", "hellowd"));
    console.log(matchExp("hello*hemant", "helloworldfsdfsdfdsfhemant"));
    console.log(matchExp("*hemantj", "helloworldfsdfsdfdsfhemant"));
}

test1();
/*
true
true
true
false
*/

function matchPattern(source: string, pattern: string): boolean {
    let iSource = 0;
    let iPattern = 0;
    const sourceLen = source.length;
    const patternLen = pattern.length;
    for (iSource = 0; iSource < sourceLen; iSource++) {
        if (source[iSource] === pattern[iPattern]) {
            iPattern++;
        }
        if (iPattern === patternLen) {
            return true;
        }
    }
    return false;
}

// Testing code.
function test2(): void {
    console.log(matchPattern("hellofskdlfjsdlfjsldjflksdworld", "helloworld"));
    console.log(matchPattern("hellod", "hellowd"));
    console.log(matchPattern("hello*xxxxxxxxxxhemantxxxxxxxxxxxx", "hellnt"));
}

test2();
/*
true
false
true
*/

function isPrime(n: number): boolean {
    let answer = n > 1 ? true : false;
    for (let i = 2; i * i <= n; ++i) {
        if (n % i === 0) {
            answer = false;
            break;
        }
    }
    return answer;
}

// Testing code.
function test3() {
    let output = "Prime numbers under 100 :: ";
    for (let i: number = 0; i < 100; i++) { if (isPrime(i)) output += (i + " "); }
    console.log(output);
}


test3();
/*
Prime numbers under 100 :: 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 
*/

function isUniqueChar(str: string): boolean {
    const bitarr = new Array(26).fill(0);
    const size = str.length;
    const small = "a".charCodeAt(0);
    const big = "A".charCodeAt(0);

    for (let i = 0; i < size; i++) {
        let c = str.charCodeAt(i);
        if ((big <= c) && (big + 26 >= c)) {
            c = (c - big);
        } else if ((small <= c) && (small + 26 >= c)) {
            c = (c - small);
        } else {
            console.log("Unknown Char.");
            return false;
        }
        if (bitarr[c] !== 0) {
            console.log("Duplicate detected.");
            return false;
        }
        bitarr[c] = 1;
    }
    console.log("No duplicate detected.");
    return true;
}

// Testing code.
function test5(): void {
    isUniqueChar("aple");
    isUniqueChar("apple");
}

test5();
/*
No duplicate detected.
Duplicate detected.
*/

function ToUpper(s: string): string {
    const ascii = s.charCodeAt(0);
    if (ascii >= 97 && ascii <= 97 + 25) {
        s = String.fromCharCode(ascii - 32);
    }
    return s;
}

function ToLower(s: string): string {
    const ascii = s.charCodeAt(0);
    if (ascii >= 65 && ascii <= 65 + 25) {
        s = String.fromCharCode(ascii + 32);
    }
    return s;
}

function LowerUpper(s: string): string {
    const ascii = s.charCodeAt(0);
    if (ascii >= 97 && ascii <= 97 + 25) {
        s = String.fromCharCode(ascii - 32);
    } else if (ascii >= 65 && ascii <= 65 + 25) {
        s = String.fromCharCode(ascii + 32);
    }
    return s;
}

// Testing code.
function test6(): void {
    console.log(ToLower('A'));
    console.log(ToUpper('a'));
    console.log(LowerUpper('s'));
    console.log(LowerUpper('S'));
}

test6();
/*
a
A
S
s
*/


function isPermutation(s1: string, s2: string): boolean {
    const count = new Array(256).fill(0);
    const length = s1.length;
    if (s2.length !== length) {
        return false;
    }

    for (let i = 0; i < length; i++) {
        count[s1.charCodeAt(i)]++;
        count[s2.charCodeAt(i)]--;
    }

    for (let i = 0; i < length; i++) {
        if (count[s1.charCodeAt(i)] !== 0) {
            return false;
        }
    }

    return true;
}

// Testing code.
function test7(): void {
    console.log("isPermutation :", isPermutation("apple", "plepa"));
    console.log("isPermutation :", isPermutation("appleb", "plepaa"));
}

test7();
/*
isPermutation : true
isPermutation : false
*/

function isPalindrome(str: string): boolean {
    let i = 0;
    let j = str.length - 1;
    while (i < j && str[i] == str[j]) {
        i++;
        j--;
    }

    if (i < j) {
        console.log(str, "is not a Palindrome");
        return false;
    } else {
        console.log(str, "is a Palindrome");
        return true;
    }
}

// Testing code.
function test8(): void {
    isPalindrome("hello");
    isPalindrome("oyo");
}

test8();
/*
hello is not a Palindrome
oyo is a Palindrome
*/

function pow(x: number, n: number): number {
    let value: number;
    if (n === 0) {
        return 1;
    } else if (n % 2 === 0) {
        value = pow(x, Math.floor(n / 2));
        return value * value;
    } else {
        value = pow(x, Math.floor(n / 2));
        return x * value * value;
    }
}

// Testing code.
function test9(): void {
    console.log(pow(5, 2));
}

test9();
// 25

function myStrcmp(a: string, b: string): number {
    let index = 0;
    const len1 = a.length;
    const len2 = b.length;
    let minlen = len1;

    if (len1 > len2) {
        minlen = len2;
    }
    while (index < minlen && a[index] === b[index]) {
        index++;
    }
    if (index === len1 && index === len2) {
        return 0;
    } else if (len1 === index) {
        return -1;
    } else if (len2 === index) {
        return 1;
    } else {
        return a.charCodeAt(index) - b.charCodeAt(index);
    }
}

// Testing code.
function test10(): void {
    console.log("StrCmp returns :", myStrcmp("apple", "appke"));
    console.log("StrCmp returns :", myStrcmp("apple", "apple"));
    console.log("StrCmp returns :", myStrcmp("apple", "appme"));
}

test10();

/*
StrCmp returns : 1
StrCmp returns : 0
StrCmp returns : -1
*/

function reverseString(str: string): string {
    const a = str.split('');
    reverseStringUtil(a);
    const expn = a.join('');
    return expn;
}

function reverseStringUtil(a: string[]): void {
    let lower = 0;
    let upper = a.length - 1;
    let tempChar: string;

    while (lower < upper) {
        tempChar = a[lower];
        a[lower] = a[upper];
        a[upper] = tempChar;
        lower++;
        upper--;
    }
}

function reverseStringUtil2(a: string[], lower: number, upper: number): void {
    let tempChar: string;

    while (lower < upper) {
        tempChar = a[lower];
        a[lower] = a[upper];
        a[upper] = tempChar;
        lower++;
        upper--;
    }
}

function reverseWords(str: string): string {
    const a = str.split("");
    const length = a.length;
    let lower: number;
    let upper = -1;
    lower = 0;
    for (let i = 0; i <= length; i++) {
        if (a[i] === ' ') {
            reverseStringUtil2(a, lower, upper);
            lower = i + 1;
            upper = i;
        } else {
            upper++;
        }
    }
    reverseStringUtil2(a, lower, upper - 1);
    reverseStringUtil2(a, 0, length - 1);
    return a.join("");
}

// Testing code.
function test11(): void {
    console.log(reverseString("apple"));
    console.log(reverseWords("hello world"));
}

test11();
/*
elppa
world hello
*/

function printAnagram(str: string): void {
    const size = str.length;
    const arr = str.split('');
    printAnagramUtil(arr, 0, size);
}

function swapch(a: string[], x: number, y: number): void {
    let temp = a[x];
    a[x] = a[y];
    a[y] = temp;
}

function printAnagramUtil(arr: string[], i: number, size: number): void {
    if (i == size) {
        console.log(arr.join(""));
        return;
    }

    for (let j = i; j < size; j++) {
        swapch(arr, i, j);
        printAnagramUtil(arr, i + 1, size);
        swapch(arr, i, j);
    }
}

// Testing code.
function test12(): void {
    printAnagram("123");
}

test12();
/*
123
132
213
231
321
312
*/

function shuffle(str: string): string {
    const ar = str.split('');
    const n = Math.floor(ar.length / 2);
    let count = 0;
    let k = 1;
    let temp: string;
    let temp2: string;
    for (let i = 1; i < n; i = i + 2) {
        temp = ar[i];
        k = i;
        do {
            k = (2 * k) % (2 * n - 1);
            temp2 = temp;
            temp = ar[k];
            ar[k] = temp2;
            count++;
        } while (i !== k);

        if (count === (2 * n - 2)) {
            break;
        }
    }
    return ar.join("");
}

// Testing code.
function test13(): void {
    console.log(shuffle("ABCDE12345"));
}

test13();
//A1B2C3D4E5

function addBinary(first: string, second: string): string {
    let size1 = first.length;
    let size2 = second.length;
    let totalIndex: number;
    let total: Array<string | null>;
    if (size1 > size2) {
        total = new Array(size1 + 2).fill(null);
        totalIndex = size1;
    } else {
        total = new Array(size2 + 2).fill(null);
        totalIndex = size2;
    }
    total[totalIndex + 1] = '';
    let carry = 0;
    size1--;
    size2--;
    while (size1 >= 0 || size2 >= 0) {
        const firstValue = (size1 < 0) ? 0 : Number(first[size1]);
        const secondValue = (size2 < 0) ? 0 : Number(second[size2]);
        let sum = firstValue + secondValue + carry;
        carry = sum >> 1;
        sum = sum & 1;
        total[totalIndex] = (sum === 0) ? '0' : '1';
        totalIndex--;
        size1--;
        size2--;
    }
    total[totalIndex] = (carry === 0) ? '0' : '1';
    return total.join("");
}

// Testing code.
function test14(): void {
    console.log(addBinary("1000", "11111111"));
}

test14();
//100000111
