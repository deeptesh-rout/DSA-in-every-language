function less(value1: number, value2: number): boolean {
    return value1 < value2;
}

function more(value1: number, value2: number): boolean {
    return value1 > value2;
}

function BubbleSort(arr: Array<number>) {
    let size: number = arr.length;
    let i: number;
    let j: number;
    let temp: number;
    for (i = 0; i < (size - 1); i++) {
        for (j = 0; j < size - i - 1; j++) {
            if (more(arr[j], arr[j + 1])) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

function BubbleSort2(arr: Array<number>) {
    let size: number = arr.length;
    let i: number;
    let j: number;
    let temp: number;
    let swapped: number = 1;
    for (i = 0; i < (size - 1) && swapped === 1; i++) {
        swapped = 0;
        for (j = 0; j < size - i - 1; j++) {
            if (more(arr[j], arr[j + 1])) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
                swapped = 1;
            }
        }
    }
}

// Testing code.
let array: Array<number> = [9, 1, 8, 2, 7, 3, 6, 4, 5];
BubbleSort(array);
console.log(array);

let array2: Array<number> = [9, 1, 8, 2, 7, 3, 6, 4, 5];
BubbleSort2(array2);
console.log(array2);
