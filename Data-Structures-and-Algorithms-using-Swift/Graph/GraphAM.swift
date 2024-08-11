import Foundation


class Heap < T: Comparable > {
    private var size : Int // Number of elements in Heap
    private var arr : [T?] // The Heap array
    private var isMinHeap : Bool

    init(_ isMin : Bool) {
        self.arr = []
        self.size = 0
        self.isMinHeap = isMin
    }

    init(_ array : inout [T], _ isMin : Bool) {
        self.size = array.count
        self.arr = array
        self.isMinHeap = isMin

		// Build Heap operation over array
		var i : Int = (self.size / 2)
		while (i >= 0) {
			self.percolateDown(i)
			i -= 1
		}
    }

    func comp(_ first : T, _ second : T) -> Bool {
        if (self.isMinHeap) {
            return first > second
        } else {
            return first < second
        }
    }

    // Other Methods.
    func percolateDown(_ parent : Int) {
        let lChild : Int = 2 * parent + 1
        let rChild : Int = lChild + 1
        var child : Int = -1
        if (lChild < self.size) {
            child = lChild
        }

        if (rChild < self.size && self.comp(arr[lChild]!, arr[rChild]!)) {
            child = rChild
        }

        if (child != -1 && self.comp(arr[parent]!, arr[child]!)) {
            self.arr.swapAt(parent, child)
			self.percolateDown(child)
        }
    }

    func percolateUp(_ child : Int) {
        let parent : Int = (child - 1) / 2
        if (parent >= 0 && self.comp(arr[parent]!, arr[child]!)) {
			self.arr.swapAt(child, parent)
            self.percolateUp(parent)
        }
    }

    public var isEmpty : Bool {
        return (self.size == 0)
    }

    public var length : Int {
        return self.size
    }

    func peek() -> T? {
        if (self.isEmpty) {
            print("Heap empty exception.")
			return nil
        }
        return self.arr[0]
    }

    func add(_ value : T) {
		self.size += 1
		self.arr.append(value)
        self.percolateUp(self.size - 1)
    }

    func remove() -> T? {
        if (self.isEmpty) {
            print("Heap empty exception.")
			return nil
        }
        let value = self.arr[0]
        self.arr[0] = self.arr[self.size - 1]
        self.size -= 1
		self.arr.removeLast()
        self.percolateDown(0)
        return value
    }

    func display() {
		var i : Int = 0
		while (i < self.size) {
			print(self.arr[i]!, terminator: " ")
			i += 1
		}
        print()
    }

    func delete(_ value : T) -> Bool {
		var i : Int = 0
		while (i < self.size) {
			if (self.arr[i] == value) {
				self.arr[i] = self.arr[self.size - 1]
				self.size -= 1
				self.arr.removeLast()
				self.percolateUp(i)
				self.percolateDown(i)
				return true
			}
			i += 1
		}
        return false
    }
}

class GraphAM {
    var count : Int
    var adj : [[Int]]

    init(_ cnt : Int) {
        self.count = cnt
        self.adj = Array(repeating: Array(repeating: 0, count: self.count), count: self.count)
    }

    func addDirectedEdge(_ src : Int, _ dst : Int, _ cost : Int = 1) {
        self.adj[src][dst] = cost
    }

    func addUndirectedEdge(_ src : Int, _ dst : Int, _ cost : Int = 1) {
        self.addDirectedEdge(src,dst,cost)
        self.addDirectedEdge(dst,src,cost)
    }

    func printGraph() {
        var i : Int = 0
		while (i < self.count) {
			print("Vertex \(i) is connected to : ",terminator: "")
			var j : Int = 0
			while (j < self.count) {
				if (self.adj[i][j] != 0) {
					print("\(j) (cost: \(self.adj[i][j]))",terminator: " ")
				}
				j += 1
			}
			print()
			i += 1
        }
    }

	class Edge : Comparable {
        var src : Int
        var dest : Int
        var cost : Int

        init(_ s : Int, _ d : Int, _ c : Int) {
            self.src = s
            self.dest = d
            self.cost = c
        }

