type Comparator<T> = (a: T, b: T) => boolean;
const greater = <T>(x: T, y: T): boolean => x > y;
const less = <T>(x: T, y: T): boolean => x < y;

class Heap<T> {
    private arr: T[];
    private size: number;
    private comp: Comparator<T>;

    constructor(array?: any, cmp: Comparator<T> = greater) {
        this.comp = cmp;

        if (array === null || array === undefined) {
            this.arr = [];
            this.size = 0;
        } else {
            this.arr = array;
            this.size = array.length;

            for (let i = Math.floor(this.size / 2); i >= 0; i--) {
                this.percolateDown(i);
            }
        }
    }
    
    public print(): void {
        console.log(this.arr);
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


    private percolateDown(parent: number): void {
        const lChild = 2 * parent + 1;
        const rChild = lChild + 1;
        let child = -1;
        let temp: T;

        if (lChild <= this.size) {
            child = lChild;
        }
        if (rChild <= this.size && this.comp(this.arr[lChild], this.arr[rChild])) {
            child = rChild;
        }
        if (child !== -1 && this.comp(this.arr[parent], this.arr[child])) {
            temp = this.arr[parent];
            this.arr[parent] = this.arr[child];
            this.arr[child] = temp;
            this.percolateDown(child);
        }
    }

    private percolateUp(child: number): void {
        const parent = Math.floor((child - 1) / 2);
        if (parent < 0) {
            return;
        }
        if (this.comp(this.arr[parent], this.arr[child])) {
            const temp = this.arr[child];
            this.arr[child] = this.arr[parent];
            this.arr[parent] = temp;
            this.percolateUp(parent);
        }
    }

    public add(value: T): void {
        this.arr[this.size] = value;
        this.size++;
        this.percolateUp(this.size - 1);
    }

    public remove(): T {
        if (this.isEmpty()) {
            throw new Error("IllegalStateException");
        }
        const value = this.arr[0];
        this.arr[0] = this.arr[this.size - 1];
        this.size--;
        this.percolateDown(0);
        return value;
    }



    public find(val: T): boolean {
        for (let i = 0; i < this.size; i++) {
            if (this.arr[i] === val) {
                return true;
            }
        }
        return false;
    }

    public delete(value: T): boolean {
        for (let i = 0; i < this.size; i++) {
            if (this.arr[i] === value) {
                this.arr[i] = this.arr[this.size - 1];
                this.size -= 1;
                this.percolateUp(i);
                this.percolateDown(i);
                return true;
            }
        }
        return false;
    }
}

// Testing code.
function test1(): void {
    let hp1 = new Heap<number>(); // default is minheap.
    hp1.add(1);
    hp1.add(4);
    hp1.add(2);
    hp1.add(3);
    hp1.print();
    while (hp1.isEmpty() === false) {
        console.log(hp1.remove());
    }

    hp1 = new Heap<number>([], less); // default is maxheap.
    hp1.add(1);
    hp1.add(4);
    hp1.add(2);
    hp1.add(3);
    hp1.print();
    while (hp1.isEmpty() === false) {
        console.log(hp1.remove());
    }

    hp1 = new Heap<number>([], greater); // default is minheap.
    hp1.add(1);
    hp1.add(4);
    hp1.add(2);
    hp1.add(3);
    hp1.print();
    while (hp1.isEmpty() === false) {
        console.log(hp1.remove());
    }
}


//test1()

/*
[ 1, 3, 2, 4 ]
1
2
3
4
*/


// Testing code.
function test2(): void {
    const a: number[] = [1, 2, 4, 5, 3];
    const hp = new Heap<number>(a); // Min Heap
    hp.print();
    while (hp.isEmpty() === false) {
        console.log(hp.remove());
    }
}

//test2();

/*
[ 1, 2, 4, 5, 3 ]
1
2
3
4
5
*/

// Testing code.
function test3(): void {
    const a: number[] = [1, 2, 4, 5, 3];
    const hp = new Heap<number>(a, less); // Max Heap
    hp.print();
    while (hp.isEmpty() === false) {
        console.log(hp.remove());
    }
}

//test3();
/*
[ 5, 3, 4, 2, 1 ]
5
4
3
2
1
*/

function HeapSort<T>(array: T[], cmp: Comparator<T>): void {
    const hp = new Heap<T>(array, cmp);
    for (let i = 0; i < array.length; i++) {
        array[array.length - i - 1] = hp.remove();
    }
}

// Testing code.
function test4(): void {
    const b: number[] = [6, 5, 3, 4, 1, 2];
    HeapSort<number>(b, less); // Increasing Order
    console.log(b);

    HeapSort<number>(b, greater); // Decreasing Order
    console.log(b);
}

//test4();
/*
[ 1, 2, 3, 4, 5, 6 ]
[ 6, 5, 4, 3, 2, 1 ]
*/

function kthSmallest(arr: number[], size: number, k: number): number {
    arr = arr.sort();
    return arr[k - 1];
}

function kthSmallest2(arr: number[], size: number, k: number): number {
    let value = 0;
    const pq = new Heap<number>(arr);
    let i = 0;
    while (i < size && i < k) {
        value = pq.remove();
        i += 1;
    }
    return value;
}

function kthSmallest3(arr: number[], size: number, k: number): number {
    const pq = new Heap<number>([], less);
    for (let i = 0; i < size; i++) {
        if (i < k) {
            pq.add(arr[i]);
        } else {
            if (pq.peek() > arr[i]) {
                pq.add(arr[i]);
                pq.remove();
            }
        }
    }
    return pq.peek();
}

function swap(arr: number[], i: number, j: number): void {
    const temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}

function QuickSelectUtil(arr: number[], lower: number, upper: number, k: number): void {
    if (upper <= lower) {
        return;
    }
    const pivot = arr[lower];
    const start = lower;
    const stop = upper;

    while (lower < upper) {
        while (lower < upper && arr[lower] <= pivot) {
            lower++;
        }
        while (lower <= upper && arr[upper] > pivot) {
            upper--;
        }
        if (lower < upper) {
            swap(arr, upper, lower);
        }
    }

    swap(arr, upper, start);
    if (k < upper) {
        QuickSelectUtil(arr, start, upper - 1, k);
    }
    if (k > upper) {
        QuickSelectUtil(arr, upper + 1, stop, k);
    }
}

function kthSmallest4(arr: number[], size: number, k: number): number {
    QuickSelectUtil(arr, 0, size - 1, k);
    return arr[k - 1];
}

// Testing code.
function test5(): void {
    const arr: number[] = [8, 7, 6, 5, 7, 5, 2, 1];
    console.log(`Kth Smallest: ${kthSmallest(arr, arr.length, 3)}`);
    const arr2: number[] = [8, 7, 6, 5, 7, 5, 2, 1];
    console.log(`Kth Smallest: ${kthSmallest2(arr2, arr2.length, 3)}`);
    const arr3: number[] = [8, 7, 6, 5, 7, 5, 2, 1];
    console.log(`Kth Smallest: ${kthSmallest3(arr3, arr3.length, 3)}`);
    const arr4: number[] = [8, 7, 6, 5, 7, 5, 2, 1];
    console.log(`Kth Smallest: ${kthSmallest4(arr4, arr4.length, 3)}`);
}

//test5();

/*
Kth Smallest: 5
Kth Smallest: 5
Kth Smallest: 5
Kth Smallest: 5
*/

function isMinHeap(arr: number[]): boolean {
    const size = arr.length;
    const mid = Math.floor((size - 2) / 2);

    for (let i = 0; i <= mid; i++) {
        if (2 * i + 1 < size) {
            if (arr[i] > arr[2 * i + 1]) {
                return false;
            }
        }
        if (2 * i + 2 < size) {
            if (arr[i] > arr[2 * i + 2]) {
                return false;
            }
        }
    }
    return true;
}

function isMaxHeap(arr: number[]): boolean {
    const size = arr.length;
    const mid = Math.floor((size - 2) / 2);

    for (let i = 0; i <= mid; i++) {
        if (2 * i + 1 < size && arr[i] < arr[2 * i + 1]) {
            return false;
        }

        if (2 * i + 2 < size && arr[i] < arr[2 * i + 2]) {
            return false;
        }
    }
    return true;
}

// Testing code.
function test6(): void {
    const arr3: number[] = [8, 7, 6, 5, 7, 5, 2, 1];
    console.log(`isMaxHeap: ${isMaxHeap(arr3)}`);
    const arr4: number[] = [1, 2, 3, 4, 5, 6, 7, 8];
    console.log(`isMinHeap: ${isMinHeap(arr4)}`);
}

//test6();
/*
isMaxHeap: true
isMinHeap: true
*/

function kSmallestProduct(arr: number[], size: number, k: number): number {
    arr = arr.sort();
    let product = 1;
    for (let i = 0; i < k; i++) {
        product *= arr[i];
    }
    return product;
}

function kSmallestProduct2(arr: number[], size: number, k: number): number {
    QuickSelectUtil(arr, 0, size - 1, k);
    let product = 1;
    for (let i = 0; i < k; i++) {
        product *= arr[i];
    }
    return product;
}

function kSmallestProduct3(arr: number[], size: number, k: number): number {
    const pq = new Heap<number>([], less);
    for (let i = 0; i < size; i++) {
        if (i < k) {
            pq.add(arr[i]);
        } else {
            if (pq.peek() > arr[i]) {
                pq.add(arr[i]);
                pq.remove();
            }
        }
    }
    let product = 1;
    for (let i = 0; i < k; i++) {
        product *= pq.remove();
    }
    return product;
}

function kSmallestProduct4(arr: number[], size: number, k: number): number {
    const pq = new Heap<number>(arr);
    let i = 0;
    let product = 1;
    while (i < size && i < k) {
        product *= pq.remove();
        i += 1;
    }
    return product;
}

// Testing code.
function test7(): void {
    const arr: number[] = [8, 7, 6, 5, 7, 5, 2, 1];
    console.log(`Kth Smallest product: ${kSmallestProduct(arr, 8, 4)}`);
    const arr2: number[] = [8, 7, 6, 5, 7, 5, 2, 1];
    console.log(`Kth Smallest product: ${kSmallestProduct2(arr2, 8, 4)}`);
    const arr3: number[] = [8, 7, 6, 5, 7, 5, 2, 1];
    console.log(`Kth Smallest product: ${kSmallestProduct3(arr3, 8, 4)}`);
    const arr4: number[] = [8, 7, 6, 5, 7, 5, 2, 1];
    console.log(`Kth Smallest product: ${kSmallestProduct4(arr4, 8, 4)}`);
}

//test7();

/*
Kth Smallest product: 50
Kth Smallest product: 50
Kth Smallest product: 50
*/

function PrintLargerHalf(arr: number[], size: number): void {
    arr = arr.sort();
    let output: string = "";
    for (let i = Math.floor(size / 2); i < size; i++) {
        output += ` ${arr[i]} `;
    }
    console.log(output);
}

function PrintLargerHalf2(arr: number[], size: number): void {
    const pq = new Heap<number>(arr);
    for (let i = 0; i < size / 2; i++) {
        pq.remove();
    }
    let output: string = "";
    while (pq.isEmpty() === false) {
        output += ` ${pq.remove()} `;
    }
    console.log(output);
}

function PrintLargerHalf3(arr: number[], size: number): void {
    QuickSelectUtil(arr, 0, size - 1, size / 2);
    let output: string = "";
    for (let i = size / 2; i < size; i++) {
        output += ` ${arr[i]} `;
    }
    console.log(output);
}

// Testing code.
function test8(): void {
    const arr: number[] = [8, 7, 6, 4, 7, 5, 2, 1];
    PrintLargerHalf(arr, 8);
    const arr2: number[] = [8, 7, 6, 4, 7, 5, 2, 1];
    PrintLargerHalf2(arr2, 8);
    const arr3: number[] = [8, 7, 6, 4, 7, 5, 2, 1];
    PrintLargerHalf3(arr3, 8);
}

//test8();

/*
6 7 7 8
6 7 7 8
6 7 7 8
*/

function sortK(arr: number[], size: number, k: number): void {
    const pq = new Heap<number>();
    let i = 0;
    for (i = 0; i < k; i++) {
        pq.add(arr[i]);
    }

    let index = 0;
    for (i = k; i < size; i++) {
        arr[index++] = pq.remove();
        pq.add(arr[i]);
    }

    while (pq.isEmpty() === false) {
        arr[index++] = pq.remove();
    }

    console.log(arr);
}

// Testing code.
function test9(): void {
    const k = 3;
    const arr: number[] = [1, 5, 4, 10, 50, 9];
    const size = arr.length;
    sortK(arr, size, k);
}

//test9();

/*
[ 1, 4, 5, 9, 10, 50 ]
*/

function ChotaBhim(cups: number[], size: number): number {
    let time = 60;
    let total = 0;
    let index;
    let temp;
    cups.sort();

    while (time > 0) {
        total += cups[0];
        cups[0] = Math.ceil(cups[0] / 2.0);
        index = 0;
        temp = cups[0];
        while (index < size - 1 && temp < cups[index + 1]) {
            cups[index] = cups[index + 1];
            index += 1;
        }
        cups[index] = temp;
        time -= 1;
    }
    console.log(`Total : ${total}`);
    return total;
}

function ChotaBhim2(cups: number[], size: number): number {
    let time = 60;
    let total = 0;
    let value;
    const pq = new Heap<number>(cups, (a, b) => a < b);

    while (time > 0) {
        value = pq.remove();
        total += value;
        value = Math.ceil(value / 2.0);
        pq.add(value);
        time -= 1;
    }
    console.log(`Total : ${total}`);
    return total;
}

// Testing code.
function test10() {
    const cups = [2, 1, 7, 4, 2];
    ChotaBhim(cups, cups.length);
    const cups2 = [2, 1, 7, 4, 2];
    ChotaBhim2(cups2, cups.length);
}

//test10();

/*
Total : 76
Total : 76
*/

function JoinRopes(ropes: number[], size: number): number {
    console.log(ropes)
    ropes.sort().reverse();
    console.log(ropes)
    let total = 0;
    let value = 0;
    let index;
    let length = size;

    while (length >= 2) {
        value = ropes[length - 1] + ropes[length - 2];
        total += value;
        index = length - 2;
        while (index > 0 && ropes[index - 1] < value) {
            ropes[index] = ropes[index - 1];
            index -= 1;
        }
        ropes[index] = value;
        length--;
    }
    console.log(`Total join cost: ${total}`);
    return total;
}

function JoinRopes2(ropes: number[], size: number): number {
    const pq = new Heap<number>(ropes, (a, b) => a > b);
    let total = 0;
    let value = 0;

    while (pq.length() > 1) {
        value = pq.remove();
        value += pq.remove();
        pq.add(value);
        total += value;
    }
    console.log(`Total join cost: ${total}`);
    return total;
}

// Testing code.
function test11() {
    const ropes = [2, 1, 7, 4, 2];
    JoinRopes(ropes, ropes.length);
    const rope2 = [2, 1, 7, 4, 2];
    JoinRopes2(rope2, rope2.length);
}

test11();

/*
Total : 33
Total : 33
*/

class MedianHeap {
    private minHeap: Heap<number>;
    private maxHeap: Heap<number>;

