import Foundation

var INF : Int = Int.max

func floydWarshall(_ graph : inout [[Int]], _ V : Int) {
	var dist : [[Int]] = Array(repeating: Array(repeating: 0, count: V), count: V)
	var i : Int = 0
	while (i < V) {
		var j : Int = 0
		while (j < V) {
			dist[i][j] = graph[i][j]
			j += 1
		}
		i += 1
	}
	
	var k : Int = 0
	while (k < V) { // Pick intermediate vertices.
		var i : Int = 0
		while (i < V) { // Pick source vertices one by one.
			var j : Int = 0
			while (j < V) { // Pick destination vertices.
				// If we have shorter path from i to j via k.
				// then update dist[i][j]
				if (dist[i][k] != INF && dist[k][j] != INF && dist[i][k] + dist[k][j] < dist[i][j]) {
					dist[i][j] = dist[i][k] + dist[k][j]
				}
				j += 1
			}
			i += 1
		}
		k += 1
	}
	// Print the shortest distance matrix
	printSolution( &dist,V)
}

func printSolution(_ dist : inout [[Int]], _ V : Int) {
	var i : Int = 0
	while (i < V) {
		var j : Int = 0
		while (j < V) {
			if (dist[i][j] == INF) {print("INF ",terminator: "")
			} else {
				print(String(dist[i][j]), terminator: " ")
			}
			j += 1
		}
		print()
		i += 1
	}	
}

// Testing code.
var graph : [[Int]] =
[[0, 2, 4, INF, INF, INF, INF],
[2, 0, 4, 1, INF, INF, INF],
[4, 4, 0, 2, 8, 4, INF],
[INF, 1, 2, 0, 3, INF, 6],
[INF, INF, 6, 4, 0, 3, 1],
[INF, INF, 4, INF, 4, 0, 2],
[INF, INF, INF, 4, 2, 3, 0]]

floydWarshall( &graph,7)

/* 
0 2 4 3 6 8 7 
2 0 3 1 4 7 5 
4 3 0 2 5 4 6 
3 1 2 0 3 6 4 
7 5 6 4 0 3 1 
8 7 4 6 4 0 2 
7 5 6 4 2 3 0 
 */
