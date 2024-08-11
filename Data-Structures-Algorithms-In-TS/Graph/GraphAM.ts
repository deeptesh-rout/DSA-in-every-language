
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

    public add(value: T) {
        if (this.size === this.arr.length) {
            this.doubleSize();
        }

        this.arr[this.size++] = value;

        this.percolateUp(this.size - 1);
    }

    private doubleSize() {
        let old: Array<T> = this.arr;
        let newSize = this.size * 2;
        if (newSize === 0)
            newSize = 1;
        this.arr = new Array<T>(newSize);
        /* arraycopy */
        let size = this.size;
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
        this.percolateDown(0);
        return value;
    }

    public print() {
        console.log(this.arr);;
    }

    public isEmpty(): boolean {
        return (this.size === 0);
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

class Queue<T> {
    frontIndex: number;
    data: T[];

    public constructor() {
        this.frontIndex = 0;
        this.data = [];
    }

    public add(value: T) {
        this.data.push(value);
    }

    public remove(): T {
        let value = this.data[this.frontIndex];
        this.frontIndex++;
        if (this.data.length > 0 && this.frontIndex * 2 >= this.data.length) {
            this.data = this.data.slice(this.frontIndex);
            this.frontIndex = 0;
        }
        return value;
    }

    public peek(): T {
        let value = this.data[this.frontIndex];
        return value;
    }

    public isEmpty(): boolean {
        return (this.data.length - this.frontIndex) === 0;
    }

    public size(): number {
        return (this.data.length - this.frontIndex);
    }

    public peekLast(): T {
        return this.data[this.data.length - 1]
    }
}

const infi = 2147483647;

class GraphEdge {
    dest: number;
    cost: number;

    public constructor(dst: number, cst: number) {
        this.dest = dst;
        this.cost = cst;
    }
}

function EdgeComparator(x: GraphEdge, y: GraphEdge): boolean {
    return x.cost > y.cost
}

class Graph {
    count: number;
    adj: Array<Array<number>>;

    constructor(cnt: number) {
        if (cnt === undefined)
            throw new Error('Invalid argument')

        this.count = cnt;
        this.adj = new Array<Array<number>>(this.count)
        for (let i = 0; i < this.count; i++)
            this.adj[i] = new Array<number>(this.count).fill(0);
    }

    public addDirectedEdge(src: number, dst: number, cost: number = 1) {
        this.adj[src][dst] = cost;
    }

    public addUndirectedEdge(src: number, dst: number, cost: number = 1) {
        this.addDirectedEdge(src, dst, cost);
        this.addDirectedEdge(dst, src, cost);
    }

    public print() {
        for (let i: number = 0; i < this.count; i++) {
            let t = `Vertex ${i} is connected to : `;
            for (let j = 0; j < this.count; j++) {
                if (this.adj[i][j] !== 0)
                    t += j + "(cost: " + this.adj[i][j] + ") "
            }
            console.log(t)
        }
    }


    public dijkstra(source: number) {
        let previous: Array<number> = new Array<number>(this.count).fill(-1);
        let dist: Array<number> = new Array<number>(this.count).fill(infi);
        let visited: Array<boolean> = new Array<boolean>(this.count).fill(false);

        dist[source] = 0;
        previous[source] = source;

        let queue: PriorityQueue<GraphEdge> = new PriorityQueue<GraphEdge>(EdgeComparator);
        let node: GraphEdge = new GraphEdge(source, 0);
        queue.add(node);
        let curr: number;

        while (queue.isEmpty() === false) {
            node = queue.remove();
            curr = node.dest;
            visited[curr] = true;
            for (let dest: number = 0; dest < this.count; dest++) {
                let cost: number = this.adj[curr][dest];
                if (cost !== 0) {
                    let alt: number = cost + dist[curr];
                    if (dist[dest] > alt && visited[dest] === false) {
                        dist[dest] = alt;
                        previous[dest] = curr;
                        node = new GraphEdge(dest, alt);
                        queue.add(node);
                    }
                }
            };
        };
        this.printPath(previous, dist, this.count, source);
    }

    private printPathUtil(previous, source, dest): string {
        let path = "";
        if (dest === source) {
            path += source;
        } else {
            path += this.printPathUtil(previous, source, previous[dest]);
            path += "->" + dest;
        }
        return path;
    }

    private printPath(previous, dist, count, source): void {
        let output = "Shortest Paths: ";
        for (let i = 0; i < count; i++) {
            if (dist[i] === 99999) {
                output += "(" + source + "->" + i + " @ Unreachable) ";
            } else if (i !== previous[i]) {
                output += "(";
                output += this.printPathUtil(previous, source, i);
                output += " @ " + dist[i] + ") ";
            }
        }
        console.log(output);
    }


    public primsMST() {
        let previous: Array<number> = new Array<number>(this.count).fill(-1);
        let dist: Array<number> = new Array<number>(this.count).fill(0);
        let source: number = 0;
        let visited: Array<boolean> = new Array<boolean>(this.count).fill(false);
        for (let i: number = 0; i < this.count; i++) {
            previous[i] = -1;
            dist[i] = infi;
            visited[i] = false;
        };
        dist[source] = 0;
        previous[source] = -1;
        let queue: PriorityQueue<GraphEdge> = new PriorityQueue<GraphEdge>(EdgeComparator);
        let node: GraphEdge = new GraphEdge(source, 0);
        queue.add(node);
        let curr: number;

        while (queue.isEmpty() === false) {
            node = queue.remove();
            curr = node.dest;
            visited[curr] = true;

            for (let dest: number = 0; dest < this.count; dest++) {
                let cost: number = this.adj[curr][dest];
                if (cost !== 0) {
                    let alt: number = cost;
                    if (dist[dest] > alt && visited[dest] === false) {
                        dist[dest] = alt;
                        previous[dest] = curr;
                        node = new GraphEdge(dest, alt);
                        queue.add(node);
                    }
                }
            };
        };
        let total = 0;
        let output = "Edges are: ";
        for (let i = 0; i < this.count; i++) {
            if (dist[i] === Infinity) {
                output += `( ${i},  Unreachable)`
            } else if (previous[i] != i) {
                output += `(${previous[i]}->${i} @ ${dist[i]}) `
                total += dist[i];
            }
        }
        console.log(output);
        console.log(`Total MST cost: ${total}`)
    }


    private hamiltonianPathUtil(path: Array<number>, pSize: number, added: Array<number>): boolean {
        if (pSize === this.count) {
            return true;
        }
        for (let vertex: number = 0; vertex < this.count; vertex++) {
            if (pSize === 0 || (this.adj[path[pSize - 1]][vertex] === 1 && added[vertex] === 0)) {
                path[pSize++] = vertex;
                added[vertex] = 1;
                if (this.hamiltonianPathUtil(path, pSize, added)) return true;
                pSize--;
                added[vertex] = 0;
            }
        };
        return false;
    }

    public hamiltonianPath(): boolean {
        let path: Array<number> = new Array<number>(this.count).fill(0);
        let added: Array<number> = new Array<number>(this.count).fill(0);
        if (this.hamiltonianPathUtil(path, 0, added)) {
            console.log("Hamiltonian Path found :: " + path);
            return true;
        }
        console.log("Hamiltonian Path not found");
        return false;
    }

    private hamiltonianCycleUtil(path: Array<number>, pSize: number, added: Array<number>): boolean {
        if (pSize === this.count) {
            if (this.adj[path[pSize - 1]][path[0]] === 1) {
                path[pSize] = path[0];
                return true;
            } else return false;
        }
        for (let vertex: number = 0; vertex < this.count; vertex++) {
            if (pSize === 0 || (this.adj[path[pSize - 1]][vertex] === 1 && added[vertex] === 0)) {
                path[pSize++] = vertex;
                added[vertex] = 1;
                if (this.hamiltonianCycleUtil(path, pSize, added)) return true;
                pSize--;
                added[vertex] = 0;
            }
        }
        return false;
    }

    public hamiltonianCycle(): boolean {
        let path: Array<number> = new Array<number>(this.count + 1).fill(0);
        let added: Array<number> = new Array<number>(this.count).fill(0);

        if (this.hamiltonianCycleUtil(path, 0, added)) {
            console.log("Hamiltonian Cycle found :: " + path);
            return true;
        }
        console.log("Hamiltonian Cycle not found");
        return false;
    }
}

/* Testing Code */
function test1() {
    const graph = new Graph(4);
    graph.addUndirectedEdge(0, 1);
    graph.addUndirectedEdge(0, 2);
    graph.addUndirectedEdge(1, 2);
    graph.addUndirectedEdge(2, 3);
    graph.print();
}

/*
Vertex 0 is connected to : 1(cost: 1) 2(cost: 1) 
Vertex 1 is connected to : 0(cost: 1) 2(cost: 1) 
Vertex 2 is connected to : 0(cost: 1) 1(cost: 1) 3(cost: 1) 
Vertex 3 is connected to : 2(cost: 1) 
*/

/* Testing Code */
function test2() {
    const gph = new Graph(9);
    gph.addUndirectedEdge(0, 1, 4);
    gph.addUndirectedEdge(0, 7, 8);
    gph.addUndirectedEdge(1, 2, 8);
    gph.addUndirectedEdge(1, 7, 11);
    gph.addUndirectedEdge(2, 3, 7);
    gph.addUndirectedEdge(2, 8, 2);
    gph.addUndirectedEdge(2, 5, 4);
    gph.addUndirectedEdge(3, 4, 9);
    gph.addUndirectedEdge(3, 5, 14);
    gph.addUndirectedEdge(4, 5, 10);
    gph.addUndirectedEdge(5, 6, 2);
    gph.addUndirectedEdge(6, 7, 1);
    gph.addUndirectedEdge(6, 8, 6);
    gph.addUndirectedEdge(7, 8, 7);
    console.log("")
    gph.primsMST();
    console.log("")
}

/*
Edges are (0->1 @ 4) (5->2 @ 4) (2->3 @ 7) (3->4 @ 9) (6->5 @ 2) (7->6 @ 1) (0->7 @ 8) (2->8 @ 2) 
Total MST cost : 37
*/

/* Testing Code */
function test3() {
    const gph = new Graph(9);
    gph.addUndirectedEdge(0, 1, 4)
    gph.addUndirectedEdge(0, 7, 8)
    gph.addUndirectedEdge(1, 2, 8)
    gph.addUndirectedEdge(1, 7, 11)
    gph.addUndirectedEdge(2, 3, 7)
    gph.addUndirectedEdge(2, 8, 2)
    gph.addUndirectedEdge(2, 5, 4)
    gph.addUndirectedEdge(3, 4, 9)
    gph.addUndirectedEdge(3, 5, 14)
    gph.addUndirectedEdge(4, 5, 10)
    gph.addUndirectedEdge(5, 6, 2)
    gph.addUndirectedEdge(6, 7, 1)
    gph.addUndirectedEdge(6, 8, 6)
    gph.addUndirectedEdge(7, 8, 7)
    gph.dijkstra(1);
}

/*
Shortest Paths: (1->0 @ 4) (1->2 @ 8) (1->2->3 @ 15) (1->2->5->4 @ 22) (1->2->5 @ 12) (1->7->6 @ 12) (1->7 @ 11) (1->2->8 @ 10) 
*/

/* Testing Code */
function test4() {
    const count = 5;
    const graph = new Graph(count);
    const adj =
        [[0, 1, 0, 1, 0],
        [1, 0, 1, 1, 0],
        [0, 1, 0, 0, 1],
        [1, 1, 0, 0, 1],
        [0, 1, 1, 1, 0]];

    for (let i = 0; i < count; i++) {
        for (let j = 0; j < count; j++) {
            if (adj[i][j] === 1)
                graph.addDirectedEdge(i, j, 1);
        }
    }

    console.log(`hamiltonianPath : ${graph.hamiltonianPath()}`);

    const graph2 = new Graph(count);
    const adj2 =
        [[0, 1, 0, 1, 0],
        [1, 0, 1, 1, 0],
        [0, 1, 0, 0, 1],
        [1, 1, 0, 0, 0],
        [0, 1, 1, 0, 0]];

    for (let i = 0; i < count; i++) {
        for (let j = 0; j < count; j++) {
            if (adj2[i][j] === 1)
                graph2.addDirectedEdge(i, j, 1);
        }
    }
    console.log(`hamiltonianPath :  ${graph2.hamiltonianPath()}`);
}

/*
Hamiltonian Path found ::  [ 0, 1, 2, 4, 3 ]
hamiltonianPath : true

Hamiltonian Path found ::  [ 0, 3, 1, 2, 4 ]
hamiltonianPath :  true
*/

/* Testing Code */
function test5() {
    const count = 5;
    const graph = new Graph(count);
    const adj =
        [[0, 1, 0, 1, 0],
        [1, 0, 1, 1, 0],
        [0, 1, 0, 0, 1],
        [1, 1, 0, 0, 1],
        [0, 1, 1, 1, 0]];

    for (let i = 0; i < count; i++) {
        for (let j = 0; j < count; j++) {
            if (adj[i][j] === 1)
                graph.addDirectedEdge(i, j, 1);
        }
    }

    console.log(`hamiltonianCycle : ${graph.hamiltonianCycle()}`);

    const graph2 = new Graph(count);
    const adj2 =
        [[0, 1, 0, 1, 0],
        [1, 0, 1, 1, 0],
        [0, 1, 0, 0, 1],
        [1, 1, 0, 0, 0],
        [0, 1, 1, 0, 0]];

    for (let i = 0; i < count; i++) {
        for (let j = 0; j < count; j++) {
            if (adj2[i][j] === 1)
                graph2.addDirectedEdge(i, j, 1);
        }
    }
    console.log(`hamiltonianCycle :  ${graph2.hamiltonianCycle()}`);
}

/*
Hamiltonian Cycle found ::  [ 0, 1, 2, 4, 3, 0 ]
hamiltonianCycle : true

Hamiltonian Cycle not found
hamiltonianCycle :  false
*/

test1()
test2()
test3()
test4()
test5()
