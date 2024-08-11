function more(value1: number, value2: number): boolean {
    return value1 > value2;
}

function InsertionSort(arr: Array<number>) {
    let size: number = arr.length;
    let temp: number;
    let j: number;
    for (let i: number = 1; i < size; i++) {
        temp = arr[i];
        for (j = i; j > 0 && more(arr[j - 1], temp); j--) {
            arr[j] = arr[j - 1];
        }
        arr[j] = temp;
    }
}

// Testing code.
let array: Array<number> = [9, 1, 8, 2, 7, 3, 6, 4, 5];
InsertionSort(array);
console.log(array);
