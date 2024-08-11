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

class Stack<T> {
	var stk = [T]()
	
	public init() {}

	public func push(_ value : T) {
		stk.append(value)
	}
	
	public func pop() -> T? {
		return stk.popLast()
	}
	
	public func top() -> T? {
		return stk.last
	}
	
	public func display() {
		print(stk)	
	}

	public var isEmpty: Bool {
		return stk.isEmpty
	}
	
	public var count : Int {
		return stk.count
	}
}

class Queue<T> {
	private var que = [T]()
	private var head : Int = 0

	public init() {}

	public func add(_ value : T) {
		que.append(value)
	}
	
	public var isEmpty: Bool {
    	return count == 0
  	}

  	public var count: Int {
    	return que.count - head
  	}

	public func remove() -> T? {
		guard head < que.count else { 
			return nil 
		}
		let element = que[head]
		head += 1

		// Minimum 50 elements need to be freed.
		// One forth of the of total elements need to be freed.
		if(head > 50 && head * 4 > count) {
			que.removeFirst(head)
			head = 0
			print("array size modified.")
		}
		
		return element
	}

	public func front() -> T? {
		guard head < que.count else { 
			return nil 
		}
		return que[head]
	}
}

class Graph{
	class Edge : Comparable {
		var src : Int
		var dest : Int
		var cost : Int
		var next : Edge?

		init(_ src : Int, _ dest : Int, _ cost : Int, _ next : Edge? = nil) {
			self.src = src
			self.dest = dest
			self.cost = cost
			self.next = next
		}

		public static func < (lhs: Edge, rhs: Edge) -> Bool {
            return lhs.cost < rhs.cost
        }

		public static func > (lhs: Edge, rhs: Edge) -> Bool {
            return lhs.cost > rhs.cost
        }

        public static func == (lhs: Edge, rhs: Edge) -> Bool {
            return lhs.cost == rhs.cost
        }
	}

	var count : Int
	var VertexList : [Edge?]

	public init(_ count : Int) {
		self.count = count
		self.VertexList = Array(repeating:nil,count:count)
	}
	
	public func addDirectedEdge(_ src : Int, _ dest : Int, _ cost : Int = 1) {
		let edge = Edge(src, dest, cost, self.VertexList[src])
		self.VertexList[src] = edge
	}

	public func addUndirectedEdge(_ src : Int, _ dest : Int, _ cost : Int = 1) {
		self.addDirectedEdge(src,  dest, cost)
		self.addDirectedEdge(dest, src, cost)
	}
	
	public func printGraph() {
		var i = 0
		while i < self.count {
			var adn = self.VertexList[i]
			if adn != nil  {
				print("Vertex \(i) is connected to : ", terminator: "")
				while adn != nil {
					print("\(adn!.dest)( cost:\(adn!.cost))", terminator: " ")
					adn = adn!.next
				}
				print()
			}
			i+=1
		}
	}

func dfsStack(_ source : Int, _ target : Int) -> Bool {
    var visited : [Bool] = Array(repeating: false, count: self.count)
    let stk = Stack<Int>()
    stk.push(source)
    visited[source] = true
    while (stk.isEmpty == false) {
        let curr : Int = stk.pop()!
        var adn = self.VertexList[curr]
        while adn != nil {
            if (visited[adn!.dest] == false) {
                visited[adn!.dest] = true
                stk.push(adn!.dest)
            }
            adn = adn!.next
        }
    }
    return visited[target]
}

func dfs(_ source : Int, _ target : Int) -> Bool {
    var visited : [Bool] = Array(repeating: false, count: self.count)
    self.dfsUtil(source, &visited)
    return visited[target]
}

func dfsUtil(_ index : Int, _ visited : inout [Bool]) {
    visited[index] = true
    var adn = self.VertexList[index]
    while adn != nil {
        if (visited[adn!.dest] == false) {
            self.dfsUtil(adn!.dest, &visited)
        }
        adn = adn!.next
    }
}

func dfsUtil2(_ index : Int, _ visited : inout [Bool], _ stk : inout [Int]) {
    visited[index] = true
    var adn = self.VertexList[index]
    while adn != nil {
        if (visited[adn!.dest] == false) {
            self.dfsUtil2(adn!.dest, &visited,&stk)
        }
        adn = adn!.next
    }
    stk.append(index)
}

func bfs(_ source : Int, _ target : Int) -> Bool {
    var visited : [Bool] = Array(repeating: false, count: self.count)
    let que = Queue<Int>()
    que.add(source)
    visited[source] = true
    while (que.isEmpty == false) {
        let curr : Int = que.remove()!
        var adn = self.VertexList[curr]
        while adn != nil {
            if (visited[adn!.dest] == false) {
                visited[adn!.dest] = true
                que.add(adn!.dest)
            }
            adn = adn!.next
        }
    }
    return visited[target]
}

    // Testing Code
    static func main0() {
let gph : Graph = Graph(4)
gph.addUndirectedEdge(0,1)
gph.addUndirectedEdge(0,2)
gph.addUndirectedEdge(1,2)
gph.addUndirectedEdge(2,3)
gph.printGraph()
    }
/* 
Vertex 0 is connected to : 2( cost:1) 1( cost:1) 
Vertex 1 is connected to : 2( cost:1) 0( cost:1) 
Vertex 2 is connected to : 3( cost:1) 1( cost:1) 0( cost:1) 
Vertex 3 is connected to : 2( cost:1) 
 */

