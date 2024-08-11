// Function to find the minimum weight Hamiltonian Cycle
function tspUtil(graph: number[][], n: number, path: number[], pSize: number, pCost: number, visited: boolean[], ans: number, ansPath: number[]): number {
	if (pCost > ans) return ans;

	const curr: number = path[pSize - 1];
	if (pSize === n) {
		if (graph[curr][0] > 0 && ans > pCost + graph[curr][0]) {
			ans = pCost + graph[curr][0];
			for (let i = 0; i < n; i++) ansPath[i] = path[i];
			ansPath[n] = path[0];
		}
		return ans;
	}

	for (let i = 0; i < n; i++) {
		if (!visited[i] && graph[curr][i] > 0) {
			visited[i] = true;
			path[pSize] = i;
			ans = tspUtil(graph, n, path, pSize + 1, pCost + graph[curr][i], visited, ans, ansPath);
			visited[i] = false;
		}
	}
	return ans;
}

function tsp(graph: number[][], n: number): number {
	const visited: boolean[] = new Array(n);
	for (let i = 0; i < n; i++) visited[i] = false;

	const path: number[] = new Array(n);
	const ansPath: number[] = new Array(n + 1);
	path[0] = 0;
	visited[0] = true;
	let ans: number = Number.MAX_VALUE;
	ans = tspUtil(graph, n, path, 1, 0, visited, ans, ansPath);
	console.log(`Path length: ${ans}`);
	console.log(`Path: ${ansPath.join(" ")}`);
	return ans;
}

const n: number = 4;
const graph: number[][] = [
	[0, 10, 15, 20],
	[10, 0, 35, 25],
	[15, 35, 0, 30],
	[20, 25, 30, 0],
];
tsp(graph, n);

/*
Path length: 80
Path: 0 1 3 2 0
*/
