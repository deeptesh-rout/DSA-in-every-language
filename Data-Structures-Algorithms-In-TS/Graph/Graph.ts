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

class Sets {
	parent: number;
	rank: number;
	
	constructor(p: number, r: number) {
	    this.parent = p;
	    this.rank = r;
	}
}

// Get root of set
function find(sets: Sets[], index: number): number {
	let p = sets[index].parent;
	while (p !== index) {
	    index = p;
	    p = sets[index].parent;
	}
	return index;
}

// Consider x and y are roots of sets.
function union(sets: Sets[], x: number, y: number): void {
	if (sets[x].rank < sets[y].rank) {
	    sets[x].parent = y;
	} else if (sets[y].rank < sets[x].rank) {
	    sets[y].parent = x;
	} else {
	    sets[x].parent = y;
	    sets[y].rank++;
	}
}

function find1(parent: number[], index: number): number {
	let p = parent[index];
	while (p !== -1) {
	    index = p;
	    p = parent[index];
	}
	return index;
}

function union1(parent: number[], x: number, y: number): void {
	parent[y] = x;
}


class GraphEdge {
    src: number;
    dest: number;
    cost: number;

    public constructor(src: number, dst: number, cst: number) {
        this.src = src;
        this.dest = dst;
        this.cost = cst;
    }
}

function EdgeComparator(a: GraphEdge, b: GraphEdge): boolean {
    return (a.cost - b.cost > 0);
}


class Graph {
    count: number;
    adj: Array<Array<GraphEdge>>;

    public constructor(cnt: number) {
        if (cnt === undefined)
            throw new Error('Invalid argument')

        this.count = cnt;
        this.adj = new Array(cnt);
        for (let i = 0; i < cnt; i++) {
            this.adj[i] = new Array()
        }
    }

    public addDirectedEdge(source: number, dest: number, cost: number = 1) {
        let edge: GraphEdge = new GraphEdge(source, dest, cost);
        this.adj[source].push(edge);
    }

    public addUndirectedEdge(source: number, dest: number, cost: number = 1) {
        this.addDirectedEdge(source, dest, cost);
        this.addDirectedEdge(dest, source, cost);
    }

    public print(): void {
        for (let i = 0; i < this.count; i++) {
            const ad = this.adj[i];
            let output = "";
            output += `Vertex ${i} is connected to: `;
            for (let j = 0; j < ad.length; j++) {
                const adn = ad[j];
                output += `${adn.dest}(cost: ${adn.cost}) `;
            }
            console.log(output);
        }
    }

    public dfsStack(source: number, target: number): boolean {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        let stk: Array<number> = new Array<number>();
        const path: Array<number> = new Array<number>();
        stk.push(source);
        visited[source] = true;
        while (stk.length !== 0) {
            let curr: number
            curr = stk.pop()!;
            path.push(curr);
            let adl: Array<GraphEdge> = this.adj[curr];
            for (let index = 0; index < adl.length; index++) {
                let adn = adl[index];
                if (visited[adn.dest] === false) {
                    visited[adn.dest] = true;
                    stk.push(adn.dest);
                }
            }
        }
        console.log("DFS Path is : " + path)
        return visited[target];
    }

    public dfs(source: number, target: number): boolean {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        const path: Array<number> = new Array<number>();
        this.dfsUtil(source, visited, path);
        console.log("DFS Path is:", path)
        return visited[target];
    }

    private dfsUtil(index: number, visited: Array<boolean>, path: Array<number>) {
        visited[index] = true;
        let adl: Array<GraphEdge> = this.adj[index];
        path.push(index);
        for (let index = 0; index < adl.length; index++) {
            let adn = adl[index];
            if (visited[adn.dest] === false)
                this.dfsUtil(adn.dest, visited, path);
        }
    }

    private dfsUtil2(index: number, visited: Array<boolean>, stk: Array<number>) {
        visited[index] = true;
        let adl: Array<GraphEdge> = this.adj[index];
        for (let index = 0; index < adl.length; index++) {
            let adn = adl[index];
            if (visited[adn.dest] === false) {
                this.dfsUtil2(adn.dest, visited, stk);
            }
        }
        stk.push(index);
    }

    private dfsUtil3(index: number, visited: boolean[]): void {
        visited[index] = true;
        const adl = this.adj[index];
        for (let i = 0; i < adl.length; i++) {
            const adn = adl[i];
            if (!visited[adn.dest]) {
                this.dfsUtil3(adn.dest, visited);
            }
        }
    }

    public bfs(source: number, target: number): boolean {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        let que: Queue<number> = new Queue<number>();
        const path: Array<number> = new Array<number>();
        que.add(source);
        visited[source] = true;
        while (que.isEmpty() === false) {
            let curr = que.remove();
            path.push(curr);
            let adl: Array<GraphEdge> = this.adj[curr];
            for (let index = 0; index < adl.length; index++) {
                let adn = adl[index];
                if (visited[adn.dest] === false) {
                    visited[adn.dest] = true;
                    que.add(adn.dest);
                }
            }
        }
        console.log("BFS Path is:", path)
        return visited[target];
    }

    public topologicalSort(): void {
        const stk: number[] = [];
        const count = this.count;
        const visited: boolean[] = new Array(count).fill(false);
        const output: number[] = [];

        for (let i = 0; i < count; i++) {
            if (visited[i] === false) {
                this.dfsUtil2(i, visited, stk);
            }
        }

        while (stk.length !== 0) {
            output.push(stk.pop()!);
        }

        console.log("Topological sort: " + output);
    }