		static func < (lhs: Edge, rhs: Edge) -> Bool {
            return lhs.cost < rhs.cost
        }

		static func > (lhs: Edge, rhs: Edge) -> Bool {
            return lhs.cost > rhs.cost
        }

        static func == (lhs: Edge, rhs: Edge) -> Bool {
            return lhs.cost == rhs.cost
        }
    }

    func dijkstra(_ source : Int) {
        var previous : [Int] = Array(repeating: -1, count: self.count)
        var dist : [Int] = Array(repeating: Int.max, count: self.count)
        var visited : [Bool] = Array(repeating: false, count: self.count)

        dist[source] = 0
        previous[source] = source

        let queue = Heap<Edge>(true)
		var node : Edge = Edge(source, source, 0)
        queue.add(node)

        while (queue.isEmpty != true) {
            node = queue.remove()!
            let src : Int = node.dest
            visited[src] = true
			var dest : Int = 0
			while (dest < self.count) {
				let cost : Int = self.adj[src][dest]
				if (cost != 0) {
					let alt : Int = cost + dist[src]
					if (dist[dest] > alt && visited[dest] == false) {
						dist[dest] = alt
						previous[dest] = src
						node = Edge(src, dest, alt)
						queue.add(node)
					}
				}
				dest += 1
			}
        }
        self.printPath( &previous, &dist,self.count,source)
    }

    func printPathUtil(_ previous : inout [Int], _ source : Int, _ dest : Int) -> String {
        var path : String = ""
        if (dest == source) {
            path += String(source)
        } else {
            path += self.printPathUtil( &previous,source,previous[dest])
            path += ("->" + String(dest))
        }
        return path
    }

    func printPath(_ previous : inout [Int], _ dist : inout [Int], _ count : Int, _ source : Int) {
        var output : String = "Shortest Paths: "
        var i : Int = 0
		while (i < count) {
			if (dist[i] == 99999) {
				output += ("(" + String(source) + "->" + String(i) + " @ Unreachable) ")
			} else if (i != previous[i]) {
				output += "("
				output += self.printPathUtil( &previous,source,i)
				output += (" @ " + String(dist[i]) + ") ")
			}
			i += 1
		}
        print(output)
    }

    func primsMST() {
        var previous : [Int] = Array(repeating: -1, count: self.count)
        var dist : [Int] = Array(repeating: Int.max, count: self.count)
        var visited : [Bool] = Array(repeating: false, count: self.count)

        var source : Int = 0
        dist[source] = 0
        previous[source] = source

        let queue = Heap<Edge>(true)
        var node : Edge = Edge(source, source, 0)
        queue.add(node)

        while (queue.isEmpty != true) {
            node = queue.remove()!
            source = node.dest
            visited[source] = true

			var dest : Int = 0
			while (dest < self.count) {
				let cost : Int = self.adj[source][dest]
				if (cost != 0) {
					if (dist[dest] > cost && visited[dest] == false) {
						dist[dest] = cost
						previous[dest] = source
						node = Edge(source, dest, cost)
						queue.add(node)
					}
				}
				dest += 1
			}
        }

        // printing result.
        var sum : Int = 0
        var isMst : Bool = true
        var output : String = "Edges are "
        var i : Int = 0
		while (i < self.count) {
			if (dist[i] == Int.max) {
				output += ("(" + String(i) + ", Unreachable) ")
				isMst = false
			} else if (previous[i] != i) {
				output += ("(" + String(previous[i]) + "->" + String(i) + " @ " + String(dist[i]) + ") ")
				sum += dist[i]
			}
			i += 1
		}

        if (isMst) {
            print(output)
            print("Total MST cost: " + String(sum))
        } else {
            print("Can\'t get a Spanning Tree")
        }
    }


	func hamiltonianPathUtil(_ path : inout [Int], _ pSize : Int, _ added : inout [Int]) -> Bool {
        // Base case full length path is found
        if (pSize == self.count) {
            return true
        }

		var vertex : Int = 0
		while (vertex < self.count) {
			// There is an edge from last element of path and next vertex
			// and the next vertex is not already included in the path.
			if (pSize == 0 || (self.adj[path[pSize - 1]][vertex] == 1 && added[vertex] == 0)) {
				path[pSize] = vertex
				added[vertex] = 1
				if (self.hamiltonianPathUtil( &path,pSize+1, &added)) {
					return true
				}
				added[vertex] = 0
			}
			vertex += 1
		}
        return false
    }