    constructor() {
        this.minHeap = new Heap<number>([], (a, b) => a > b);
        this.maxHeap = new Heap<number>([], (a, b) => a < b);
    }

    insert(value: number): void {
        if (this.maxHeap.isEmpty() === true || this.maxHeap.peek() >= value) {
            this.maxHeap.add(value);
        } else {
            this.minHeap.add(value);
        }

        if (this.maxHeap.length() > this.minHeap.length() + 1) {
            value = this.maxHeap.remove()!;
            this.minHeap.add(value);
        }

        if (this.minHeap.length() > this.maxHeap.length() + 1) {
            value = this.minHeap.remove()!;
            this.maxHeap.add(value);
        }
    }

    getMedian(): number | undefined {
        if (this.maxHeap.isEmpty() === true && this.minHeap.isEmpty() === true) {
            return undefined;
        }

        if (this.maxHeap.length() === this.minHeap.length()) {
            return Math.floor((this.maxHeap.peek()! + this.minHeap.peek()!) / 2);
        } else if (this.maxHeap.length() > this.minHeap.length()) {
            return this.maxHeap.peek();
        } else {
            return this.minHeap.peek();
        }
    }
}

// Testing code.
function test12() {
    const arr = [1, 9, 2, 8, 3, 7];
    const hp = new MedianHeap();
    for (let i = 0; i < arr.length; i++) {
        hp.insert(arr[i]);
        console.log(`Median after insertion of ${arr[i]} is  ${hp.getMedian()}`);
    }
}

test12();

/*
Median after insertion of 1 is 1
Median after insertion of 9 is 5
Median after insertion of 2 is 2
Median after insertion of 8 is 5
Median after insertion of 3 is 3
Median after insertion of 7 is 5
*/
