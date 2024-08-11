function makePairs(nuts: number[], bolts: number[]): void {
	makePairsUtil(nuts, bolts, 0, nuts.length - 1);
	console.log("Matched nuts and bolts are:", nuts, bolts);
}

function makePairsUtil(nuts: number[], bolts: number[], low: number, high: number): void {
	if (low < high) {
		const pivot = partition(nuts, low, high, bolts[low]);
		partition(bolts, low, high, nuts[pivot]);
		makePairsUtil(nuts, bolts, low, pivot - 1);
		makePairsUtil(nuts, bolts, pivot + 1, high);
	}
}

function swap(arr: number[], first: number, second: number): void {
	const temp = arr[first];
	arr[first] = arr[second];
	arr[second] = temp;
}

function partition(arr: number[], low: number, high: number, pivot: number): number {
	let i = low;
	for (let j = low; j < high; j++) {
		if (arr[j] < pivot) {
			swap(arr, i, j);
			i++;
		} else if (arr[j] === pivot) {
			swap(arr, high, j);
			j--;
		}
	}
	swap(arr, i, high);
	return i;
}

// Testing code.
const nuts = [1, 2, 6, 5, 4, 3];
const bolts = [6, 4, 5, 1, 3, 2];
makePairs(nuts, bolts);


/*
Matched nuts and bolts are: [ 1, 2, 3, 4, 5, 6 ] [ 1, 2, 3, 4, 5, 6 ] 
*/