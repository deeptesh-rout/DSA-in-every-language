
function quickSelect(arr: Array<number>, lower: number, upper: number, k: number) {
    if (upper <= lower) return;
    let pivot: number = arr[lower];
    let start: number = lower;
    let stop: number = upper;
    while ((lower < upper)) {
        while ((arr[lower] <= pivot && lower < upper)) {
            lower++;
        };
        while ((arr[upper] > pivot && lower <= upper)) {
            upper--;
        };
        if (lower < upper) {
            swap(arr, upper, lower);
        }
    };
    swap(arr, upper, start);
    if (k < upper) quickSelect(arr, start, upper - 1, k);
    if (k > upper) quickSelect(arr, upper + 1, stop, k);
}

function swap(arr: Array<number>, first: number, second: number) {
    let temp: number = arr[first];
    arr[first] = arr[second];
    arr[second] = temp;
}

function QuickSelect(arr: Array<number>, k: number): number {
    quickSelect(arr, 0, arr.length - 1, k - 1);
    return arr[k - 1];
}

// Testing code.
let array: Array<number> = [3, 4, 2, 1, 6, 5, 7, 8, 10, 9];
console.log("value at index 5 is: " + QuickSelect(array, 5));
