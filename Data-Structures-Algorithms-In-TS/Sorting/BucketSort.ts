function bucketSort(arr: number[], maxValue: number): void {
    let numBucket = 5;
    bucketSortUtil(arr, maxValue, numBucket);
}

function bucketSortUtil(arr: number[], maxValue: number, numBucket: number): void {
    let length = arr.length;
    if (length === 0) {
        return;
    }
    let bucket: number[][] = [];

    for (let i = 0; i < numBucket; i++) {
        bucket.push([]);
    }

    let div = Math.ceil(maxValue / numBucket);

    for (let i = 0; i < length; i++) {
        if (arr[i] < 0 || arr[i] > maxValue) {
            console.log("Value out of range.");
            return;
        }

        let bucketIndex = Math.floor(arr[i] / div);

        if (bucketIndex >= numBucket)
            bucketIndex = numBucket - 1;
        bucket[bucketIndex].push(arr[i]);
    }

    for (let i = 0; i < numBucket; i++) {
        bucket[i].sort((a, b) => a - b);
    }

    let index = 0, count = 0;
    for (let i = 0; i < numBucket; i++) {
        let temp = bucket[i];
        count = temp.length;
        for (let j = 0; j < count; j++) {
            arr[index++] = temp[j];
        }
    }
}

// Testing code.
let array: number[] = [1, 34, 7, 99, 5, 23, 45, 88, 77, 19, 91, 100];
let maxValue: number = 100;
bucketSort(array, maxValue);
console.log(JSON.stringify(array));

/*
[1,5,7,19,23,34,45,77,88,91,99,100]
*/
