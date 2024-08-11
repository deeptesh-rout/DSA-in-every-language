class PriorityQueue<T> {
	static CAPACITY: number = 32;
	size: number;
	arr: Array<T>;
	compare: (a: T, b: T) => boolean;

	constructor(cmp: (a: T, b: T) => boolean) {
		this.compare = cmp;
		this.arr = new Array<T>(PriorityQueue.CAPACITY);
		this.size = 0;
	}

	percolateDown(parent: number) {
		let lChild: number = 2 * parent + 1;
		let rChild: number = lChild + 1;
		let child: number = -1;
		let temp: T;
		if (lChild < this.size) {
			child = lChild;
		}
		if (rChild < this.size && this.compare(this.arr[lChild], this.arr[rChild])) {
			child = rChild;
		}
		if (child !== -1 && this.compare(this.arr[parent], this.arr[child])) {
			temp = this.arr[parent];
			this.arr[parent] = this.arr[child];
			this.arr[child] = temp;
			this.percolateDown(child);
		}
	}

	percolateUp(child: number) {
		let parent: number = Math.floor((child - 1) / 2);
		let temp: T;
		if (parent < 0) {
			return;
		}
		if (this.compare(this.arr[parent], this.arr[child])) {
			temp = this.arr[child];
			this.arr[child] = this.arr[parent];
			this.arr[parent] = temp;
			this.percolateUp(parent);
		}
	}

	add(value: T) {
		if (this.size === this.arr.length) {
			this.doubleSize();
		}

		this.arr[this.size++] = value;
		this.percolateUp(this.size - 1);
	}

	private doubleSize() {
		let old: Array<T> = this.arr;
		let newSize = this.size * 2;
		this.arr = new Array<T>(newSize);
		/* arraycopy */
		let size = this.size;
		for (let i = 0; i < size; i++) {
			this.arr[i] = old[i];
		}
	}

	remove(): T {
		if (this.isEmpty()) {
			throw new Error("IllegalStateException");
		}
		let value: T = this.arr[0];
		this.arr[0] = this.arr[this.size - 1];
		this.size--;
		this.percolateDown(0);
		return value;
	}

	printTree() {
		console.info(this.arr);
	}

	isEmpty(): boolean {
		return this.size === 0;
	}

	length(): number {
		return this.size;
	}

	peek(): T {
		if (this.isEmpty()) {
			throw new Error("IllegalStateException");
		}
		return this.arr[0];
	}
}

function reverse(cups: number[], size: number): void {
	let temp: number = 0;
	for (let i = 0, j = size - 1; i < j; i++, j--) {
		temp = cups[i];
		cups[i] = cups[j];
		cups[j] = temp;
	}
}

function chotaBhim(cups: number[]): number {
	const size: number = cups.length;
	let time: number = 60;
	cups.sort();
	reverse(cups, size);
	let total: number = 0;
	let index: number, temp: number;

	while (time > 0) {
		total += cups[0];
		cups[0] = Math.ceil(cups[0] / 2);
		index = 0;
		temp = cups[0];
		while (index < size - 1 && temp < cups[index + 1]) {
			cups[index] = cups[index + 1];
			index += 1;
		}
		cups[index] = temp;
		time -= 1;
	}
	console.log("Total: " + total);
	return total;
}

function chotaBhim2(cups: number[]): number {
	const size: number = cups.length;
	let time: number = 60;
	const pq: PriorityQueue<number> = new PriorityQueue<number>((a, b) => a < b);

	for (let i = 0; i < size; i++) {
		pq.add(cups[i]);
	}

	let total: number = 0;
	let value: number;
	while (time > 0) {
		value = pq.remove();
		total += value;
		value = Math.ceil(value / 2);
		pq.add(value);
		time -= 1;
	}
	console.log("Total: " + total);
	return total;
}

// Testing code.
const cups: number[] = [2, 1, 7, 4, 2];
chotaBhim(cups);
const cups2: number[] = [2, 1, 7, 4, 2];
chotaBhim2(cups2);

/*
Total: 76
Total: 76
*/