    // Testing Code
    static func main1() {
let gph : Graph = Graph(8)
gph.addUndirectedEdge(0,3)
gph.addUndirectedEdge(0,2)
gph.addUndirectedEdge(0,1)
gph.addUndirectedEdge(1,4)
gph.addUndirectedEdge(2,5)
gph.addUndirectedEdge(3,6)
gph.addUndirectedEdge(6,7)
gph.addUndirectedEdge(5,7)
gph.addUndirectedEdge(4,7)
print("Path between 0 & 6 : " + String(gph.dfs(0,6)))
print("Path between 0 & 6 : " + String(gph.bfs(0,6)))
print("Path between 0 & 6 : " + String(gph.dfsStack(0,6)))
}
    // 	Path between 0 & 6 : true
    // 	Path between 0 & 6 : true
    // 	Path between 0 & 6 : true

func topologicalSort() {
    var stk :  [Int] =  [Int]()
    var visited : [Bool] = Array(repeating: false, count: self.count)

    var i : Int = 0
    while (i < self.count) {
        if (visited[i] == false) {
            self.dfsUtil2(i, &visited,&stk)
        }
        i += 1
    }
    
    print("Topological Sort::",terminator: "")
    while (stk.isEmpty != true) {
        print(" " + String(stk.removeLast()),terminator: "")
    }
}

    // Testing Code
    static func main2() {
let gph : Graph = Graph(9)
gph.addDirectedEdge(0,2)
gph.addDirectedEdge(1,2)
gph.addDirectedEdge(1,3)
gph.addDirectedEdge(1,4)
gph.addDirectedEdge(3,2)
gph.addDirectedEdge(3,5)
gph.addDirectedEdge(4,5)
gph.addDirectedEdge(4,6)
gph.addDirectedEdge(5,7)
gph.addDirectedEdge(6,7)
gph.addDirectedEdge(7,8)
gph.topologicalSort()
    }
    // 	Topological Sort:: 1 4 6 3 5 7 8 0 2

func pathExist(_ source : Int, _ dest : Int) -> Bool {
    var visited : [Bool] = Array(repeating: false, count: self.count)
    self.dfsUtil(source, &visited)
    return visited[dest]
}

func countAllPathDFS(_ visited : inout [Bool], _ source : Int, _ dest : Int) -> Int {
    if (source == dest) {
        return 1
    }
    var count : Int = 0
    visited[source] = true
    var adn = self.VertexList[source]        
    while adn != nil { 
        if (visited[adn!.dest] == false) {
            count += self.countAllPathDFS( &visited,adn!.dest,dest)
        }
        adn = adn!.next
    }
    visited[source] = false
    return count
}

func countAllPath(_ src : Int, _ dest : Int) -> Int {
    var visited : [Bool] = Array(repeating: false, count: self.count)
    return self.countAllPathDFS( &visited,src,dest)
}

func printAllPathDFS(_ visited : inout [Bool], _ source : Int, _ dest : Int, _ path : inout [Int]) {
    path.append(source)
    if (source == dest) {
        print(path)
        path.removeLast()
        return
    }
    visited[source] = true
    var adn = self.VertexList[source]
    while adn != nil { 
        if (visited[adn!.dest] == false) {self.printAllPathDFS( &visited,adn!.dest,dest,&path)
        }
        adn = adn!.next
    }
    visited[source] = false
    path.removeLast()
}

func printAllPath(_ src : Int, _ dest : Int) {
    var visited : [Bool] = Array(repeating: false, count: self.count)
    var path :  [Int] =  [Int]()
    self.printAllPathDFS( &visited,src,dest,&path)
}

    // Testing Code
    static func main3() {
let gph : Graph = Graph(5)
gph.addDirectedEdge(0,1)
gph.addDirectedEdge(0,2)
gph.addDirectedEdge(2,3)
gph.addDirectedEdge(1,3)
gph.addDirectedEdge(3,4)
gph.addDirectedEdge(1,4)
gph.printGraph()
	print("PathExist :: " + String(gph.pathExist(0,4)))
	print("Path Count :: " + String(gph.countAllPath(0,4)))
gph.printAllPath(0,4)
    }
    // 	Vertex 0 is connected to : 1(cost: 1) 2(cost: 1) 
    // 	Vertex 1 is connected to : 3(cost: 1) 4(cost: 1) 
    // 	Vertex 2 is connected to : 3(cost: 1) 
    // 	Vertex 3 is connected to : 4(cost: 1) 
    // 	Vertex 4 is connected to : 
    // 	PathExist :: true
    // 	Path Count :: 3
    // 	[0, 1, 3, 4]
    // 	[0, 1, 4]
    // 	[0, 2, 3, 4]

func rootVertex() -> Int {
    var visited : [Bool] = Array(repeating: false, count: self.count)
    var retVal : Int = -1

    var i : Int = 0
    while (i < self.count) {
        if (visited[i] == false) {
            self.dfsUtil(i, &visited)
            retVal = i
        }
        i += 1
    }
    
    print("Root vertex is :: " + String(retVal),terminator: "")
    return retVal
}

    // Testing Code
    static func main4() {
let gph : Graph = Graph(7)
gph.addDirectedEdge(0,1)
gph.addDirectedEdge(0,2)
gph.addDirectedEdge(1,3)
gph.addDirectedEdge(4,1)
gph.addDirectedEdge(6,4)
gph.addDirectedEdge(5,6)
gph.addDirectedEdge(5,2)
gph.addDirectedEdge(6,0)
_ = gph.rootVertex()
    }
    // 	Root vertex is :: 5

func transitiveClosureUtil(_ source : Int, _ dest : Int, _ tc : inout [[Int]]) {
    tc[source][dest] = 1
    var adn = self.VertexList[dest]
    while adn != nil { 
        if (tc[source][adn!.dest] == 0) {self.transitiveClosureUtil(source,adn!.dest, &tc)
        }
        adn = adn!.next
    }
}

func transitiveClosure() -> [[Int]] {
    var tc : [[Int]] = Array(repeating: Array(repeating: 0, count: self.count), count: self.count)

    var i : Int = 0
    while (i < self.count) {
        self.transitiveClosureUtil(i,i, &tc)
        i += 1
    }
    
    return tc
}

