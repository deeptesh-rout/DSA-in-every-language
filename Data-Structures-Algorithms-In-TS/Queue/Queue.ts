class Deque<T> {
    private arr: T[];

    constructor() {
        this.arr = [];
    }

    size(): number {
        return this.arr.length;
    }

    add(val: T): void {
        this.arr.push(val);
    }

    remove(): T | undefined {
        return this.arr.shift();
    }

    front(): T | undefined {
        return this.arr[0];
    }

    back(): T | undefined {
        return this.arr[this.arr.length - 1];
    }

    removeLast(): T | undefined {
        return this.arr.pop();
    }
}

class Queue<T> {
    private arr: T[];

    constructor() {
        this.arr = [];
    }

    add(value: T): void {
        this.arr.push(value);
    }

    remove(): T | undefined {
        const value = this.arr[0];
        this.arr.shift();
        return value;
    }

    front(): T | undefined {
        return this.arr[0];
    }

    back(): T | undefined {
        return this.arr[this.arr.length - 1];
    }

    isEmpty(): boolean {
        return this.arr.length === 0;
    }

    size(): number {
        return this.arr.length;
    }

    print() : void {
        console.log(this.arr)
    }
}

function main0() {
    let que: Queue<number> = new Queue<number>();
    que.add(1);
    que.add(2);
    que.add(3);
    que.print();
    console.log("isEmpty: " + que.isEmpty());
    console.log("size: " + que.size());
    console.log("Queue remove: " + que.remove());
    console.log("Queue remove: " + que.remove());
}

main0();

/*
[ 1, 2, 3 ]
isEmpty: false
size: 3
Queue remove: 1
Queue remove: 2
*/


function CircularTour(arr: number[][], n: number): number {
    for (let i = 0; i < n; i++) {
        let total = 0;
        let found = true;
        for (let j = 0; j < n; j++) {
            total += arr[(i + j) % n][0] - arr[(i + j) % n][1];
            if (total < 0) {
                found = false;
                break;
            }
        }
        if (found) {
            return i;
        }
    }
    return -1;
}

function CircularTour2(arr: number[][], n: number): number {
    let que: Queue<number> = new Queue<number>();
    let nextPump = 0,
        prevPump = 0;
    let count = 0,
        petrol = 0;
    while (que.size() !== n) {
        while (petrol >= 0 && que.size() !== n) {
            que.add(nextPump);
            petrol += arr[nextPump][0] - arr[nextPump][1];
            nextPump = (nextPump + 1) % n;
        }
        while (petrol < 0 && que.size() > 0) {
            prevPump = que.remove();
            petrol -= arr[prevPump][0] - arr[prevPump][1];
        }
        count += 1;
        if (count === n) {
            return -1;
        }
    }
    if (petrol >= 0) {
        return que.remove();
    } else {
        return -1;
    }
}

// Testing code.
function test1() {
    const tour: number[][] = [[8, 6], [1, 4], [7, 6]];
    console.log(`Circular Tour: ${CircularTour(tour, 3)}`);
    console.log(`Circular Tour: ${CircularTour2(tour, 3)}`);
}

test1();
/*
Circular Tour: 2
Circular Tour: 2
*/

function convertXY(src: number, dst: number): number {
    let que: Queue<number> = new Queue<number>();
    let arr: Array<number> = new Array<number>(100);
    let steps: number = 0;
    let index: number = 0;
    let value: number;
    que.add(src);
    while (que.size() !== 0) {
        value = que.remove();
        arr[index++] = value;
        if (value === dst) {
            console.log("Steps countr: " + steps);
            return steps;
        }
        steps++;
        if (value < dst)
            que.add(value * 2);
        else
            que.add(value - 1);
    };
    return -1;
}

function test2() {
    convertXY(2, 7);
}

test2()
/*
Steps countr :: 3
*/

