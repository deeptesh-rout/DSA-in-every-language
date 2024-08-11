const greater = (value1: number, value2: number): boolean => value1 > value2;

function shellSort(arr: number[]): void {
    let n = arr.length;

    // Gap starts with n/2 and halves in each iteration.
    for (let gap = Math.floor(n / 2); gap > 0; gap = Math.floor(gap / 2)) {
        // Do a gapped insertion sort.
        for (let i = gap; i < n; i += 1) {
            let curr = arr[i];

            // Shift elements of the already sorted list to find the right position for the current value.
            let j = 0;
            for (j = i; j >= gap && greater(arr[j - gap], curr); j -= gap) {
                arr[j] = arr[j - gap];
            }

            // Put the current value in its correct location.
            arr[j] = curr;
        }
    }
}

// Testing code.
let array: number[] = [36, 32, 11, 6, 19, 31, 17, 3];
shellSort(array);
console.log(JSON.stringify(array));

/*
[3,6,11,17,19,31,32,36]
*/