    // Testing Code
    static func main5() {
let gph : Graph = Graph(4)
gph.addDirectedEdge(0,1)
gph.addDirectedEdge(0,2)
gph.addDirectedEdge(1,2)
gph.addDirectedEdge(2,0)
gph.addDirectedEdge(2,3)
gph.addDirectedEdge(3,3)
let tc : [[Int]] = gph.transitiveClosure()

var i : Int = 0
while (i < 4) {
    var j : Int = 0
    while (j < 4) {
        print(String(tc[i][j]), terminator: " ")
        j += 1
    }
    print()
    i += 1
}
    }
    // 	1 1 1 1 
    // 	1 1 1 1 
    // 	1 1 1 1 
    // 	0 0 0 1

func bfsLevelNode(_ source : Int) {
    var visited : [Bool] = Array(repeating: false, count: self.count)
    var level : [Int] = Array(repeating: 0, count: self.count)
    visited[source] = true
    let que = Queue<Int>()
    que.add(source)
    level[source] = 0
    print("Node  - Level")
    while (que.isEmpty == false) {
        let curr : Int = que.remove()!
        let depth : Int = level[curr]
        var adn = self.VertexList[curr]
        print(String(curr) + " - " + String(depth))
        while adn != nil { 
            if (visited[adn!.dest] == false) {
                visited[adn!.dest] = true
                que.add(adn!.dest)
                level[adn!.dest] = depth + 1
            }
            adn = adn!.next
        }
    }
}
   
func bfsDistance(_ source : Int, _ dest : Int) -> Int {
    var visited : [Bool] = Array(repeating: false, count: self.count)
    let que = Queue<Int>()
    que.add(source)
    visited[source] = true
    var level : [Int] = Array(repeating: 0, count: self.count)
    level[source] = 0
    while (que.isEmpty == false) {
        let curr : Int = que.remove()!
        let depth : Int = level[curr]
        var adn = self.VertexList[curr]
        while adn != nil { 
            if (adn!.dest == dest) {
                return depth + 1
            }
            if (visited[adn!.dest] == false) {
                visited[adn!.dest] = true
                que.add(adn!.dest)
                level[adn!.dest] = depth + 1
            }
            adn = adn!.next
        }
    }
    return -1
}

    // Testing Code
    static func main6() {
let gph : Graph = Graph(7)
gph.addUndirectedEdge(0,1)
gph.addUndirectedEdge(0,2)
gph.addUndirectedEdge(0,4)
gph.addUndirectedEdge(1,2)
gph.addUndirectedEdge(2,5)
gph.addUndirectedEdge(3,4)
gph.addUndirectedEdge(4,5)
gph.addUndirectedEdge(4,6)
gph.bfsLevelNode(1)
print("BfsDistance(1, 6) : " + String(gph.bfsDistance(1,6)))
    }

    // 	Node  - Level
    // 	1 - 0
    // 	0 - 1
    // 	2 - 1
    // 	4 - 2
    // 	5 - 2
    // 	3 - 3
    // 	6 - 3
    // 	BfsDistance :: 3

func isCyclePresentUndirectedDFS(_ index : Int, _ parentIndex : Int, _ visited : inout [Bool]) -> Bool {
    visited[index] = true
    var dest : Int
    var adn = self.VertexList[index]
    while adn != nil { 
        dest = adn!.dest
        if (visited[dest] == false) {
            if (self.isCyclePresentUndirectedDFS(dest,index, &visited)) {
                return true
            }
        } else if(parentIndex != dest) {
            return true
        }
        adn = adn!.next
    }
    return false
}

func isCyclePresentUndirected() -> Bool {
    var visited : [Bool] = Array(repeating: false, count: self.count)
    var i : Int = 0
    while (i < self.count) {
        if (visited[i] == false && self.isCyclePresentUndirectedDFS(i,-1, &visited)) {
            return true
        }
        i += 1
    }   
    return false
}

func find(_ parent : inout [Int], _ index : Int) -> Int {
    var index = index
    var p : Int = parent[index]
    while (p != -1) {
        index = p
        p = parent[index]
    }
    return index
}

func union(_ parent : inout [Int], _ x : Int, _ y : Int) {
    parent[y] = x
}

func isCyclePresentUndirected2() -> Bool {
    var parent : [Int] = Array(repeating: -1, count: self.count)
    var edge :  [Edge?] =  [Edge?]()
    var flags : [[Bool]] = Array(repeating: Array(repeating: false, count: self.count), count: self.count)

    var i : Int = 0
    while (i < self.count) {
        var adn = self.VertexList[i]
        while adn != nil {
            // Using flags[][] array, if considered edge x to y,
            // then ignore edge y to x.
            if (flags[adn!.dest][adn!.src] == false) {
                edge.append(adn)
                flags[adn!.src][adn!.dest] = true
            }
            adn = adn!.next
        }
        i += 1
    }
    
    for e in edge{
        let x : Int = self.find( &parent,e!.src)
        let y : Int = self.find( &parent,e!.dest)
        if (x == y) {
            return true
        }
        self.union( &parent,x,y)
    }
    return false
}

func isCyclePresentUndirected3() -> Bool {
    // Different subsets are created.
    var sets : [Sets?] = Array(repeating: nil, count: self.count)

    var i : Int = 0
    while (i < self.count) {
        sets[i] = Sets(i, 0)
        i += 1
    }
    
    var edge :  [Edge?] =  [Edge?]()
    var flags : [[Bool]] = Array(repeating: Array(repeating: false, count: self.count), count: self.count)

    i = 0
    while (i < self.count) {
        var adn = self.VertexList[i]
        while adn != nil {
            // Using flags[][] array, if considered edge x to y,
            // then ignore edge y to x.
            if (flags[adn!.dest][adn!.src] == false) {
                edge.append(adn)
                flags[adn!.src][adn!.dest] = true
            }
            adn = adn!.next
        }
        i += 1
    }
    
    for e in edge{
        let x : Int = self.find( &sets,e!.src)
        let y : Int = self.find( &sets,e!.dest)
        if (x == y) {
            return true
        }
        self.union( &sets,x,y)
    }
    return false
}