    public pathExist(source: number, dest: number): boolean {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        this.dfsUtil3(source, visited);
        return visited[dest];
    }

    public countAllPathDFS(visited: Array<boolean>, source: number, dest: number): number {
        if (source === dest) {
            return 1;
        }
        let count: number = 0;
        visited[source] = true;
        let adl: Array<GraphEdge> = this.adj[source];
        for (let index = 0; index < adl.length; index++) {
            let adn = adl[index];
            if (visited[adn.dest] === false) {
                count += this.countAllPathDFS(visited, adn.dest, dest);
            }
            visited[source] = false;
        }
        return count;
    }

    public countAllPath(src: number, dest: number): number {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        return this.countAllPathDFS(visited, src, dest);
    }

    public printAllPathDFS(visited: Array<boolean>, source: number, dest: number, path: Array<number>) {
        path.push(source);
        if (source === dest) {
            console.log(path);
            path.pop();
            return;
        }
        visited[source] = true;
        let adl: Array<GraphEdge> = this.adj[source];
        for (let index = 0; index < adl.length; index++) {
            let adn = adl[index];
            if (visited[adn.dest] === false) {
                this.printAllPathDFS(visited, adn.dest, dest, path);
            }
        }
        visited[source] = false;
        path.pop();
    }

    public printAllPath(src: number, dest: number) {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        let path: Array<number> = new Array<number>();
        this.printAllPathDFS(visited, src, dest, path);
    }

    public rootVertex(): number {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        let retVal: number = -1;
        for (let i: number = 0; i < count; i++) {
            if (visited[i] === false) {
                this.dfsUtil3(i, visited);
                retVal = i;
            }
        }
        console.log("Root vertex is :: " + retVal);
        return retVal;
    }

    private transitiveClosureUtil(source: number, dest: number, tc: Array<Array<number>>) {
        tc[source][dest] = 1;
        let adl: Array<GraphEdge> = this.adj[dest];
        for (let index = 0; index < adl.length; index++) {
            let adn = adl[index];
            if (tc[source][adn.dest] === 0)
                this.transitiveClosureUtil(source, adn.dest, tc);
        }
    }

    public transitiveClosure(): Array<Array<number>> {
        const count: number = this.count;
        let tc: Array<Array<number>> = new Array<Array<number>>(count);
        for (let i: number = 0; i < count; i++) {
            tc[i] = new Array<number>(count).fill(0);
        }
        for (let i: number = 0; i < count; i++) {
            this.transitiveClosureUtil(i, i, tc);
        }
        return tc;
    }

    public bfsLevelNode(source: number) {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        let level: Array<number> = new Array<number>(count);
        visited[source] = true;
        let que: Queue<number> = new Queue<number>();;
        que.add(source);
        level[source] = 0;
        console.log("Node  - Level");
        while (que.isEmpty() === false) {
            let curr = que.remove();
            let depth: number = level[curr];
            let adl: Array<GraphEdge> = this.adj[curr];
            console.log(curr + " - " + depth);
            for (let index = 0; index < adl.length; index++) {
                let adn = adl[index];

                if (visited[adn.dest] === false) {
                    visited[adn.dest] = true;
                    que.add(adn.dest);
                    level[adn.dest] = depth + 1;
                }

            }
        }
    }

    public bfsDistance(source: number, dest: number): number {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        let que: Queue<number> = new Queue<number>();;
        que.add(source);
        visited[source] = true;
        let level: Array<number> = new Array<number>(count);
        level[source] = 0;
        while (que.isEmpty() === false) {
            let curr = que.remove();
            let depth: number = level[curr];
            let adl: Array<GraphEdge> = this.adj[curr];
            for (let index = 0; index < adl.length; index++) {
                let adn = adl[index];
                if (adn.dest === dest) {
                    return depth + 1;
                }
                if (visited[adn.dest] === false) {
                    visited[adn.dest] = true;
                    que.add(adn.dest);
                    level[adn.dest] = depth + 1;
                }
            }
        }
        return -1;
    }

    private isCyclePresentUndirectedDFS(src: number, parentIndex: number, visited: boolean[]): boolean {
        visited[src] = true;
        let dest: number;
        const adl: Array<GraphEdge> = this.adj[src];

        for (let index = 0; index < adl.length; index++) {
            const adn = adl[index];
            dest = adn.dest;
            if (visited[dest] === false) {
                if (this.isCyclePresentUndirectedDFS(dest, src, visited))
                    return true;
            } else if (parentIndex !== dest) {
                return true;
            }
        }
        return false;
    }

    isCyclePresentUndirected(): boolean {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        for (let i: number = 0; i < count; i++) {
            if (visited[i] === false &&
                this.isCyclePresentUndirectedDFS(i, -1, visited))
                return true;
        }
        return false;
    }