    func hamiltonianPath() -> Bool {
        var path : [Int] = Array(repeating: 0, count: self.count)
        var added : [Int] = Array(repeating: 0, count: self.count)

        if (self.hamiltonianPathUtil( &path,0, &added)) {
            print("Hamiltonian Path found :: ",terminator: "")
			var i : Int = 0
			while (i < self.count) {
				print(" " + String(path[i]),terminator: "")
				i += 1
			}
            print()
            return true
        }
        print("Hamiltonian Path not found")
        return false
    }

    func hamiltonianCycleUtil(_ path : inout [Int], _ pSize : Int, _ added : inout [Int]) -> Bool {
        // Base case full length path is found
        // this last check can be modified to make it a path.
        if (pSize == self.count) {
            if (self.adj[path[pSize - 1]][path[0]] == 1) {
                path[pSize] = path[0]
                return true
            } else {
                return false
            }
        }

		var vertex : Int = 0
		while (vertex < self.count) {
			// there is a path from last element and next vertex
			if (pSize == 0 || (self.adj[path[pSize - 1]][vertex] == 1 && added[vertex] == 0)) {
				path[pSize] = vertex
				added[vertex] = 1
				if (self.hamiltonianCycleUtil( &path,pSize+1, &added)) {
					return true
				}
				added[vertex] = 0
			}
			vertex += 1
		}
        return false
    }
	
    func hamiltonianCycle() -> Bool {
        var path : [Int] = Array(repeating: 0, count: self.count + 1)
        var added : [Int] = Array(repeating: 0, count: self.count)
        if (self.hamiltonianCycleUtil( &path,0, &added)) {
            print("Hamiltonian Cycle found :: ",terminator: "")
			var i : Int = 0
			while (i <= self.count) {
				print(" " + String(path[i]),terminator: "")
				i += 1
			}
            print("")
            return true
        }
        print("Hamiltonian Cycle not found")
        return false
    }
}

// Testing code.
func main1() {
let gph : GraphAM = GraphAM(4)
gph.addUndirectedEdge(0,1)
gph.addUndirectedEdge(0,2)
gph.addUndirectedEdge(1,2)
gph.addUndirectedEdge(2,3)
gph.printGraph()
}

// Vertex 0 is connected to : 1(cost: 1) 2(cost: 1) 
// Vertex 1 is connected to : 0(cost: 1) 2(cost: 1) 
// Vertex 2 is connected to : 0(cost: 1) 1(cost: 1) 3(cost: 1) 
// Vertex 3 is connected to : 2(cost: 1)

// Testing code.
func main2() {
	let gph : GraphAM = GraphAM(9)
	gph.addUndirectedEdge(0,1,4)
	gph.addUndirectedEdge(0,7,8)
	gph.addUndirectedEdge(1,2,8)
	gph.addUndirectedEdge(1,7,11)
	gph.addUndirectedEdge(2,3,7)
	gph.addUndirectedEdge(2,8,2)
	gph.addUndirectedEdge(2,5,4)
	gph.addUndirectedEdge(3,4,9)
	gph.addUndirectedEdge(3,5,14)
	gph.addUndirectedEdge(4,5,10)
	gph.addUndirectedEdge(5,6,2)
	gph.addUndirectedEdge(6,7,1)
	gph.addUndirectedEdge(6,8,6)
	gph.addUndirectedEdge(7,8,7)
	gph.primsMST()
}

// Edges are (0->1 @ 4) (5->2 @ 4) (2->3 @ 7) (3->4 @ 9) (6->5 @ 2) (7->6 @ 1) (0->7 @ 8) (2->8 @ 2) 
// Total MST cost: 37

