
function BruteForceSearch(text: string, pattern: string): number {
    let i: number = 0;
    let j: number = 0;
    let n: number = text.length;
    let m: number = pattern.length;
    while (i <= n - m) {
        j = 0;
        while (j < m && pattern[j] === text[i + j]) {
            j++;
        };
        if (j === m) {
            return (i);
        }
        i++;
    };
    return -1;
}


function RobinKarp(text: string, pattern: string): number {
    let n: number = text.length;
    let m: number = pattern.length;
    let i: number;
    let j: number;
    let prime: number = 101;
    let powm: number = 1;
    let TextHash: number = 0;
    let PatternHash: number = 0;
    if (m === 0 || m > n) {
        return -1;
    }
    for (i = 0; i < m - 1; i++) {
        powm = (powm << 1) % prime;
    };
    for (i = 0; i < m; i++) {
        PatternHash = ((PatternHash << 1) + (pattern[i]).charCodeAt(0)) % prime;
        TextHash = ((TextHash << 1) + (text[i]).charCodeAt(0)) % prime;
    };
    for (i = 0; i <= (n - m); i++) {
        if (TextHash === PatternHash) {
            for (j = 0; j < m; j++) {
                if (text[i + j] !== pattern[j]) {
                    break;
                }
            };
            if (j === m) return i;
        }
        TextHash = (((TextHash - (text[i]).charCodeAt(0) * powm) << 1) + (text[i + m]).charCodeAt(0)) % prime;
        if (TextHash < 0) {
            TextHash = (TextHash + prime);
        }
    };
    return -1;
}

function KMPPreprocess(pattern: string, ShiftArr: Array<number>) {
    let m: number = pattern.length;
    let i: number = 0;
    let j: number = -1;
    ShiftArr[i] = -1;
    while (i < m) {
        while (j >= 0 && pattern[i] !== pattern[j]) {
            j = ShiftArr[j];
        };
        i++;
        j++;
        ShiftArr[i] = j;
    };
}

function KMP(text: string, pattern: string): number {
    let i: number = 0;
    let j: number = 0;
    let n: number = text.length;
    let m: number = pattern.length;
    const ShiftArr = new Array(m + 1);
    KMPPreprocess(pattern, ShiftArr);
    while (i < n) {
        while (j >= 0 && text[i] !== pattern[j]) {
            j = ShiftArr[j]
        };
        i++;
        j++;
        if (j === m) {
            return (i - m);
        }
    };
    return -1;
}

function KMPFindCount(text: string, pattern: string): number {
    let i: number = 0;
    let j: number = 0;
    let count: number = 0;
    let n: number = text.length;
    let m: number = pattern.length;
    const ShiftArr = new Array(m + 1);
    KMPPreprocess(pattern, ShiftArr);
    while (i < n) {
        while (j >= 0 && text[i] !== pattern[j]) {
            j = ShiftArr[j];
        };
        i++;
        j++;
        if (j === m) {
            count++;
            j = ShiftArr[j];
        }
    };
    return count;
}

// Testing code.
let st1: string = "hello, world!";
let st2: string = "world";
console.log("BruteForceSearch return : " + BruteForceSearch(st1, st2));
console.log("RobinKarp return : " + RobinKarp(st1, st2));
console.log("KMP return : " + KMP(st1, st2));