function maxSlidingWindows(arr: number[], size: number, k: number): void {
    let output = "";
    for (let i = 0; i < size - k + 1; i++) {
        let max = arr[i];
        for (let j = 1; j < k; j++) {
            max = Math.max(max, arr[i + j]);
        }
        output += (max + " ");
    }
    console.log(output);
}

function maxSlidingWindows2(arr: Array<number>, size: number, k: number) {
    let que: Deque<number> = new Deque<number>();
    let output = "";
    for (let i = 0; i < size; i++) {
        if (que.size() > 0 && que.front() <= i - k)
            que.remove();
        while (que.size() > 0 && arr[que.back()] <= arr[i]) {
            que.removeLast();
        }
        que.add(i);
        if (i >= (k - 1))
            output += (`${arr[que.front()]} `);
    }
    console.log(output);
}

// Testing code.
function test3() {
    const arr = [11, 2, 75, 92, 59, 90, 55];
    const k = 3;
    maxSlidingWindows(arr, 7, 3);
    maxSlidingWindows2(arr, 7, 3);

}

test3()

/*
75 92 92 92 90 
75 92 92 92 90 
*/

function minOfMaxSlidingWindows(arr: Array<number>, size: number, k: number): number {
    let que: Queue<number> = new Queue<number>();
    let minVal: number = 999999;
    for (let i = 0; i < size; i++) {
        if (que.size() > 0 && que.front() <= i - k)
            que.remove();
        while (que.size() > 0 && arr[que.back()] <= arr[i]) {
            que.remove();
        };
        que.add(i);
        if (i >= (k - 1) && minVal > arr[que.front()])
            minVal = arr[que.front()];
    }
    console.log(`Min of max is: ${minVal}`);
    return minVal;
}

function test4() {
    let arr: Array<number> = [11, 2, 75, 92, 59, 90, 55];
    let k: number = 3;
    minOfMaxSlidingWindows(arr, 7, 3);
}

test4()

/*
Min of max is: 75
*/

const NEGATIVE_INFI = -2147483647;
function maxOfMinSlidingWindows(arr: Array<number>, size: number, k: number): number {
    let que: Queue<number> = new Queue<number>();
    let maxVal: number = NEGATIVE_INFI;
    for (let i = 0; i < size; i++) {
        if (que.size() > 0 && que.front() <= i - k)
            que.remove();
        while (que.size() > 0 && arr[que.back()] >= arr[i]) {
            que.remove();
        };
        que.add(i);
        if (i >= (k - 1) && maxVal < arr[que.front()])
            maxVal = arr[que.front()];
    }
    console.log("Max of min is: " + maxVal);
    return maxVal;
}

function test5() {
    let arr: Array<number> = [11, 2, 75, 92, 59, 90, 55];
    let k: number = 3;
    maxOfMinSlidingWindows(arr, 7, 3);
}

test5()

/*
Max of min is: 59
*/

function firstNegSlidingWindows(arr: Array<number>, size: number, k: number) {
    let que: Queue<number> = new Queue<number>();
    let output: string = "";
    for (let i = 0; i < size; i++) {
        if (que.size() > 0 && que.front() <= i - k)
            que.remove();
        if (arr[i] < 0)
            que.add(i);
        if (i >= (k - 1)) {
            if (que.size() > 0)
                output += (`${arr[que.front()]} `);
            else
                output += ("NAN ");
        }
    }
    console.log(output);
}

function test6() {
    let arr: Array<number> = [3, -2, -6, 10, -14, 50, 14, 21, 11, -2, -11, 2, 3];
    let k: number = 3;
    firstNegSlidingWindows(arr, 13, 3);
}
test6();

function josephus(n: number, k: number): number {
    const que = new Queue<number>();
    for (let i = 0; i < n; i++) {
        que.add(i + 1);
    }

    while (que.size() > 1) {
        for (let i = 0; i < k - 1; i++) {
            que.add(que.remove());
        }
        que.remove(); // Kth person executed.
    }

    return que.front();
}