// Testing code.
func main3() {
	let gph : GraphAM = GraphAM(9)
	gph.addUndirectedEdge(0,1,4)
	gph.addUndirectedEdge(0,7,8)
	gph.addUndirectedEdge(1,2,8)
	gph.addUndirectedEdge(1,7,11)
	gph.addUndirectedEdge(2,3,7)
	gph.addUndirectedEdge(2,8,2)
	gph.addUndirectedEdge(2,5,4)
	gph.addUndirectedEdge(3,4,9)
	gph.addUndirectedEdge(3,5,14)
	gph.addUndirectedEdge(4,5,10)
	gph.addUndirectedEdge(5,6,2)
	gph.addUndirectedEdge(6,7,1)
	gph.addUndirectedEdge(6,8,6)
	gph.addUndirectedEdge(7,8,7)
	gph.dijkstra(0)
}

// Shortest Paths: (0->1 @ 4) (0->1->2 @ 12) (0->1->2->3 @ 19) (0->7->6->5->4 @ 21) (0->7->6->5 @ 11) (0->7->6 @ 9) (0->7 @ 8) (0->1->2->8 @ 14) 

// Testing code.
func main4() {
	let count : Int = 5
	let gph : GraphAM = GraphAM(count)
	let adj : [[Int]] =
	[[0, 1, 0, 1, 0],
	[1, 0, 1, 1, 0],
	[0, 1, 0, 0, 1],
	[1, 1, 0, 0, 1],
	[0, 1, 1, 1, 0]]

	var i : Int = 0
	while (i < count) {
		var j : Int = 0
		while (j < count) {
			if (adj[i][j] == 1) {
				gph.addDirectedEdge(i,j,1)
			}
			j += 1
		}
		i += 1
	}
	print("hamiltonianPath : " + String(gph.hamiltonianPath()))
	
	let gph2 : GraphAM? = GraphAM(count)
	let adj2 : [[Int]] =
	[
	[0, 1, 0, 1, 0],
	[1, 0, 1, 1, 0],
	[0, 1, 0, 0, 1],
	[1, 1, 0, 0, 0],
	[0, 1, 1, 0, 0]]

	i = 0
	while (i < count) {
		var j : Int = 0
		while (j < count) {
			if (adj2[i][j] == 1) {
				gph2!.addDirectedEdge(i,j,1)
			}
			j += 1
		}
		i += 1
	}
	print("hamiltonianPath :  " + String(gph2!.hamiltonianPath()))
}

// Hamiltonian Path found ::  0 1 2 4 3
// hamiltonianPath : true
// Hamiltonian Path found ::  0 3 1 2 4
// hamiltonianPath :  true


// Testing code.
func main5() {
	let count : Int = 5
	let gph : GraphAM? = GraphAM(count)
	let adj : [[Int]] =
	[[0, 1, 0, 1, 0],
	 [1, 0, 1, 1, 0],
	 [0, 1, 0, 0, 1],
	 [1, 1, 0, 0, 1],
	 [0, 1, 1, 1, 0]]

	var i : Int = 0
	while (i < count) {
		var j : Int = 0
		while (j < count) {
			if (adj[i][j] == 1) {
				gph!.addDirectedEdge(i,j,1)
			}
			j += 1
		}
		i += 1
	}

	print("hamiltonianCycle : " + String(gph!.hamiltonianCycle()))
	let gph2 : GraphAM? = GraphAM(count)
	let adj2 : [[Int]] =
	[[0, 1, 0, 1, 0],
	 [1, 0, 1, 1, 0],
	 [0, 1, 0, 0, 1],
	 [1, 1, 0, 0, 0],
	 [0, 1, 1, 0, 0]]

	i = 0
	while (i < count) {
		var j : Int = 0
		while (j < count) {
			if (adj2[i][j] == 1) {
				gph2!.addDirectedEdge(i,j,1)
			}
			j += 1
		}
		i += 1
	}
	print("hamiltonianCycle :  " + String(gph2!.hamiltonianCycle()))
}

// Hamiltonian Cycle found ::  0 1 2 4 3 0
// hamiltonianCycle : true
// Hamiltonian Cycle not found
// hamiltonianCycle :  false


main1()
main2()
main3()
main4()
main5()
