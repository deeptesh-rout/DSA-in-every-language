function printSubset(flags: boolean[], arr: number[], size: number): void {
    let result = "";
    for (let i = 0; i < size; i++) {
        if (flags[i]) {
            result += arr[i];
            result += " ";
        }
    }
    console.log(result);
}

function subsetSum(arr: number[], n: number, target: number): void {
    const flags: boolean[] = new Array(n).fill(false);
    subsetSumUtil(arr, n, flags, 0, 0, target);
}

function subsetSumUtil(arr: number[], n: number, flags: boolean[], sum: number, curr: number, target: number): void {
    if (target === sum) {
        printSubset(flags, arr, n); // Solution found.
        return;
    }

    if (curr >= n || sum > target) {
        // Constraint check and backtracking.
        return;
    }

    // Current element included.
    flags[curr] = true;
    subsetSumUtil(arr, n, flags, sum + arr[curr], curr + 1, target);
    flags[curr] = false; // Reset flag for backtracking.
    subsetSumUtil(arr, n, flags, sum, curr + 1, target);
}

// Testing code.
const arr: number[] = [15, 22, 14, 26, 32, 9, 16, 8];
const target: number = 53;
subsetSum(arr, arr.length, target);

/*
15 22 16 
15 14 16 8 
22 14 9 8 
*/