    isCyclePresentUndirected2() {
        const count = this.count;
        const parent = new Array(count).fill(-1);
        let edge = [];
        const flags = new Array(count).fill(false).map(() => new Array(count).fill(false));
        for (let i = 0; i < count; i++) {
            let ad = this.adj[i];
            for (const adn of ad) {
                // Using flags[][] array, if considered edge x to y, 
                // then ignore edge y to x.
                if (flags[adn.dest][adn.src] == false) {
                    edge.push(adn);
                    flags[adn.src][adn.dest] = true;
                }
            }
        }
        for (const e of edge) {
            let x = find1(parent, e.src);
            let y = find1(parent, e.dest);
            if (x == y) {
                return true;
            }
            union1(parent, x, y);
        }
        return false;
    }

    isCyclePresentUndirected3() {
        const count = this.count;
        //Different subsets are created.
        const sets = new Array(count);
        for (let i = 0; i < count; i++) {
            sets[i] = new Sets(i, 0);
        }
        let edge = [];
        const flags = new Array(count).fill(false).map(() => new Array(count).fill(false));
        for (let i = 0; i < count; i++) {
            let ad = this.adj[i];
            for (const adn of ad) {
                // Using flags[][] array, if considered edge x to y, 
                // then ignore edge y to x.
                if (flags[adn.dest][adn.src] == false) {
                    edge.push(adn);
                    flags[adn.src][adn.dest] = true;
                }
            }
        }
        for (const e of edge) {
            let x = find(sets, e.src);
            let y = find(sets, e.dest);
            if (x == y) {
                return true;
            }
            union(sets, x, y);
        }
        return false;
    }




    private isCyclePresentDFS(index: number, visited: Array<boolean>, marked: Array<number>): boolean {
        visited[index] = true;
        marked[index] = 1;
        let adl: Array<GraphEdge> = this.adj[index];
        for (let index = 0; index < adl.length; index++) {
            let adn = adl[index];
            let dest: number = adn.dest;
            if (marked[dest] === 1) return true;
            if (visited[dest] === false)
                if (this.isCyclePresentDFS(dest, visited, marked))
                    return true;

        }
        marked[index] = 0;
        return false;
    }

    public isCyclePresent(): boolean {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        let marked: Array<number> = new Array<number>(count);
        for (let index: number = 0; index < count; index++) {
            if (visited[index] === false)
                if (this.isCyclePresentDFS(index, visited, marked))
                    return true;
        }
        return false;
    }

    private isCyclePresentDFSColor(index: number, visited: Array<number>): boolean {
        visited[index] = 1;
        let dest: number;
        let adl: Array<GraphEdge> = this.adj[index];
        for (let index = 0; index < adl.length; index++) {
            let adn = adl[index];
            dest = adn.dest;
            if (visited[dest] === 1)
                return true;
            if (visited[dest] === 0)
                if (this.isCyclePresentDFSColor(dest, visited))
                    return true;
        }
        visited[index] = 2;
        return false;
    }

    public isCyclePresentColor(): boolean {
        const count: number = this.count;
        let visited: Array<number> = new Array<number>(count);
        for (let i: number = 0; i < count; i++) {
            if (visited[i] === 0)
                if (this.isCyclePresentDFSColor(i, visited))
                    return true;
        }
        return false;
    }

    public transposeGraph(): Graph {
        const count: number = this.count;
        let g: Graph = new Graph(count);
        for (let i: number = 0; i < count; i++) {
            let adl: Array<GraphEdge> = this.adj[i];
            for (let index = 0; index < adl.length; index++) {
                let adn = adl[index];
                let dest: number = adn.dest;
                g.addDirectedEdge(dest, i, 1);
            }
        }
        return g;
    }

    public isConnectedUndirected(): boolean {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        this.dfsUtil3(0, visited);
        for (let i: number = 0; i < count; i++) {
            if (visited[i] === false) {
                return false;
            }
        }
        return true;
    }

    public isStronglyConnected(): boolean {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        this.dfsUtil3(0, visited);
        for (let i: number = 0; i < count; i++) {
            if (visited[i] === false) {
                return false;
            }
        }
        let gReversed: Graph = this.transposeGraph();
        for (let i: number = 0; i < count; i++) {
            visited[i] = false;
        }
        gReversed.dfsUtil3(0, visited);
        for (let i: number = 0; i < count; i++) {
            if (visited[i] === false) {
                return false;
            }
        }
        return true;
    }

    public stronglyConnectedComponent() {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        let stk: Array<number> = new Array<number>();
        for (let i: number = 0; i < count; i++) {
            if (visited[i] === false) {
                this.dfsUtil2(i, visited, stk);
            }
        }
        let gReversed: Graph = this.transposeGraph();
        for (let i: number = 0; i < count; i++) {
            visited[i] = false;
        }
        let stk2: Array<number> = new Array<number>();
        while (stk.length !== 0) {
            let index: number = stk.pop()!;
            if (visited[index] === false) {
                stk2.length = 0;
                gReversed.dfsUtil2(index, visited, stk2);
                console.log(stk2);
            }
        }
    }

