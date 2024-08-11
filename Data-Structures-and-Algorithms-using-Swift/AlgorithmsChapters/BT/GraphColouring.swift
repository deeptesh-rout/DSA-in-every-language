import Foundation

func printSolution(_ colour : inout [Int], _ V : Int) {
	print("Assigned colours are::", terminator: "")
	var i : Int = 0
	while (i < V) {
		print(String(colour[i]), terminator: " ")
		i += 1
	}
	print()
}

// Check if the whole graph is coloured properly.
func isSafe2(_ graph : inout [[Bool]], _ colour : inout [Int], _ V : Int) -> Bool {
		var i : Int = 0
		while (i < V) {
			var j : Int = i + 1
			while (j < V) {
				if (graph[i][j] && colour[j] == colour[i]) {
					return false
				}
				j += 1
			}
			i += 1
		}
	return true
}

func graphColouring2(_ graph : inout [[Bool]], _ V : Int, _ m : Int, _ colour : inout [Int], _ i : Int) -> Bool {
	if (i == V) {
		if (isSafe2( &graph, &colour,V)) {
			printSolution( &colour,V)
			return true
		}
		return false
	}
	var j : Int = 1
	// Assign each colour from 1 to m
	while (j <= m) {
		colour[i] = j
		if (graphColouring2( &graph,V,m, &colour,i + 1)) {
			return true
		}
		j += 1
	}
	return false
}

func graphColouring2(_ graph : inout [[Bool]], _ V : Int, _ m : Int) -> Bool {
	var colour : [Int] = Array(repeating: 0, count: V)
	if (graphColouring2( &graph,V,m, &colour,0)) {
		return true
	}
	return false
}

// Is it safe to colour vth vertice with c colour.
func isSafe(_ graph : inout [[Bool]], _ V : Int, _ colour : inout [Int], _ v : Int, _ c : Int) -> Bool {
	var i : Int = 0
	while (i < V) {
		if (graph[v][i] == true && c == colour[i]) {
			return false
		}
		i += 1
	}
	return true
}

func graphColouringUtil(_ graph : inout [[Bool]], _ V : Int, _ m : Int, _ colour : inout [Int], _ i : Int) -> Bool {
	if (i == V) {
		printSolution( &colour,V)
		return true
	}
	var j : Int = 1
	while (j <= m) {
		if (isSafe( &graph,V, &colour,i,j)) {
			colour[i] = j
			if (graphColouringUtil( &graph,V,m, &colour,i + 1)) {
				return true
			}
		}
		j += 1
	}
	return false
}

func graphColouring(_ graph : inout [[Bool]], _ V : Int, _ m : Int) -> Bool {
	var colour : [Int] = Array(repeating: 0, count: V)
	if (graphColouringUtil( &graph,V,m, &colour,0)) {
		return true
	}
	return false
}

// Testing code.
var graph : [[Bool]] =
[[false, true, false, false, true],
[true, false, true, false, true],
[false, true, false, true, true],
[false, false, true, false, true],
[true, true, true, true, false]]

let V : Int = 5 // Number of vertices
let m : Int = 4 // Number of colours

if (!graphColouring2( &graph,V,m)) {
	print("Solution does not exist")
}
if (!graphColouring( &graph,V,m)) {
	print("Solution does not exist")
}

/* 
Assigned colours are::1 2 1 2 3 
Assigned colours are::1 2 1 2 3  
*/