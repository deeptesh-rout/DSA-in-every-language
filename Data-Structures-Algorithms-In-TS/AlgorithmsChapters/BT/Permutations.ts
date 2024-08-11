
function swap(arr: number[], i: number, j: number): void {
    const temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}

function permutation(arr: number[], i: number, length: number): void {
    if (length === i) {
        console.log(arr);
        return;
    }

    for (let j = i; j < length; j++) {
        swap(arr, i, j);
        permutation(arr, i + 1, length);
        swap(arr, i, j);
    }
}

function isValid(arr: number[], n: number): boolean {
    for (let j = 1; j < n; j++) {
        if (Math.abs(arr[j] - arr[j - 1]) < 2) {
            return false;
        }
    }
    return true;
}

function permutation2(arr: number[], i: number, length: number): void {
    if (length === i) {
        if (isValid(arr, length)) {
            console.log(arr);
        }
        return;
    }

    for (let j = i; j < length; j++) {
        swap(arr, i, j);
        permutation2(arr, i + 1, length);
        swap(arr, i, j);
    }
}

function isValid2(arr: number[], i: number): boolean {
    if (i < 1 || Math.abs(arr[i] - arr[i - 1]) >= 2) {
        return true;
    }
    return false;
}

function permutation3(arr: number[], i: number, length: number): void {
    if (length === i) {
        console.log(arr);
        return;
    }

    for (let j = i; j < length; j++) {
        swap(arr, i, j);
        if (isValid2(arr, i)) {
            permutation3(arr, i + 1, length);
        }
        swap(arr, i, j);
    }
}

/* Testing code */
const arr: number[] = [1, 2, 3, 4];
permutation(arr, 0, 4);
console.log();
permutation2(arr, 0, 4);
console.log();
permutation3(arr, 0, 4);


/*
[ 1, 2, 3, 4 ]
[ 1, 2, 4, 3 ]
...
[ 4, 1, 3, 2 ]
[ 4, 1, 2, 3 ]
*/
/*
[ 2, 4, 1, 3 ]
[ 3, 1, 4, 2 ]

[ 2, 4, 1, 3 ]
[ 3, 1, 4, 2 ]

*/