    public primsMST() {
        let previous: Array<number> = new Array(this.count).fill(-1);
        let dist: Array<number> = new Array(this.count).fill(infi);
        let visited: Array<boolean> = new Array(this.count).fill(false);

        let source: number = 0;
        dist[source] = 0;
        previous[source] = 0;

        let queue: PriorityQueue<GraphEdge> =
            new PriorityQueue<GraphEdge>(EdgeComparator);
        let node: GraphEdge = new GraphEdge(source, source, 0);
        queue.add(node);

        while (queue.isEmpty() === false) {
            node = queue.remove();
            source = node.dest;

            if (visited[source] == true) {
                continue
            }
            visited[source] = true;

            let adl: Array<GraphEdge> = this.adj[source];
            for (let index = 0; index < adl.length; index++) {
                let adn = adl[index];
                let dest: number = adn.dest;
                let alt: number = adn.cost;
                if (dist[dest] > alt && visited[dest] === false) {
                    dist[dest] = alt;
                    previous[dest] = source;
                    node = new GraphEdge(source, dest, alt);
                    queue.add(node);
                }
            }
        }
        const count: number = this.count;
        let total = 0;
        let output = "Edges are ";
        for (let i = 0; i < count; i++) {
            if (dist[i] === infi) {
                output += `( ${i},  Unreachable)`
            } else if (previous[i] != i) {
                output += `(${previous[i]}->${i} @ ${dist[i]}) `
                total += dist[i];
            }
        }
        console.log(output);
        console.log(`Total MST cost : ${total}`)
    }

    kruskalMST(): void {
        const count = this.count;
        // Different subsets are created.
        const sets: Sets[] = new Array(count);
        for (let i = 0; i < count; i++) {
            sets[i] = new Sets(i, 0);
        }
        // Edges are added to array and sorted.
        let E = 0;
        let edge = [];
        for (let i = 0; i < count; i++) {
            let ad = this.adj[i];
            for (const adn of ad) {
                edge.push(adn);
                E++;
            }
        }
        edge.sort(function (a, b) {
            return a.cost - b.cost;
        });
        let sum = 0;
        let output = "Edges are ";
        for (let i = 0; i < E; i++) {
            let x = find(sets, edge[i].src);
            let y = find(sets, edge[i].dest);
            if (x !== y) {
                output += "(" + edge[i].src + "->" + edge[i].dest + " @ " + edge[i].cost + ") ";
                sum += edge[i].cost;
                union(sets, x, y);
            }
        }
        console.log(output);
        console.log(`Total MST cost : ${sum}`);
    }