    // Testing Code
    static func main7() {
let gph : Graph = Graph(6)
gph.addUndirectedEdge(0,1)
gph.addUndirectedEdge(1,2)
gph.addUndirectedEdge(3,4)
gph.addUndirectedEdge(4,2)
gph.addUndirectedEdge(2,5)
print("Cycle Presen : " + String(gph.isCyclePresentUndirected()))
print("Cycle Presen : " + String(gph.isCyclePresentUndirected2()))
print("Cycle Presen : " + String(gph.isCyclePresentUndirected3()))
gph.addUndirectedEdge(4,1)
print("Cycle Presen : " + String(gph.isCyclePresentUndirected()))
        print("Cycle Presen : " + String(gph.isCyclePresentUndirected2()))
        print("Cycle Presen : " + String(gph.isCyclePresentUndirected3()))
    }
    // 	Cycle Presen : false
    // 	Cycle Presen : false
    // 	Cycle Presen : false
    // 	Cycle Presen : true
    // 	Cycle Presen : true
    // 	Cycle Presen : true


func isCyclePresentDFS(_ index : Int, _ visited : inout [Bool], _ marked : inout [Int]) -> Bool {
    visited[index] = true
    marked[index] = 1
    var adn = self.VertexList[index]
    while adn != nil { 
        let dest : Int = adn!.dest
        if (marked[dest] == 1) {
            return true
        }
        if (visited[dest] == false) {
            if (self.isCyclePresentDFS(dest, &visited, &marked)) {
                return true
            }
        }
        adn = adn!.next
    }
    marked[index] = 0
    return false
}

func isCyclePresent() -> Bool {
    var visited : [Bool] = Array(repeating: false, count: self.count)
    var marked : [Int] = Array(repeating: 0, count: self.count)

    var index : Int = 0
    while (index < self.count) {
        if (!visited[index]) {
            if (self.isCyclePresentDFS(index, &visited, &marked)) {
                return true
            }
        }
        index += 1
    }
    return false
}

func isCyclePresentDFSColour(_ index : Int, _ visited : inout [Int]) -> Bool {
    visited[index] = 1 // 1 = grey
    var dest : Int
    var adn = self.VertexList[index]
    while adn != nil { 
        dest = adn!.dest
        if (visited[dest] == 1) { // "Grey":
            return true
        }
        if (visited[dest] == 0) { // "White":
            if (self.isCyclePresentDFSColour(dest, &visited)) {
                return true
            }
        }
        adn = adn!.next
    }
    visited[index] = 2 // "Black"
    return false
}

func isCyclePresentColour() -> Bool {
    var visited : [Int] = Array(repeating: 0, count: self.count)
    var i : Int = 0
    while (i < self.count) {
        if (visited[i] == 0) { // "White"
            if (self.isCyclePresentDFSColour(i, &visited)) {
                return true
            }
        }
        i += 1
    }
    return false
}

    // Testing Code
    static func main8() {
let gph : Graph = Graph(5)
gph.addDirectedEdge(0,1)
gph.addDirectedEdge(0,2)
gph.addDirectedEdge(2,3)
gph.addDirectedEdge(1,3)
gph.addDirectedEdge(3,4)
print("isCyclePresent : " + String(gph.isCyclePresent()))
print("isCyclePresent : " + String(gph.isCyclePresentColour()))
gph.addDirectedEdge(4,1)
print("isCyclePresent : " + String(gph.isCyclePresent()))
print("isCyclePresent : " + String(gph.isCyclePresentColour()))
    }
    // 	isCyclePresent : false
    // 	isCyclePresent : false
    // 	isCyclePresent : true
    // 	isCyclePresent : true

func transposeGraph() -> Graph {
    let g : Graph = Graph(self.count)

    var i : Int = 0
    while (i < self.count) {
        var adn = self.VertexList[i]
        while adn != nil { 
            let dest : Int = adn!.dest
            g.addDirectedEdge(dest,i)
            adn = adn!.next
        }
        i += 1
    }
    return g
}

// Testing Code
static func main9() {
let gph : Graph = Graph(5)
gph.addDirectedEdge(0,1)
gph.addDirectedEdge(0,2)
gph.addDirectedEdge(2,3)
gph.addDirectedEdge(1,3)
gph.addDirectedEdge(3,4)
gph.addDirectedEdge(4,1)
let gReversed : Graph = gph.transposeGraph()
gReversed.printGraph()
}
    // 	Vertex 0 is connected to : 
    // 	Vertex 1 is connected to : 0(cost: 1) 4(cost: 1) 
    // 	Vertex 2 is connected to : 0(cost: 1) 
    // 	Vertex 3 is connected to : 1(cost: 1) 2(cost: 1) 
    // 	Vertex 4 is connected to : 3(cost: 1)

func isConnectedUndirected() -> Bool {
    var visited : [Bool] = Array(repeating: false, count: self.count)
    self.dfsUtil(0, &visited)
    var i : Int = 0
    while (i < self.count) {
        if (visited[i] == false) {
            return false
        }
        i += 1
    }
    return true
}

// Testing Code
static func main10A() {
let gph : Graph = Graph(6)
gph.addUndirectedEdge(0,1)
gph.addUndirectedEdge(1,2)
gph.addUndirectedEdge(3,4)
gph.addUndirectedEdge(4,2)
gph.addUndirectedEdge(2,5)
print("isConnectedUndirected:: " + String(gph.isConnectedUndirected()))
}

