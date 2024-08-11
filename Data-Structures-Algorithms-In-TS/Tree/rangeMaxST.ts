class RangeMaxST {
	private n: number;
	private segArr: number[];

	constructor(input: number[]) {
		this.n = input.length;
		const x = Math.ceil(Math.log2(this.n));
		const max_size = 2 * Math.pow(2, x) - 1;
		this.segArr = new Array(max_size).fill(0);
		this.constructST(input, 0, this.n - 1, 0);
	}

	private constructST(input: number[], start: number, end: number, index: number): number {
		if (start === end) {
			this.segArr[index] = input[start];
			return input[start];
		}

		const mid = Math.floor((start + end) / 2);
		this.segArr[index] = Math.max(
			this.constructST(input, start, mid, index * 2 + 1),
			this.constructST(input, mid + 1, end, index * 2 + 2)
		);
		return this.segArr[index];
	}

	public getMax(start: number, end: number): number {
		if (start > end || start < 0 || end > this.n - 1) {
			console.log("Invalid Input.");
			return Number.MIN_VALUE;
		}
		return this.getMaxUtil(0, this.n - 1, start, end, 0);
	}

	private getMaxUtil(segStart: number, segEnd: number, queryStart: number, queryEnd: number, index: number): number {
		if (queryStart <= segStart && segEnd <= queryEnd) {
			return this.segArr[index];
		}
		if (segEnd < queryStart || queryEnd < segStart) {
			return Number.MIN_VALUE;
		}
		const mid = Math.floor((segStart + segEnd) / 2);
		return Math.max(
			this.getMaxUtil(segStart, mid, queryStart, queryEnd, 2 * index + 1),
			this.getMaxUtil(mid + 1, segEnd, queryStart, queryEnd, 2 * index + 2)
		);
	}

	public update(ind: number, val: number): void {
		if (ind < 0 || ind > this.n - 1) {
			console.log("Invalid Input.");
			return;
		}
		this.updateUtil(0, this.n - 1, ind, val, 0);
	}

	private updateUtil(segStart: number, segEnd: number, ind: number, val: number, index: number): number {
		if (ind < segStart || ind > segEnd) {
			return this.segArr[index];
		}
		if (segStart === segEnd) {
			if (segStart === ind) {
				this.segArr[index] = val;
				return val;
			} else {
				return this.segArr[index];
			}
		}
		const mid = Math.floor((segStart + segEnd) / 2);
		this.segArr[index] = Math.max(
			this.updateUtil(segStart, mid, ind, val, 2 * index + 1),
			this.updateUtil(mid + 1, segEnd, ind, val, 2 * index + 2)
		);
		return this.segArr[index];
	}
}

// Testing code.
const arr = [1, 8, 2, 7, 3, 6, 4, 5];
const tree = new RangeMaxST(arr);
console.log("Max value in the range(1, 5): " + tree.getMax(1, 5));
console.log("Max value in the range(2, 7): " + tree.getMax(2, 7));
console.log("Max value of all the elements: " + tree.getMax(0, arr.length - 1));
tree.update(2, 9);
console.log("Max value in the range(1, 5): " + tree.getMax(1, 5));
console.log("Max value of all the elements: " + tree.getMax(0, arr.length - 1));

/*
Max value in the range(1, 5): 8
Max value in the range(2, 7): 7
Max value of all the elements: 8
Max value in the range(1, 5): 9
Max value of all the elements: 9
*/
