function more(value1: number, value2: number): boolean {
    return value1 > value2;
}

function SelectionSort(arr: Array<number>) {
    let size: number = arr.length;
    let i: number;
    let j: number;
    let max: number;
    let temp: number;
    for (i = 0; i < size - 1; i++) {
        max = 0;
        for (j = 1; j < size - i; j++) {
            if (arr[j] > arr[max]) {
                max = j;
            }
        }
        temp = arr[size - 1 - i];
        arr[size - 1 - i] = arr[max];
        arr[max] = temp;
    }
}

function SelectionSort2(arr: Array<number>) {
    let size: number = arr.length;
    let i: number;
    let j: number;
    let min: number;
    let temp: number;
    for (i = 0; i < size - 1; i++) {
        min = i;
        for (j = i + 1; j < size; j++) {
            if (arr[j] < arr[min]) {
                min = j;
            }
        }
        temp = arr[i];
        arr[i] = arr[min];
        arr[min] = temp;
    }
}

// Testing code.
let array: Array<number> = [9, 1, 8, 2, 7, 3, 6, 4, 5];
SelectionSort(array);
console.log(array);

console.log();
let array2: Array<number> = [9, 1, 8, 2, 7, 3, 6, 4, 5];
SelectionSort2(array2);
console.log(array2);