    // 	isConnectedUndirected:: true

func isStronglyConnected() -> Bool {
    var visited : [Bool] = Array(repeating: false, count: self.count)
    self.dfsUtil(0, &visited)
    var i : Int = 0
    while (i < self.count) {
        if (visited[i] == false) {
            return false
        }
        i += 1
    }
    
    let gReversed : Graph? = self.transposeGraph()
    i = 0
    while (i < self.count) {
        visited[i] = false
        i += 1
    }
    
    gReversed!.dfsUtil(0, &visited)
    i = 0
    while (i < self.count) {
        if (visited[i] == false) {
            return false
        }
        i += 1
    } 
    return true
}

// Testing Code
static func main10() {
let gph : Graph = Graph(5)
gph.addDirectedEdge(0,1)
gph.addDirectedEdge(1,2)
gph.addDirectedEdge(2,3)
gph.addDirectedEdge(3,0)
gph.addDirectedEdge(2,4)
gph.addDirectedEdge(4,2)
print("IsStronglyConnected:: " + String(gph.isStronglyConnected()))
}
    // 	IsStronglyConnected:: true

func stronglyConnectedComponent() {
    var visited : [Bool] = Array(repeating: false, count: self.count)
    var stk :  [Int] =  [Int]()

    var i : Int = 0
    while (i < self.count) {
        if (visited[i] == false) {self.dfsUtil2(i, &visited,&stk)
        }
        i += 1
    }
    
    let gReversed : Graph? = self.transposeGraph()
    visited = Array(repeating: false, count: self.count)

    var stk2 :  [Int] =  [Int]()
    var index : Int
    while (stk.isEmpty == false) {
        index = stk.removeLast()
        if (visited[index] == false) {
            stk2.removeAll()
            gReversed!.dfsUtil2(index, &visited,&stk2)
            print(stk2)
        }
    }
}

// Testing Code
static func main11() {
let gph : Graph = Graph(7)
gph.addDirectedEdge(0,1)
gph.addDirectedEdge(1,2)
gph.addDirectedEdge(2,0)
gph.addDirectedEdge(2,3)
gph.addDirectedEdge(3,4)
gph.addDirectedEdge(4,5)
gph.addDirectedEdge(5,3)
gph.addDirectedEdge(5,6)
gph.stronglyConnectedComponent()
}

