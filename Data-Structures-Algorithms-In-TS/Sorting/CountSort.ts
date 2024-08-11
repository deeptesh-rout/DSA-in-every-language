function countSort(arr: number[], lowerRange: number, upperRange: number): void {
    let i = 0, j = 0;
    let size = arr.length;
    let range = upperRange - lowerRange + 1;
    let count = Array(range).fill(0);

    for (i = 0; i < size; i++) {
        count[arr[i] - lowerRange]++;
    }

    for (i = 0; i < range; i++) {
        for (; count[i] > 0; count[i]--) {
            arr[j++] = i + lowerRange;
        }
    }
}

// Testing code.
let array: number[] = [2, 6, 4, 1, 5, 8, 1, 4, 6, 1];
countSort(array, 0, 9);
console.log(JSON.stringify(array));

/*
[1,1,1,2,4,4,5,6,6,8]
*/