    printPathUtil(previous, source, dest): string {
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

    public shortestPath(source: number) {
        let curr: number;
        const count: number = this.count;
        let distance: Array<number> = new Array<number>(count);
        let previous: Array<number> = new Array<number>(count);
        for (let i: number = 0; i < count; i++) {
            distance[i] = -1;
        }
        let que: Queue<number> = new Queue<number>();;
        que.add(source);
        distance[source] = 0;
        previous[source] = source;

        while (que.isEmpty() === false) {
            curr = que.remove();
            let adl: Array<GraphEdge> = this.adj[curr];
            for (let index = 0; index < adl.length; index++) {
                let adn = adl[index];
                if (distance[adn.dest] === -1) {
                    distance[adn.dest] = distance[curr] + 1;
                    previous[adn.dest] = curr;
                    que.add(adn.dest);
                }
            }
        }
        this.printPath(previous, distance, count, source);
    }

    public dijkstra(source: number) {
        let previous: Array<number> = new Array<number>(this.count).fill(-1);
        let dist: Array<number> = new Array<number>(this.count).fill(infi);
        let visited: Array<boolean> = new Array<boolean>(this.count).fill(false);;

        dist[source] = 0;
        previous[source] = source;

        let queue: PriorityQueue<GraphEdge> = new PriorityQueue<GraphEdge>(EdgeComparator);
        let node: GraphEdge = new GraphEdge(source, source, 0);
        queue.add(node);
        let curr: number;

        while (queue.isEmpty() === false) {
            node = queue.remove();
            curr = node.dest;

            if (visited[curr] == true) {
                continue
            }
            visited[curr] = true

            let adl: Array<GraphEdge> = this.adj[curr];
            for (let index = 0; index < adl.length; index++) {
                let adn = adl[index];
                let dest: number = adn.dest;
                let alt: number = adn.cost + dist[curr];
                if (dist[dest] > alt && visited[dest] === false) {
                    dist[dest] = alt;
                    previous[dest] = curr;
                    node = new GraphEdge(curr, dest, alt);
                    queue.add(node);
                }
            }
        }
        this.printPath(previous, dist, this.count, source);
    }

    public bellmanFordshortestPath(source: number) {
        const count: number = this.count;
        let distance: Array<number> = new Array<number>(count).fill(infi);
        let previous: Array<number> = new Array<number>(count).fill(-1);
        distance[source] = 0;
        previous[source] = source
        for (let i: number = 0; i < count - 1; i++) {
            for (let j: number = 0; j < count; j++) {
                let adl: Array<GraphEdge> = this.adj[j];
                for (let index = 0; index < adl.length; index++) {
                    let adn = adl[index];
                    let newDistance: number = distance[j] + adn.cost;
                    if (distance[adn.dest] > newDistance) {
                        distance[adn.dest] = newDistance;
                        previous[adn.dest] = j;
                    }
                }
            }
        }
        this.printPath(previous, distance, count, source);
    }

    public bestFirstSearchPQ(source: number, dest: number): number {
        let previous: Array<number> = new Array<number>(this.count);
        let dist: Array<number> = new Array<number>(this.count);
        let visited: Array<boolean> = new Array<boolean>(this.count).fill(false);
        for (let i: number = 0; i < this.count; i++) {
            previous[i] = -1;
            dist[i] = infi;
        }
        let pq: PriorityQueue<GraphEdge> = new PriorityQueue<GraphEdge>(EdgeComparator);
        dist[source] = 0;
        previous[source] = -1;
        let node: GraphEdge = new GraphEdge(source, source, 0);
        pq.add(node);
        while (pq.isEmpty() === false) {
            node = pq.peek();
            pq.remove();
            source = node.dest;
            if (source === dest) {
                return node.cost;
            }
            visited[source] = true;
            let adl: Array<GraphEdge> = this.adj[source];
            for (let index = 0; index < adl.length; index++) {
                let adn = adl[index];
                {
                    let curr: number = adn.dest;
                    let cost: number = adn.cost;
                    let alt: number = cost + dist[source];
                    if (dist[curr] > alt && visited[curr] === false) {
                        dist[curr] = alt;
                        previous[curr] = source;
                        node = new GraphEdge(source, curr, alt);
                        pq.add(node);
                    }
                }
            }
        }
        return -1;
    }

    public isConnected(): boolean {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        let adl: Array<GraphEdge>;
        for (let i: number = 0; i < count; i++) {
            adl = this.adj[i];
            if ((<number>adl.length) > 0) {
                this.dfsUtil3(i, visited);
                break;
            }
        }
        for (let i: number = 0; i < count; i++) {
            adl = this.adj[i];
            if ((<number>adl.length) > 0) if (visited[i] === false) return false;
        }
        return true;
    }

    public isEulerian(): number {
        const count: number = this.count;
        if (this.isConnected() === false) {
            console.log("graph is not Eulerian");
            return 0;
        }

        let odd: number = 0;
        let inDegree: Array<number> = Array(count).fill(0);
        let outDegree: Array<number> = Array(count).fill(0);
        let adl: Array<GraphEdge>;

        for (let i: number = 0; i < count; i++) {
            adl = this.adj[i];
            for (let index = 0; index < adl.length; index++) {
                let adn = adl[index];
                outDegree[i] += 1;
                inDegree[adn.dest] += 1;
            }
        }
        for (let i: number = 0; i < count; i++) {
            if ((inDegree[i] + outDegree[i]) % 2 !== 0) {
                odd += 1;
            }
        }
        if (odd === 0) {
            console.log("graph is Eulerian");
            return 2;
        } else if (odd === 2) {
            console.log("graph is Semi-Eulerian");
            return 1;
        } else {
            console.log("graph is not Eulerian");
            return 0;
        }
    }

    public isEulerianCycle(): boolean {
        const count: number = this.count;
        let inDegree: Array<number> = new Array<number>(count);
        let outDegree: Array<number> = new Array<number>(count);

        if (!this.isStronglyConnected2()) return false;
        for (let i: number = 0; i < count; i++) {
            let adl: Array<GraphEdge> = this.adj[i];
            for (let index = 0; index < adl.length; index++) {
                let adn = adl[index];
                {
                    outDegree[i] += 1;
                    inDegree[adn.dest] += 1;
                }
            }
        }
        for (let i: number = 0; i < count; i++) {
            if (inDegree[i] !== outDegree[i])
                return false;
        }
        return true;
    }


    public isStronglyConnected2(): boolean {
        const count: number = this.count;
        let visited: Array<boolean> = new Array<boolean>(count).fill(false);
        let gReversed: Graph;
        let index: number;
        let adl: Array<GraphEdge>;
        for (index = 0; index < count; index++) {
            adl = this.adj[index];
            if ((<number>adl.length) > 0)
                break;
        }
        this.dfsUtil3(index, visited);
        for (let i: number = 0; i < count; i++) {
            adl = this.adj[i];
            if (visited[i] === false && (<number>adl.length) > 0)
                return false;
        }
        gReversed = this.transposeGraph();
        visited.fill(false)

        gReversed.dfsUtil3(index, visited);
        for (let i: number = 0; i < count; i++) {
            adl = this.adj[i];
            if (visited[i] === false && (<number>adl.length) > 0)
                return false;
        }
        return true;
    }


    floydWarshall(): void {
        const V = this.count;
        const INF = Number.MAX_VALUE;
        const dist: number[][] = Array.from({ length: V }, () => Array(V).fill(INF));
        const path: number[][] = Array.from({ length: V }, () => Array(V).fill(-1));
        for (let i = 0; i < V; i++) {
            path[i][i] = 0;
        }

        for (let i = 0; i < V; i++) {
            const adl = this.adj[i];
            for (let index = 0; index < adl.length; index++) {
                const adn = adl[index];
                path[i][adn.dest] = i;
                dist[i][adn.dest] = adn.cost;
            }
        }

        for (let k = 0; k < V; k++) { // Pick intermediate vertices.
            for (let i = 0; i < V; i++) { // Pick source vertices one by one.
                for (let j = 0; j < V; j++) { // Pick destination vertices.
                    // If we have a shorter path from i to j via k.
                    // then update dist[i][j] and  and path[i][j]
                    if (dist[i][k] + dist[k][j] < dist[i][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j];
                        path[i][j] = path[k][j];
                    }
                }
                // dist[i][i] is 0 in the start.
                // If there is a better path from i to i and is better path then we have -ve cycle.
                if (dist[i][i] < 0) {
                    console.log("Negative-weight cycle found.");
                    return;
                }
            }
        }
        this.printSolution(dist, path, V);
    }

    private printSolution(cost: number[][], path: number[][], V: number): void {
        let output = "Shortest Paths : ";
        for (let u = 0; u < V; u++) {
            for (let v = 0; v < V; v++) {
                if (u !== v && path[u][v] !== -1) {
                    output += "(";
                    output += this.printPath2(path, u, v);
                    output += " @ " + cost[u][v] + ") ";
                }
            }
        }
        console.log(output);
    }

    private printPath2(path: number[][], u: number, v: number): string {
        if (path[u][v] === u) {
            return u + "->" + v;
        }
        let output = this.printPath2(path, u, path[u][v]);
        output += "->" + v;
        return output;
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
    const gph = new Graph(8);
    gph.addUndirectedEdge(0, 3);
    gph.addUndirectedEdge(0, 2);
    gph.addUndirectedEdge(0, 1);
    gph.addUndirectedEdge(1, 4);
    gph.addUndirectedEdge(2, 5);
    gph.addUndirectedEdge(3, 6);
    gph.addUndirectedEdge(6, 7);
    gph.addUndirectedEdge(5, 7);
    gph.addUndirectedEdge(4, 7);
    console.log("Path between 0 & 6 :", gph.dfs(0, 6))
    console.log("Path between 0 & 6 :", gph.bfs(0, 6))
    console.log("Path between 0 & 6 :", gph.dfsStack(0, 6))
}

/*
DFS Path is : 0,1,4,7,5,2,6,3
Path between 0 & 6 : true
BFS Path is : 0,1,2,3,4,5,6,7
Path between 0 & 6 : true
DFS Path is : 0,1,4,7,5,6,2,3
Path between 0 & 6 : true
*/

/* Testing Code */
function test3() {
    const gph = new Graph(9);
    gph.addDirectedEdge(0, 2);
    gph.addDirectedEdge(1, 2);
    gph.addDirectedEdge(1, 3);
    gph.addDirectedEdge(1, 4);
    gph.addDirectedEdge(3, 2);
    gph.addDirectedEdge(3, 5);
    gph.addDirectedEdge(4, 5);
    gph.addDirectedEdge(4, 6);
    gph.addDirectedEdge(5, 7);
    gph.addDirectedEdge(6, 7);
    gph.addDirectedEdge(7, 8);
    gph.topologicalSort()
}

/*
Topological sort : 1,4,6,3,5,7,8,0,2
*/

/* Testing Code */
function test4() {
    const gph = new Graph(5);
    gph.addDirectedEdge(0, 1)
    gph.addDirectedEdge(0, 2)
    gph.addDirectedEdge(2, 3)
    gph.addDirectedEdge(1, 3)
    gph.addDirectedEdge(3, 4)
    gph.addDirectedEdge(1, 4)
    console.log(`PathExist :: ${gph.pathExist(0, 4)}`)
    console.log(`Path Count :: ${gph.countAllPath(0, 4)}`)
    gph.printAllPath(0, 4)
}

/*
PathExist :: true
Path Count :: 3
[ 0, 1, 3, 4 ]
[ 0, 1, 4 ]
[ 0, 2, 3, 4 ]
*/

/* Testing Code */
function test5() {
    const gph = new Graph(7);
    gph.addDirectedEdge(0, 1)
    gph.addDirectedEdge(0, 2)
    gph.addDirectedEdge(1, 3)
    gph.addDirectedEdge(4, 1)
    gph.addDirectedEdge(6, 4)
    gph.addDirectedEdge(5, 6)
    gph.addDirectedEdge(5, 2)
    gph.addDirectedEdge(6, 0)
    gph.rootVertex()
}

/*
Root vertex is :: 5
*/

/* Testing Code */
function test6() {
    const gph = new Graph(4);
    gph.addDirectedEdge(0, 1)
    gph.addDirectedEdge(0, 2)
    gph.addDirectedEdge(1, 2)
    gph.addDirectedEdge(2, 0)
    gph.addDirectedEdge(2, 3)
    gph.addDirectedEdge(3, 3)
    const tc = gph.transitiveClosure();
    for (let i = 0; i < 4; i++)
        console.log(tc[i])
}

/*
[ 1, 1, 1, 1 ]
[ 1, 1, 1, 1 ]
[ 1, 1, 1, 1 ]
[ 0, 0, 0, 1 ]
*/

/* Testing Code */
function test7() {
    const gph = new Graph(7);
    gph.addUndirectedEdge(0, 1)
    gph.addUndirectedEdge(0, 2)
    gph.addUndirectedEdge(0, 4)
    gph.addUndirectedEdge(1, 2)
    gph.addUndirectedEdge(2, 5)
    gph.addUndirectedEdge(3, 4)
    gph.addUndirectedEdge(4, 5)
    gph.addUndirectedEdge(4, 6)
    gph.bfsLevelNode(1)
    console.log("BfsDistance ::", gph.bfsDistance(1, 6))
}

/*
Node  - Level
1 - 0
0 - 1
2 - 1
4 - 2
5 - 2
3 - 3
6 - 3

BfsDistance :: 3
*/

/* Testing Code */
function test8() {
    const gph = new Graph(6);
    gph.addUndirectedEdge(0, 1)
    gph.addUndirectedEdge(1, 2)
    gph.addUndirectedEdge(3, 4)
    gph.addUndirectedEdge(4, 2)
    gph.addUndirectedEdge(2, 5)
    console.log("isCyclePresentUndirected:", gph.isCyclePresentUndirected())
    console.log("isCyclePresentUndirected:", gph.isCyclePresentUndirected2());
    console.log("isCyclePresentUndirected:", gph.isCyclePresentUndirected3());
    gph.addUndirectedEdge(3, 5, 1)
    console.log("isCyclePresentUndirected:", gph.isCyclePresentUndirected())
    console.log("isCyclePresentUndirected:", gph.isCyclePresentUndirected2());
    console.log("isCyclePresentUndirected:", gph.isCyclePresentUndirected3());
    console.log("IsConnectedUndirected :", gph.isConnectedUndirected())
}

/*
false
false
false
true
true
true
IsConnectedUndirected : true
*/

/* Testing Code */
function test9() {
    const gph = new Graph(5);
    gph.addDirectedEdge(0, 1, 1)
    gph.addDirectedEdge(0, 2, 1)
    gph.addDirectedEdge(2, 3, 1)
    gph.addDirectedEdge(1, 3, 1)
    gph.addDirectedEdge(3, 4, 1)
    console.log("isCyclePresent : " + gph.isCyclePresent())
    console.log("isCyclePresent : " + gph.isCyclePresentColor())
    gph.addDirectedEdge(4, 1, 1)
    console.log("isCyclePresent : " + gph.isCyclePresent())
    console.log("isCyclePresent : " + gph.isCyclePresentColor())
}

/*
true
true
*/

/* Testing Code */
function test10() {
    const gph = new Graph(5);
    gph.addDirectedEdge(0, 1);
    gph.addDirectedEdge(0, 2);
    gph.addDirectedEdge(2, 3);
    gph.addDirectedEdge(1, 3);
    gph.addDirectedEdge(3, 4);
    gph.addDirectedEdge(4, 1);
    const g = gph.transposeGraph()
    g.print();
}

/*
Vertex 0 is connected to : 
Vertex 1 is connected to : 0(cost: 1) 4(cost: 1) 
Vertex 2 is connected to : 0(cost: 1) 
Vertex 3 is connected to : 1(cost: 1) 2(cost: 1) 
Vertex 4 is connected to : 3(cost: 1) 
*/

/* Testing Code */
function test11() {
    const gph = new Graph(5);
    gph.addDirectedEdge(0, 1)
    gph.addDirectedEdge(1, 2)
    gph.addDirectedEdge(2, 3)
    gph.addDirectedEdge(3, 0)
    gph.addDirectedEdge(2, 4)
    gph.addDirectedEdge(4, 2)
    console.log(`IsStronglyConnected:: ${gph.isStronglyConnected()}`)
}

/*
IsStronglyConnected:: true
*/

/* Testing Code */
function test12() {
    const gph = new Graph(7);
    gph.addDirectedEdge(0, 1)
    gph.addDirectedEdge(1, 2)
    gph.addDirectedEdge(2, 0)
    gph.addDirectedEdge(2, 3)
    gph.addDirectedEdge(3, 4)
    gph.addDirectedEdge(4, 5)
    gph.addDirectedEdge(5, 3)
    gph.addDirectedEdge(5, 6)
    gph.stronglyConnectedComponent()
}

/*
[ 1, 2, 0 ]
[ 4, 5, 3 ]
[ 6 ]
*/

/* Testing Code */
function test13() {
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
    gph.primsMST()
    gph.kruskalMST()
    gph.dijkstra(0)
}

/*
Edges are (0->1 @ 4) (5->2 @ 4) (2->3 @ 7) (3->4 @ 9) (6->5 @ 2) (7->6 @ 1) (0->7 @ 8) (2->8 @ 2) 
Total MST cost : 37

Edges are (6->7 @ 1) (2->8 @ 2) (5->6 @ 2) (0->1 @ 4) (2->5 @ 4) (2->3 @ 7) (0->7 @ 8) (3->4 @ 9) 
Total MST cost : 37

Shortest Paths: (0->1 @ 4) (0->1->2 @ 12) (0->1->2->3 @ 19) (0->7->6->5->4 @ 21) (0->7->6->5 @ 11) (0->7->6 @ 9) (0->7 @ 8) (0->1->2->8 @ 14) 

*/

/* Testing Code */
function test14() {
    const gph = new Graph(9);
    gph.addDirectedEdge(0, 1)
    gph.addDirectedEdge(0, 7)
    gph.addDirectedEdge(1, 2)
    gph.addDirectedEdge(1, 7)
    gph.addDirectedEdge(2, 3)
    gph.addDirectedEdge(2, 8)
    gph.addDirectedEdge(2, 5)
    gph.addDirectedEdge(3, 4)
    gph.addDirectedEdge(3, 5)
    gph.addDirectedEdge(4, 5)
    gph.addDirectedEdge(5, 6)
    gph.addDirectedEdge(6, 7)
    gph.addDirectedEdge(6, 8)
    gph.addDirectedEdge(7, 8)
    gph.shortestPath(0)

}

/*
Shortest Paths: (0->1 @ 1) (0->1->2 @ 2) (0->1->2->3 @ 3) (0->1->2->3->4 @ 4) (0->1->2->5 @ 3) (0->1->2->5->6 @ 4) (0->7 @ 1) (0->7->8 @ 2) 

*/

/* Testing Code */
function test15() {
    const gph = new Graph(9);
    gph.addUndirectedEdge(0, 2, 1)
    gph.addUndirectedEdge(1, 2, 5)
    gph.addUndirectedEdge(1, 3, 7)
    gph.addUndirectedEdge(1, 4, 9)
    gph.addUndirectedEdge(3, 2, 2)
    gph.addUndirectedEdge(3, 5, 4)
    gph.addUndirectedEdge(4, 5, 6)
    gph.addUndirectedEdge(4, 6, 3)
    gph.addUndirectedEdge(5, 7, 1)
    gph.addUndirectedEdge(6, 7, 7)
    gph.addUndirectedEdge(7, 8, 17)
    console.log(`isConnectedUndirected :: ${gph.isConnectedUndirected()}`)
}

/*

isConnectedUndirected :: true
*/

/* Testing Code */
function test16() {
    const gph = new Graph(5);
    gph.addDirectedEdge(0, 1, 3)
    gph.addDirectedEdge(0, 4, 2)
    gph.addDirectedEdge(1, 2, 1)
    gph.addDirectedEdge(2, 3, 1)
    gph.addDirectedEdge(4, 1, -2)
    gph.addDirectedEdge(4, 3, 1)
    gph.bellmanFordshortestPath(0)
}

/*
Shortest Paths: (0->4->1 @ 0) (0->4->1->2 @ 1) (0->4->1->2->3 @ 2) (0->4 @ 2) 

*/


function heightTreeParentArr(arr: Array<number>): number {
    const count: number = arr.length;
    let heightArr: Array<number> = new Array<number>(count);
    let gph: Graph = new Graph(count);
    let source: number = 0;
    for (let i: number = 0; i < count; i++) {
        if (arr[i] !== -1) {
            gph.addDirectedEdge(arr[i], i, 1);
        } else {
            source = i;
        }
    }
    let visited: Array<boolean> = new Array<boolean>(count).fill(false);
    visited[source] = true;
    let que: Queue<number> = new Queue<number>();;
    que.add(source);
    heightArr[source] = 0;
    let maxHight: number = 0;
    while (que.isEmpty() === false) {
        let curr = que.remove();
        let height: number = heightArr[curr];
        if (height > maxHight) {
            maxHight = height;
        }
        let adl: Array<GraphEdge> = gph.adj[curr];
        for (let index = 0; index < adl.length; index++) {
            let adn = adl[index];
            if (visited[adn.dest] === false) {
                visited[adn.dest] = true;
                que.add(adn.dest);
                heightArr[adn.dest] = height + 1;
            }
        }
    }
    return maxHight;
}

function getHeight(arr: Array<number>, height: Array<number>, index: number): number {
    if (arr[index] === -1) {
        return 0;
    } else {
        return getHeight(arr, height, arr[index]) + 1;
    }
}

function heightTreeParentArr2(arr: Array<number>): number {
    const count: number = arr.length;
    let height: Array<number> = new Array<number>(count);
    let maxHeight: number = -1;
    for (let i: number = 0; i < count; i++) {
        height[i] = getHeight(arr, height, i);
        maxHeight = Math.max(maxHeight, height[i]);
    }
    return maxHeight;
}
/* Testing Code */
function test17() {
    const parentArray = [-1, 0, 1, 2, 3];
    console.log(heightTreeParentArr(parentArray))
    console.log(heightTreeParentArr2(parentArray))
}

/*
4
4
*/

/* Testing Code */
function test18() {
    const gph = new Graph(5);
    gph.addDirectedEdge(1, 0)
    gph.addDirectedEdge(0, 2)
    gph.addDirectedEdge(2, 1)
    gph.addDirectedEdge(0, 3)
    gph.addDirectedEdge(3, 4)
    gph.isEulerian()
    gph.addDirectedEdge(4, 0);
    gph.isEulerian();
}

/*
graph is Semi-Eulerian
graph is Eulerian
*/

/* Testing Code */
function test19() {
    const gph = new Graph(5);
    gph.addDirectedEdge(0, 1)
    gph.addDirectedEdge(1, 2)
    gph.addDirectedEdge(2, 0)
    gph.addDirectedEdge(0, 4)
    gph.addDirectedEdge(4, 3)
    gph.addDirectedEdge(3, 0)
    console.log(gph.isEulerianCycle())
}

/*
true
*/

/* Testing Code */
function test20() {
    const gph = new Graph(4);
    gph.addDirectedEdge(0, 0, 0);
    gph.addDirectedEdge(1, 1, 0);
    gph.addDirectedEdge(2, 2, 0);
    gph.addDirectedEdge(3, 3, 0);
    gph.addDirectedEdge(0, 1, 5);
    gph.addDirectedEdge(0, 3, 10);
    gph.addDirectedEdge(1, 2, 3);
    gph.addDirectedEdge(2, 3, 1);
    gph.floydWarshall();
}

/*
Shortest Paths : (0->1 @ 5) (0->1->2 @ 8) (0->1->2->3 @ 9) (1->2 @ 3) (1->2->3 @ 4) (2->3 @ 1) 
*/

test1()
test2()
test3()
test4()
test5()
test6()
test7()
test8()
test9()
test10()
test11()
test12()
test13()
test14()
test15()
test16()
test17()
test18()
test19()
test20()