    // 	[1, 2, 0]
    // 	[4, 5, 3]
    // 	[6]

func primsMST() {
    var previous : [Int] = Array(repeating: -1, count: self.count)
    var dist : [Int] = Array(repeating: Int.max, count: self.count)
    var visited : [Bool] = Array(repeating: false, count: self.count)
    var source : Int = 0
    dist[source] = 0
    previous[source] = source

    let queue = Heap<Edge>(true)
    var eg : Edge = Edge(source, source, 0)
    queue.add(eg)
    while (queue.isEmpty != true) {
        eg = queue.remove()!
        visited[source] = true
        source = eg.dest
        var adn = self.VertexList[source]
        while adn != nil { 
            let dest : Int = adn!.dest
            let alt : Int = adn!.cost
            if (dist[dest] > alt && visited[dest] == false) {
                dist[dest] = alt
                previous[dest] = source
                eg = Edge(source, dest, alt)
                queue.add(eg)
            }
            adn = adn!.next
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
        } else if(previous[i] != i) {
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

class Sets {
    var parent : Int
    var rank : Int
    init(_ p : Int, _ r : Int) {
        self.parent = p
        self.rank = r
    }
}

// root element of set
func find(_ sets : inout [Sets?], _ index : Int) -> Int {
    var index = index
    var p : Int = sets[index]!.parent
    while (p != index) {
        index = p
        p = sets[index]!.parent
    }
    return index
}

// consider x and y are roots of sets.
func union(_ sets : inout [Sets?], _ x : Int, _ y : Int) {
    if (sets[x]!.rank < sets[y]!.rank) {
        sets[x]!.parent = y
    }
    else
    if (sets[y]!.rank < sets[x]!.rank) {
        sets[y]!.parent = x
    } else {
        sets[x]!.parent = y
        sets[y]!.rank += 1
    }
}

func kruskalMST() {
    // Different subsets are created.
    var sets : [Sets?] = Array(repeating: nil, count: self.count)

    var i : Int = 0
    while (i < self.count) {
        sets[i] = Sets(i, 0)
        i += 1
    }
    
    // Edges are added to array and sorted.
    var E : Int = 0
    var edge : [Edge] = [Edge]() 

    i = 0
    while (i < self.count) {
        var adn = self.VertexList[i]
        while adn != nil {
            edge.append(adn!)
            adn = adn!.next
            E += 1
        }
        i += 1
    }
    edge = edge.sorted( by: <)
    //edge.sort( by: Edge.<)
    var sum : Int = 0
    var output : String = "Edges are "

    i = 0
    while (i < E) {
        let x : Int = self.find( &sets,edge[i].src)
        let y : Int = self.find( &sets,edge[i].dest)
        if (x != y) {
            output += ("(" + String(edge[i].src) + "->" + String(edge[i].dest) + " @ " + String(edge[i].cost) + ") ")
            sum += edge[i].cost
            self.union( &sets,x,y)
        }
        i += 1
    }
    
    print(output)
    print("Total MST cost: " + String(sum))
}

    // Testing Code
    static func main12() {
let gph : Graph = Graph(9)
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
	print()
	gph.primsMST()
        print()
        gph.kruskalMST()
        print()
gph.dijkstra(0)
    }
    // 	Edges are (0->1 @ 4) (5->2 @ 4) (2->3 @ 7) (3->4 @ 9) (6->5 @ 2) (7->6 @ 1) (0->7 @ 8) (2->8 @ 2) 
    // 	Total MST cost: 37
    // 	Edges are (6->7 @ 1) (2->8 @ 2) (5->6 @ 2) (0->1 @ 4) (2->5 @ 4) (2->3 @ 7) (0->7 @ 8) (3->4 @ 9) 
    // 	Total MST cost: 37
    // 	Shortest Paths: (0->1 @ 4) (0->1->2 @ 12) (0->1->2->3 @ 19) (0->7->6->5->4 @ 21) (0->7->6->5 @ 11) (0->7->6 @ 9) (0->7 @ 8) (0->1->2->8 @ 14)

    // Unweighed graph
func shortestPath(_ source : Int) {
    var curr : Int
    var distance : [Int] = Array(repeating: -1, count: self.count)
    var path : [Int] = Array(repeating: -1, count: self.count)
    
    var que : [Int] = [Int]()        
    que.append(source)
    distance[source] = 0
    path[source] = source
    while (que.isEmpty == false) {
        curr = que.removeFirst()
        var adn = self.VertexList[curr]
        while adn != nil { 
            if (distance[adn!.dest] == -1) {
                distance[adn!.dest] = distance[curr] + 1
                path[adn!.dest] = curr
                que.append(adn!.dest)
            }
            adn = adn!.next
        }
    }
    self.printPath( &path, &distance,self.count,source)
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
        } else if(i != previous[i]) {
            output += "("
            output += self.printPathUtil( &previous,source,i)
            output += (" @ " + String(dist[i]) + ") ")
        }
        i += 1
    }    
    print(output)
}

func dijkstra(_ source : Int) {
    var previous : [Int] = Array(repeating: -1, count: self.count)
    var dist : [Int] = Array(repeating: 99999, count: self.count)
    var visited : [Bool] = Array(repeating: false, count: self.count)
    // infinite
    dist[source] = 0
    previous[source] = source

	let queue = Heap<Edge>(true)
    var edge : Edge = Edge(source, source, 0)
    queue.add(edge)
    var curr : Int

    while (queue.isEmpty != true) {
        edge = queue.remove()!
        curr = edge.dest
        visited[curr] = true
        var adn = self.VertexList[curr]
        while adn != nil { 
            let dest : Int = adn!.dest
            let alt : Int = adn!.cost + dist[curr]
            if (alt < dist[dest] && visited[dest] == false) {
                dist[dest] = alt
                previous[dest] = curr
                edge = Edge(curr, dest, alt)
                queue.add(edge)
            }
            adn = adn!.next
        }
    }
    self.printPath( &previous, &dist,self.count,source)
}

func bellmanFordShortestPath(_ source : Int) {
    var distance : [Int] = Array(repeating: 99999, count: self.count)
    var path : [Int] = Array(repeating: -1, count: self.count)
    distance[source] = 0
    path[source] = source

    var i : Int = 0
    // Outer loop will run (V-1) number of times.
    // Inner for loop and while loop runs combined will
    // run for Edges number of times.
    // Which make the total complexity as O(V*E)
    while (i < self.count - 1) {
        var j : Int = 0
        while (j < self.count) {
            var adn = self.VertexList[j]
            while adn != nil { 
                let newDistance : Int = distance[j] + adn!.cost
                if (distance[adn!.dest] > newDistance) {
                    distance[adn!.dest] = newDistance
                    path[adn!.dest] = j
                }
                adn = adn!.next
            }
            j += 1
        } 
        i += 1
    }
    self.printPath( &path, &distance,self.count,source)
}

// Testing Code
static func main13() {
let gph : Graph = Graph(5)
gph.addDirectedEdge(0,1,3)
gph.addDirectedEdge(0,4,2)
gph.addDirectedEdge(1,2,1)
gph.addDirectedEdge(2,3,1)
gph.addDirectedEdge(4,1,-2)
gph.addDirectedEdge(4,3,1)
gph.bellmanFordShortestPath(0)
}
    // 	Shortest Paths: (0->4->1 @ 0) (0->4->1->2 @ 1) (0->4->1->2->3 @ 2) (0->4 @ 2)
    
    static func heightTreeParentArr(_ arr : inout [Int]) -> Int {
        let count : Int = arr.count
        var heightArr : [Int] = Array(repeating: 0, count: count)
        let gph : Graph = Graph(count)
        var source : Int = 0

        var i : Int = 0
        while (i < count) {
            if (arr[i] != -1) {
                gph.addDirectedEdge(arr[i],i)
            }
            else
            {
                source = i
            }
            i += 1
        }
        
        var visited : [Bool] = Array(repeating: false, count: count)
        visited[source] = true
        var que : [Int] = [Int]()
        que.append(source)
        heightArr[source] = 0
        var maxHight : Int = 0
        while (que.isEmpty == false) {
            let curr : Int = que.removeFirst()
            let height : Int = heightArr[curr]
            if (height > maxHight) {
                maxHight = height
            }
            var adn = gph.VertexList[curr]
            while adn != nil { 
                if (visited[adn!.dest] == false) {
                    visited[adn!.dest] = true
                    que.append(adn!.dest)
                    heightArr[adn!.dest] = height + 1
                }
                adn = adn!.next
            }
        }
        return maxHight
    }

    static func getHeight(_ arr : inout [Int], _ height : inout [Int], _ index : Int) -> Int {
        if (arr[index] == -1) {
            return 0
        } else {
            return Graph.getHeight( &arr, &height,arr[index]) + 1
        }
    }

    static func heightTreeParentArr2(_ arr : inout [Int]) -> Int {
        let count : Int = arr.count
        var height : [Int] = Array(repeating: 0, count: count)
        var maxHeight : Int = -1

        var i : Int = 0
        while (i < count) {
            height[i] = Graph.getHeight( &arr, &height,i)
            maxHeight = max(maxHeight,height[i])
            i += 1
        }
        
        return maxHeight
    }

    // Testing Code
    static func main14() {
        var parentArray : [Int] = [-1, 0, 1, 2, 3]
        print(Graph.heightTreeParentArr( &parentArray))
        print(Graph.heightTreeParentArr2( &parentArray))
    }
    // 	4
    // 	4

    func isConnected() -> Bool {
        var visited : [Bool] = Array(repeating: false, count: self.count)
        // Find a vertex with non - zero degree
        // DFS traversal of graph from a vertex with non - zero degree
        var adn : Edge?

        var i : Int = 0
        while (i < self.count) {
            adn = self.VertexList[i]
            if (adn != nil) {
                self.dfsUtil(i, &visited)
                break
            }
            i += 1
        }

        i = 0
        // Check if all non - zero degree count are visited
        while (i < self.count) {
            adn = self.VertexList[i]
            if (adn != nil) {
                if (visited[i] == false) {
                    return false
                }
            }
            i += 1
        }
        
        return true
    }

func isEulerian() -> Int {
    // Check if all non - zero degree nodes are connected
    if (self.isConnected() == false) {
        print("graph is not Eulerian")
        return 0
    }
    // Count odd degree
    var odd : Int = 0
    var inDegree : [Int] = Array(repeating: 0, count: self.count)
    var outDegree : [Int] = Array(repeating: 0, count: self.count)
    var adn : Edge?

    var i : Int = 0
    while (i < self.count) {
        adn = self.VertexList[i]
        while adn != nil { 
            outDegree[i] += 1
            inDegree[adn!.dest] += 1
            adn = adn!.next
        }
        i += 1
    }

    i = 0
    while (i < self.count) {
        if ((inDegree[i] + outDegree[i]) % 2 != 0) {
            odd += 1
        }
        i += 1
    }
    
    if (odd == 0) {
        print("graph is Eulerian")
        return 2
    }
    else
    if (odd == 2) {
        print("graph is Semi-Eulerian")
        return 1
    } else {
        print("graph is not Eulerian")
        return 0
    }
}

// Testing Code
static func main15() {
let gph : Graph = Graph(5)
gph.addDirectedEdge(1,0)
gph.addDirectedEdge(0,2)
gph.addDirectedEdge(2,1)
gph.addDirectedEdge(0,3)
gph.addDirectedEdge(3,4)
_ = gph.isEulerian()
gph.addDirectedEdge(4,0)
_ = gph.isEulerian()
}

    // 	graph is Semi-Eulerian
    // 	graph is Eulerian

    func isStronglyConnected2() -> Bool {
        var visited : [Bool] = Array(repeating: false, count: self.count)
        // Find a vertex with non - zero degree

        var index : Int = 0
        while (index < self.count) {
            let adn = self.VertexList[index]
            if (adn != nil) {
                break
            }
            index += 1
        }
        
        // DFS traversal of graph from a vertex with non - zero degree
        self.dfsUtil(index, &visited)

        var i : Int = 0
        while (i < self.count) {
            let adn = self.VertexList[i]
            if (visited[i] == false && adn != nil) {
                return false
            }
            i += 1
        }
        
        let gReversed : Graph? = self.transposeGraph()

        i = 0
        while (i < self.count) {
            visited[i] = false
            i += 1
        }
        
        gReversed!.dfsUtil(index, &visited)

        i = 0
        while (i < self.count) {
            let adn = self.VertexList[i]
            if (visited[i] == false && adn != nil) {
                return false
            }
            i += 1
        }
        
        return true
    }

    func isEulerianCycle() -> Bool {
        // Check if all non - zero degree count are connected
        var inDegree : [Int] = Array(repeating: 0, count: self.count)
        var outDegree : [Int] = Array(repeating: 0, count: self.count)
        if (!self.isStronglyConnected2()) {
            return false
        }

        var i : Int = 0
        // Check if in degree and out degree of every vertex is same
        while (i < self.count) {
            var adn = self.VertexList[i]
            while adn != nil { 
                outDegree[i] += 1
                inDegree[adn!.dest] += 1
                adn = adn!.next
            }
            i += 1
        }

        i = 0
        while (i < self.count) {
            if (inDegree[i] != outDegree[i]) {
                return false
            }
            i += 1
        }
        return true
    }

    // Testing Code
    static func main16() {
        let gph : Graph = Graph(5)
        gph.addDirectedEdge(0,1)
        gph.addDirectedEdge(1,2)
        gph.addDirectedEdge(2,0)
        gph.addDirectedEdge(0,4)
        gph.addDirectedEdge(4,3)
        gph.addDirectedEdge(3,0)
        print(gph.isEulerianCycle())
    }

    // 	true

    // Testing Code
    static func main17() {
        let gph : Graph = Graph(7)
        gph.addDirectedEdge(0,1)
        gph.addDirectedEdge(1,2)
        gph.addDirectedEdge(2,0)
        gph.addDirectedEdge(2,3)
        gph.addDirectedEdge(3,4)
        gph.addDirectedEdge(4,5)
        gph.addDirectedEdge(5,3)
        gph.addDirectedEdge(5,6)
        let gReversed : Graph = gph.transposeGraph()
        gReversed.printGraph()
    }

    // 	Vertex 0 is connected to : 2(cost: 1) 
    // 	Vertex 1 is connected to : 0(cost: 1) 
    // 	Vertex 2 is connected to : 1(cost: 1) 
    // 	Vertex 3 is connected to : 2(cost: 1) 5(cost: 1) 
    // 	Vertex 4 is connected to : 3(cost: 1) 
    // 	Vertex 5 is connected to : 4(cost: 1) 
    // 	Vertex 6 is connected to : 5(cost: 1)

    // Testing Code
    static func main18() {
let gph : Graph = Graph(9)
gph.addUndirectedEdge(0,1)
gph.addUndirectedEdge(0,7)
gph.addUndirectedEdge(1,2)
gph.addUndirectedEdge(1,7)
gph.addUndirectedEdge(2,3)
gph.addUndirectedEdge(2,8)
gph.addUndirectedEdge(2,5)
gph.addUndirectedEdge(3,4)
gph.addUndirectedEdge(3,5)
gph.addUndirectedEdge(4,5)
gph.addUndirectedEdge(5,6)
gph.addUndirectedEdge(6,7)
gph.addUndirectedEdge(6,8)
gph.addUndirectedEdge(7,8)
gph.shortestPath(0)
    }
    // 	Shortest Paths: (0->1 @ 1)(0->1->2 @ 2)(0->1->2->3 @ 3)(0->1->2->3->4 @ 4)(0->1->2->5 @ 3)(0->7->6 @ 2)(0->7 @ 1)(0->7->8 @ 2)
    
func floydWarshall() {
    let V : Int = self.count
    var dist : [[Int]] = Array(repeating: Array(repeating: 0, count: V), count: V)
    var path : [[Int]] = Array(repeating: Array(repeating: 0, count: V), count: V)
    let INF : Int = 99999

    var i : Int = 0
    while (i < V) {
        var j : Int = 0
        while (j < V) {
            dist[i][j] = INF
            if (i == j) {
                path[i][j] = 0
            }
            else
            {
                path[i][j] = -1
            }
            j += 1
        }
        i += 1
    }
    

    i = 0
    while (i < V) {
        var adn = self.VertexList[i]
        while adn != nil { 
            path[adn!.src][adn!.dest] = adn!.src
            dist[adn!.src][adn!.dest] = adn!.cost
            adn = adn!.next
        }
        i += 1
    }

    var k : Int = 0
    // Pick intermediate vertices.
    while (k < V) {
        i = 0
        // Pick source vertices one by one.
        while (i < V) {
            var j : Int = 0
            // Pick destination vertices.
            while (j < V) {
                // If we have a shorter path from i to j via k.
                // then update dist[i][j] and  and path[i][j]
                if (dist[i][k] + dist[k][j] < dist[i][j]) {
                    dist[i][j] = dist[i][k] + dist[k][j]
                    path[i][j] = path[k][j]
                }
                j += 1
            }
            // dist[i][i] is 0 in the start.
            // If there is a better path from i to i and is better path then we have -ve cycle.                //
            if (dist[i][i] < 0) {
                print("Negative-weight cycle found.")
                return
            }
            i += 1
        }
        k += 1
    }
    self.printSolution( &dist, &path,V)
}

func printSolution(_ cost : inout [[Int]], _ path : inout [[Int]], _ V : Int) {
    print("Shortest Paths : ",terminator: "")
    var u : Int = 0
    while (u < V) {
        var v : Int = 0
        while (v < V) {
            if (u != v && path[u][v] != -1) {
                print("(",terminator: "")
                self.printPath2( &path,u,v)
                print(" @ " + String(cost[u][v]) + ") ",terminator: "")
            }
            v += 1
        }
        u += 1
    }
    print()
}

func printPath2(_ path : inout [[Int]], _ u : Int, _ v : Int) {
    if (path[u][v] == u) {
        print(String(u) + "->" + String(v),terminator: "")
        return
    }
    self.printPath2( &path,u,path[u][v])
    print("->" + String(v),terminator: "")
}

    // Testing code.
    static func main19() {
let gph : Graph = Graph(4)
gph.addDirectedEdge(0,0,0)
gph.addDirectedEdge(1,1,0)
gph.addDirectedEdge(2,2,0)
gph.addDirectedEdge(3,3,0)
gph.addDirectedEdge(0,1,5)
gph.addDirectedEdge(0,3,10)
gph.addDirectedEdge(1,2,3)
gph.addDirectedEdge(2,3,1)
gph.floydWarshall()
    }
    // 	Shortest Paths : (0->1 @ 5) (0->1->2 @ 8) (0->1->2->3 @ 9) (1->2 @ 3) (1->2->3 @ 4) (2->3 @ 1)
}


Graph.main0()
Graph.main1()
Graph.main2() 
Graph.main3() 
Graph.main4() 
Graph.main5() 
Graph.main6() 
Graph.main7() 
Graph.main8()
Graph.main9()
Graph.main10A()
Graph.main10()
Graph.main11()
Graph.main12()
Graph.main13()
Graph.main14()
Graph.main15()
Graph.main16()
Graph.main17()
Graph.main18()
Graph.main19()
