class SegmentTree {
	private size: number;
	private segArr: number[];

	constructor(input: number[]) {
		this.size = input.length;
		const x = Math.ceil(Math.log2(this.size));
		const max_size = 2 * Math.pow(2, x) - 1;
		this.segArr = new Array(max_size).fill(0);
		this.constructST(input, 0, this.size - 1, 0);
	}

	private constructST(input: number[], start: number, end: number, index: number): number {
		if (start === end) {
			this.segArr[index] = input[start];
			return input[start];
		}

		const mid = Math.floor((start + end) / 2);
		this.segArr[index] = this.constructST(input, start, mid, index * 2 + 1) + this.constructST(input, mid + 1, end, index * 2 + 2);
		return this.segArr[index];
	}

	public getSum(start: number, end: number): number {
		if (start > end || start < 0 || end > this.size - 1) {
			console.log("Invalid Input.");
			return -1;
		}
		return this.getSumUtil(0, this.size - 1, start, end, 0);
	}

	private getSumUtil(segStart: number, segEnd: number, queryStart: number, queryEnd: number, index: number): number {
		if (queryStart <= segStart && segEnd <= queryEnd) {
			return this.segArr[index];
		}
		if (segEnd < queryStart || queryEnd < segStart) {
			return 0;
		}
		const mid = Math.floor((segStart + segEnd) / 2);
		return (
			this.getSumUtil(segStart, mid, queryStart, queryEnd, 2 * index + 1) +
			this.getSumUtil(mid + 1, segEnd, queryStart, queryEnd, 2 * index + 2)
		);
	}

	public set(arr: number[], ind: number, val: number): void {
		if (ind < 0 || ind > this.size - 1) {
			console.log("Invalid Input.");
			return;
		}
		arr[ind] = val;
		this.setUtil(0, this.size - 1, ind, val, 0);
	}

	private setUtil(segStart: number, segEnd: number, ind: number, val: number, index: number): number {
		if (ind < segStart || ind > segEnd) {
			return 0;
		}
		if (segStart === segEnd) {
			if (segStart === ind) {
				const diff = val - this.segArr[index];
				this.segArr[index] = val;
				return diff;
			} else {
				return 0;
			}
		}
		const mid = Math.floor((segStart + segEnd) / 2);
		const diff =
			this.setUtil(segStart, mid, ind, val, 2 * index + 1) +
			this.setUtil(mid + 1, segEnd, ind, val, 2 * index + 2);
		this.segArr[index] = this.segArr[index] + diff;
		return diff;
	}
}

// Testing code.
const arr = [1, 2, 4, 8, 16, 32, 64];
const tree = new SegmentTree(arr);
console.log("Sum of values in the range(0, 3): " + tree.getSum(1, 3));
console.log("Sum of values of all the elements: " + tree.getSum(0, arr.length - 1));
tree.set(arr, 1, 10);
console.log("Sum of values in the range(0, 3): " + tree.getSum(1, 3));
console.log("Sum of values of all the elements: " + tree.getSum(0, arr.length - 1));

/*
Sum of values in the range(0, 3): 14
Sum of values of all the elements: 127
Sum of values in the range(0, 3): 22
Sum of values of all the elements: 135
*/
