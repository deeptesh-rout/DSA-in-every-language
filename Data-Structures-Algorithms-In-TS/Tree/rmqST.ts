class RmqST {
	private n: number;
	private segArr: number[];

	constructor(input: number[]) {
		this.n = input.length;
		const x = Math.ceil(Math.log2(this.n));
		const maxSize = 2 * Math.pow(2, x) - 1;
		this.segArr = new Array(maxSize).fill(0);
		this.constructST(input, 0, this.n - 1, 0);
	}

	private constructST(input: number[], start: number, end: number, index: number): number {
		if (start === end) {
			this.segArr[index] = input[start];
			return input[start];
		}

		const mid = Math.floor((start + end) / 2);
		this.segArr[index] = Math.min(
			this.constructST(input, start, mid, index * 2 + 1),
			this.constructST(input, mid + 1, end, index * 2 + 2)
		);
		return this.segArr[index];
	}

	public getMin(start: number, end: number): number {
		if (start > end || start < 0 || end > this.n - 1) {
			console.log("Invalid Input.");
			return Number.MAX_VALUE;
		}
		return this.getMinUtil(0, this.n - 1, start, end, 0);
	}

	private getMinUtil(segStart: number, segEnd: number, queryStart: number, queryEnd: number, index: number): number {
		if (queryStart <= segStart && segEnd <= queryEnd) {
			return this.segArr[index];
		}
		if (segEnd < queryStart || queryEnd < segStart) {
			return Number.MAX_VALUE;
		}
		const mid = Math.floor((segStart + segEnd) / 2);
		return Math.min(
			this.getMinUtil(segStart, mid, queryStart, queryEnd, 2 * index + 1),
			this.getMinUtil(mid + 1, segEnd, queryStart, queryEnd, 2 * index + 2)
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
		this.segArr[index] = Math.min(
			this.updateUtil(segStart, mid, ind, val, 2 * index + 1),
			this.updateUtil(mid + 1, segEnd, ind, val, 2 * index + 2)
		);
		return this.segArr[index];
	}
}

// Testing code.
const arr = [2, 3, 1, 7, 12, 5];
const tree = new RmqST(arr);
console.log("Min value in the range(1, 5): " + tree.getMin(1, 5));
console.log("Min value of all the elements: " + tree.getMin(0, arr.length - 1));
tree.update(2, -1);
console.log("Min value in the range(1, 5): " + tree.getMin(1, 5));
console.log("Min value of all the elements: " + tree.getMin(0, arr.length - 1));
tree.update(5, -2);
console.log("Min value in the range(0, 4): " + tree.getMin(0, 4));
console.log("Min value of all the elements: " + tree.getMin(0, arr.length - 1));

/*
Min value in the range(1, 5): 1
Min value of all the elements: 1
Min value in the range(1, 5): -1
Min value of all the elements: -1
Min value in the range(0, 4): -1
Min value of all the elements: -2
*/
