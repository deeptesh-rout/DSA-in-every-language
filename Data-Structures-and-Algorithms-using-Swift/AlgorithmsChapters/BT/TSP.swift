import Foundation

// Function to find the minimum weight Hamiltonian Cycle
func tspUtil(_ graph : inout [[Int]], _ n : Int, _ path : inout [Int], _ pSize : Int, _ pCost : Int, _ visited : inout [Bool], _ ans : inout Int, _ ansPath : inout [Int]) -> Int {
	if (pCost > ans) {
		return ans
	}
	let curr : Int = path[pSize - 1]
	if (pSize == n) {
		if (graph[curr][0] > 0 && ans > pCost + graph[curr][0]) {
			ans = pCost + graph[curr][0]
			var i : Int = 0
			while (i <= n) {
				ansPath[i] = path[i % n]
				i += 1
			}
		}
		return ans
	}

	var i : Int = 0
	while (i < n) {
		if (visited[i] == false && graph[curr][i] > 0) {
			visited[i] = true
			path[pSize] = i
			ans = tspUtil( &graph,n, &path,pSize + 1,pCost + graph[curr][i], &visited, &ans, &ansPath)
			visited[i] = false
		}
		i += 1
	}
	return ans
}

func tsp(_ graph : inout [[Int]], _ n : Int) {
	var visited : [Bool] = Array(repeating: false, count: n)
	var path : [Int] = Array(repeating: 0, count: n)
	var ansPath : [Int] = Array(repeating: 0, count: n + 1)
	path[0] = 0
	visited[0] = true
	var ans : Int = Int.max
	ans = tspUtil( &graph,n, &path, 1, 0, &visited, &ans, &ansPath)

	print("Path length : " + String(ans))
	print("Path : ",terminator: "")
	var i : Int = 0
	while (i <= n) {
		print(String(ansPath[i]), terminator: " ")
		i += 1
	}
}

// Testing code.
let n : Int = 4
var graph : [[Int]] =
[[0, 10, 15, 20],
[10, 0, 35, 25],
[15, 35, 0, 30],
[20, 25, 30, 0]]
tsp( &graph,n)

/*
Path length : 80
Path : 0 1 3 2 0 
*/