// Testing code.
console.log("Position: " + josephus(11, 5));

function rottenFruitUtil(
    arr: number[][],
    maxCol: number,
    maxRow: number,
    currCol: number,
    currRow: number,
    traversed: number[][],
    day: number
): void {
    const dir = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    let x: number, y: number;
    for (let i = 0; i < 4; i++) {
        x = currCol + dir[i][0];
        y = currRow + dir[i][1];
        if (
            x >= 0 &&
            x < maxCol &&
            y >= 0 &&
            y < maxRow &&
            traversed[x][y] > day + 1 &&
            arr[x][y] == 1
        ) {
            traversed[x][y] = day + 1;
            rottenFruitUtil(arr, maxCol, maxRow, x, y, traversed, day + 1);
        }
    }
}

const Max_Int = 2147483647;

function rottenFruit(arr: number[][], maxCol: number, maxRow: number): number {
    const traversed: number[][] = Array(maxRow);
    for (let i = 0; i < maxRow; i++) {
        traversed[i] = Array(maxCol).fill(Max_Int);
    }

    for (let i = 0; i < maxCol - 1; i++) {
        for (let j = 0; j < maxRow - 1; j++) {
            if (arr[i][j] === 2) {
                traversed[i][j] = 0;
                rottenFruitUtil(arr, maxCol, maxRow, i, j, traversed, 0);
            }
        }
    }

    let maxDay = 0;
    for (let i = 0; i < maxCol - 1; i++) {
        for (let j = 0; j < maxRow - 1; j++) {
            if (arr[i][j] === 1) {
                if (traversed[i][j] === Max_Int) return -1;
                if (maxDay < traversed[i][j]) maxDay = traversed[i][j];
            }
        }
    }

    return maxDay;
}

class Fruit {
    constructor(public x: number, public y: number, public day: number) { }
}

function rottenFruit2(arr: number[][], maxCol: number, maxRow: number): number {
    const traversed: boolean[][] = Array(maxRow);
    for (let j = 0; j < maxRow; j++)
        traversed[j] = Array(maxCol).fill(false);

    const dir = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const que = new Queue<Fruit>();
    for (let i = 0; i < maxCol; i++) {
        for (let j = 0; j < maxRow; j++) {
            if (arr[i][j] == 2) {
                que.add(new Fruit(i, j, 0));
                traversed[i][j] = true;
            }
        }
    }
    let max = 0,
        x: number,
        y: number,
        day: number,
        temp: Fruit;
    while (!que.isEmpty()) {
        temp = que.remove();
        for (let i = 0; i < 4; i++) {
            x = temp.x + dir[i][0];
            y = temp.y + dir[i][1];
            day = temp.day + 1;
            if (
                x >= 0 &&
                x < maxCol &&
                y >= 0 &&
                y < maxRow &&
                arr[x][y] != 0 &&
                traversed[x][y] == false
            ) {
                que.add(new Fruit(x, y, day));
                max = Math.max(max, day);
                traversed[x][y] = true;
            }
        }
    }
    for (let i = 0; i < maxCol; i++) {
        for (let j = 0; j < maxRow; j++) {
            if (arr[i][j] == 1 && traversed[i][j] == false) {
                return -1;
            }
        }
    }
    return max;
}

// Testing code.
function test22() {
    const arr = [
        [1, 0, 1, 1, 0],
        [2, 1, 0, 1, 0],
        [0, 0, 0, 2, 1],
        [0, 2, 0, 0, 1],
        [1, 1, 0, 0, 1],
    ];

    console.log("rottenFruit:", rottenFruit(arr, 5, 5));
    console.log("rottenFruit:", rottenFruit2(arr, 5, 5));
}

test22();

/*
rottenFruit: 3
rottenFruit: 3
*/


