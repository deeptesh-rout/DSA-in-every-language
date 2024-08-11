const greater = (x: number, y: number): boolean => (x > y);
const less = (x: number, y: number): boolean => (x < y);


class PriorityQueue<T> {
	static CAPACITY: number = 32;
	size: number;
	arr: Array<T>;
	compare: (a: T, b: T) => boolean;

	public constructor(cmp: (a: T, b: T) => boolean) {
		this.compare = cmp;
		this.arr = new Array<T>(PriorityQueue.CAPACITY);
		this.size = 0;
	}

	proclateDown(parent: number) {
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
			this.proclateDown(child);
		}
	}

	proclateUp(child: number) {
		let parent: number = Math.floor((child - 1) / 2);
		let temp: T;
		if (parent < 0) {
			return;
		}
		if (this.compare(this.arr[parent], this.arr[child])) {
			temp = this.arr[child];
			this.arr[child] = this.arr[parent];
			this.arr[parent] = temp;
			this.proclateUp(parent);
		}
	}

	public add(value: T) {
		if (this.size === this.arr.length) {
			this.doubleSize();
		}

		this.arr[this.size++] = value;
		this.proclateUp(this.size - 1);
	}

	private doubleSize() {
		let old: Array<T> = this.arr;
		let newSize = this.size * 2;
		this.arr = new Array<T>(newSize);
		/* arraycopy */
		var size = this.size;
		for (let i = 0; i < size; i++) {
			this.arr[i] = old[i];
		}
	}

	public remove(): T {
		if (this.isEmpty()) {
			throw new Error("IllegalStateException");
		}
		let value: T = this.arr[0];
		this.arr[0] = this.arr[this.size - 1];
		this.size--;
		this.proclateDown(0);
		return value;
	}

	public PrintTree() {
		console.info(this.arr);
	}

	public isEmpty(): boolean {
		return this.size === 0;
	}

	public length(): number {
		return this.size;
	}

	public peek(): T {
		if (this.isEmpty()) {
			throw new Error("IllegalStateException");
		}
		return this.arr[0];
	}
}


// Testing code
function test1(): void {
    let hp1 = new PriorityQueue<number>(greater); // default is minheap.
    hp1.add(1);
    hp1.add(4);
    hp1.add(2);
    hp1.add(3);
    while (hp1.isEmpty() === false) {
        console.log(hp1.remove());
    }

    hp1 = new PriorityQueue<number>(less); // default is maxheap.
    hp1.add(1);
    hp1.add(4);
    hp1.add(2);
    hp1.add(3);
    while (hp1.isEmpty() === false) {
        console.log(hp1.remove());
    }

    hp1 = new PriorityQueue<number>(greater); // default is minheap.
    hp1.add(1)
    hp1.add(4)
    hp1.add(2)
    hp1.add(3)
    while (hp1.isEmpty() == false) {
        console.log(hp1.remove())
    }
}

test1()

/*
[ 1, 3, 2, 4 ]
1
2
3
4
*/