function stepsOfKnightUtil(size: number, currCol: number, currRow: number, traversed: number[][], dist: number): void {
    const dir: [number, number][] = [[-2, -1], [-2, 1], [2, -1], [2, 1], [-1, -2], [1, -2], [-1, 2], [1, 2]];
    let x: number, y: number;
    for (let i = 0; i < 8; i++) {
        x = currCol + dir[i][0];
        y = currRow + dir[i][1];
        if (x >= 0 && x < size && y >= 0 && y < size && traversed[x][y] > dist + 1) {
            traversed[x][y] = dist + 1;
            stepsOfKnightUtil(size, x, y, traversed, dist + 1);
        }
    }
}

function stepsOfKnight(size: number, srcX: number, srcY: number, dstX: number, dstY: number): number {
    const traversed: number[][] = Array(size);
    for (let i = 0; i < size; i++) {
        traversed[i] = Array(size).fill(Max_Int);
    }
    traversed[srcX - 1][srcY - 1] = 0;
    stepsOfKnightUtil(size, srcX - 1, srcY - 1, traversed, 0);
    return traversed[dstX - 1][dstY - 1];
}

class Knight {
    constructor(public x: number, public y: number, public cost: number) { }
}

function stepsOfKnight2(size: number, srcX: number, srcY: number, dstX: number, dstY: number): number {
    const traversed: number[][] = Array(size);
    for (let j = 0; j < size; j++) {
        traversed[j] = Array(size).fill(Max_Int);
    }

    const dir: [number, number][] = [[-2, -1], [-2, 1], [2, -1], [2, 1], [-1, -2], [1, -2], [-1, 2], [1, 2]];
    const que = new Queue<Knight>();
    que.add(new Knight(srcX - 1, srcY - 1, 0));
    traversed[srcX - 1][srcY - 1] = 0;

    let x: number, y: number, cost: number, temp: Knight;
    while (!que.isEmpty()) {
        temp = que.remove();
        for (let i = 0; i < 8; i++) {
            x = temp.x + dir[i][0];
            y = temp.y + dir[i][1];
            cost = temp.cost + 1;
            if (x >= 0 && x < size && y >= 0 && y < size && traversed[x][y] > cost) {
                que.add(new Knight(x, y, cost));
                traversed[x][y] = cost;
            }
        }
    }
    return traversed[dstX - 1][dstY - 1];
}

// Testing code.
function test23() {
    console.log("stepsOfKnight:", stepsOfKnight(20, 10, 10, 20, 20));
    console.log("stepsOfKnight:", stepsOfKnight2(20, 10, 10, 20, 20));
}

test23();

/*
stepsOfKnight: 8
stepsOfKnight: 8
*/

function distNearestFillUtil(arr: number[][], maxCol: number, maxRow: number, currCol: number, currRow: number, traversed: number[][], dist: number): void {
    const dir: [number, number][] = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    let x: number, y: number;
    for (let i = 0; i < 4; i++) {
        x = currCol + dir[i][0];
        y = currRow + dir[i][1];
        if (x >= 0 && x < maxCol && y >= 0 && y < maxRow && traversed[x][y] > dist + 1) {
            traversed[x][y] = dist + 1;
            distNearestFillUtil(arr, maxCol, maxRow, x, y, traversed, dist + 1);
        }
    }
}

function distNearestFill(arr: number[][], maxCol: number, maxRow: number): void {
    const traversed: number[][] = Array(maxRow);
    for (let i = 0; i < maxRow; i++) {
        traversed[i] = Array(maxCol).fill(Max_Int);
    }

    for (let i = 0; i < maxCol; i++) {
        for (let j = 0; j < maxRow; j++) {
            if (arr[i][j] === 1) {
                traversed[i][j] = 0;
                distNearestFillUtil(arr, maxCol, maxRow, i, j, traversed, 0);
            }
        }
    }

    for (let i = 0; i < maxCol; i++) {
        console.log(traversed[i]);
    }
}

class DNode {
    x: number;
    y: number;
    dist: number;

    constructor(a: number, b: number, d: number) {
        this.x = a;
        this.y = b;
        this.dist = d;
    }
}

function distNearestFill2(arr: number[][], maxCol: number, maxRow: number): void {
    const traversed: number[][] = Array(maxRow);
    for (let i = 0; i < maxRow; i++) {
        traversed[i] = Array(maxCol).fill(Max_Int);
    }

    const dir: [number, number][] = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const que = new Queue<DNode>();
    for (let i = 0; i < maxCol; i++) {
        for (let j = 0; j < maxRow; j++) {
            if (arr[i][j] == 1) {
                que.add(new DNode(i, j, 0));
                traversed[i][j] = 0;
            }
        }
    }

    let x: number, y: number, dist: number, temp: DNode;
    while (!que.isEmpty()) {
        temp = que.remove();
        for (let i = 0; i < 4; i++) {
            x = temp.x + dir[i][0];
            y = temp.y + dir[i][1];
            dist = temp.dist + 1;
            if (x >= 0 && x < maxCol && y >= 0 && y < maxRow && traversed[x][y] > dist) {
                que.add(new DNode(x, y, dist));
                traversed[x][y] = dist;
            }
        }
    }
    for (let i = 0; i < maxCol; i++) {
        console.log(traversed[i]);
    }
}

// Testing code.
function test24() {
    const arr: number[][] = [
        [1, 0, 1, 1, 0],
        [1, 1, 0, 1, 0],
        [0, 0, 0, 0, 1],
        [0, 0, 0, 0, 1],
        [0, 0, 0, 0, 1]
    ];

    distNearestFill(arr, 5, 5);
    console.log();
    distNearestFill2(arr, 5, 5);
}

test24();
/*
[ 0, 1, 0, 0, 1 ]
[ 0, 0, 1, 0, 1 ]
[ 1, 1, 2, 1, 0 ]
[ 2, 2, 2, 1, 0 ]
[ 3, 3, 2, 1, 0 ]
*/

function findLargestIslandUtil(arr: number[][], maxCol: number, maxRow: number, currCol: number, currRow: number, traversed: boolean[][]): number {
    const dir: [number, number][] = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]];
    let x: number, y: number, sum: number = 1;
    for (let i = 0; i < 8; i++) {
        x = currCol + dir[i][0];
        y = currRow + dir[i][1];

        if (x >= 0 && x < maxCol && y >= 0 && y < maxRow && traversed[x][y] === false && arr[x][y] === 1) {
            traversed[x][y] = true;
            sum += findLargestIslandUtil(arr, maxCol, maxRow, x, y, traversed);
        }
    }
    return sum;
}

function findLargestIsland(arr: number[][], maxCol: number, maxRow: number): number {
    const traversed: boolean[][] = Array(maxRow);
    for (let i = 0; i < maxRow; i++) {
        traversed[i] = Array(maxCol).fill(false);
    }

    let maxVal: number = 0, currVal: number = 0;

    for (let i = 0; i < maxCol; i++) {
        for (let j = 0; j < maxRow; j++) {
            if (arr[i][j] === 1) {
                traversed[i][j] = true;
                currVal = findLargestIslandUtil(arr, maxCol, maxRow, i, j, traversed);
                if (currVal > maxVal) {
                    maxVal = currVal;
                }
            }
        }
    }
    return maxVal;
}

// Testing code.
function test25(): void {
    const arr: number[][] = [
        [1, 0, 1, 1, 0],
        [1, 0, 0, 1, 0],
        [0, 1, 1, 1, 1],
        [0, 1, 0, 0, 0],
        [1, 1, 0, 0, 1]
    ];

    console.log(`Largest Island: ${findLargestIsland(arr, 5, 5)}`);
}

test25();

/*
Largest Island: 12
*/
