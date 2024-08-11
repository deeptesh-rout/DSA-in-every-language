class Stack<T> {
	var stk = [T]()
	
	public init() {}
    
    /* Other methods */

	public func isEmpty() -> Bool {
		return stk.isEmpty
	}
	
	public func size() -> Int {
		return stk.count
	}

	public func push(_ value : T) {
		stk.append(value)
	}
	
	public func pop() -> T? {
		if stk.isEmpty  { 
			return nil 
		}
		return stk.removeLast()
	}
	
	public func top() -> T? {
		return stk.last
	}

	public func display() {
		print(stk)
	}
}

class Queue<T> {
	private var que = [T]()

	public init() {}

	public func isEmpty() -> Bool {
		return que.isEmpty
	}

	public func size() -> Int {
		return que.count
	}
	
	public func add(_ value : T) {
		que.append(value)
	}
	
	public func remove() -> T? {
		if que.isEmpty { 
			return nil 
		}
		return que.removeFirst()
	}

	public func front() -> T? {
		return que.first
	}

	public func display() {
		print("Queue :", que)
	}
}

public class BinaryTree {
	public class Node {
		var value : Int
		var left : Node?
		var right : Node?

		public init(_ value : Int) {
			self.value = value
			self.left = nil
			self.right = nil
		}
	}

	private var root : Node? = nil

	// Other Methods


public func createCompleteBinaryTree(arr : [Int]){
	self.root = createCompleteBinaryTreeUtil(arr : arr, start : 0, size : arr.count)
}

private func createCompleteBinaryTreeUtil(arr : [Int], start : Int, size : Int) -> Node {
	let curr = Node(arr[start])
	let left = 2*start + 1
	let right = 2*start + 2

	if left < size {
		curr.left = createCompleteBinaryTreeUtil(arr : arr, start : left, size : size)
	}
	if right < size {
		curr.right = createCompleteBinaryTreeUtil(arr : arr, start : right, size : size)
	}
	return curr
}

public func add(value : Int) {
	self.root = addUtil(curr : self.root, value : value)
}

private func addUtil(curr : Node?, value : Int) -> Node {
	guard let curr = curr else {
		return Node(value)
	}
	if value < curr.value {
		curr.left = addUtil(curr : curr.left, value : value)
	} else {
		curr.right = addUtil(curr : curr.right, value : value)
	}
	return curr
}

public func printPreOrder() {
	printPreOrderUtil(curr : self.root)
	print()
}

private func printPreOrderUtil(curr : Node?) {
	guard let curr = curr else {
		return
	}
	print(curr.value, terminator: " ")
	printPreOrderUtil(curr : curr.left)
	printPreOrderUtil(curr : curr.right)
}

public func printPostOrder() {
	printPostOrderUtil(curr : self.root)
	print()
}

private func printPostOrderUtil(curr : Node?) {
	guard let curr = curr else {
		return
	}
	printPostOrderUtil(curr : curr.left)
	printPostOrderUtil(curr : curr.right)
	print(curr.value, terminator: " ")
}

public func printInOrder() {
	printInOrderUtil(curr : self.root)
	print()
}

func printInOrderUtil(curr : Node?) {
	guard let curr = curr else {
		return
	}
	printInOrderUtil(curr : curr.left)
	print(curr.value, terminator: " ")
	printInOrderUtil(curr : curr.right)
}

public func nthPreOrder(index : Int) {
	var counter : Int = 0
	nthPreOrderUtil(curr : self.root, index : index, counter : &counter)
}

private func nthPreOrderUtil(curr : Node?, index : Int, counter : inout Int) {
	guard let curr = curr else {
		return
	}
	counter += 1
	if counter == index {
		print(curr.value)
	}
	nthPreOrderUtil(curr : curr.left, index : index, counter : &counter)
	nthPreOrderUtil(curr : curr.right, index : index, counter : &counter)
}

public func nthPostOrder(index : Int) {
	var counter : Int = 0
	nthPostOrderUtil(curr : self.root, index : index, counter : &counter)
}

private func nthPostOrderUtil(curr : Node?, index : Int, counter : inout Int) {
	guard let curr = curr else {
		return
	}
	nthPostOrderUtil(curr : curr.left, index : index, counter : &counter)
	nthPostOrderUtil(curr : curr.right, index : index, counter : &counter)
	counter += 1
	if counter == index {
		print(curr.value)
	}
}

public func nthInOrder(index : Int) {
	var counter : Int = 0
	nthInOrderUtil(curr : self.root, index : index, counter : &counter)
}

private func nthInOrderUtil(curr : Node?, index : Int, counter : inout Int) {
	guard let curr = curr else {
		return
	}
	nthInOrderUtil(curr : curr.left, index : index, counter : &counter)
	counter += 1
	if counter == index {
		print(curr.value)
	}
	nthInOrderUtil(curr : curr.right, index : index, counter : &counter)
}

public func printBreadthFirst() {
	let que = Queue<Node>()
	if self.root != nil {
		que.add(self.root!)
	}

	while let temp = que.remove() {
		print(temp.value, terminator: " ")
		if temp.left != nil {
			que.add(temp.left!)
		}
		if temp.right != nil {
			que.add(temp.right!)
		}
	}
	print()
}

public func printDepthFirst() {
	let stk = Stack<Node>()
	if self.root != nil {
		stk.push(self.root!)
	}

	while let temp = stk.pop() {
		print (temp.value, terminator:" ")
		if temp.left != nil {
			stk.push(temp.left!)
		}
		if temp.right != nil {
			stk.push(temp.right!)
		}
	}
	print()
}


func printLevelOrderLineByLine() {
	let que1 = Queue<Node>()
	let que2 = Queue<Node>()
	if (self.root != nil) {
		que1.add(self.root!)
	}

	while (!que1.isEmpty() || !que2.isEmpty()) {
		while (!que1.isEmpty() ) {
			let temp = que1.remove()!
			print(String(temp.value) ,terminator: " ")
			if (temp.left != nil) {
				que2.add(temp.left!)
			}
			if (temp.right != nil) {
				que2.add(temp.right!)
			}
		}
		print()
		while (!que2.isEmpty() ) {
			let temp = que2.remove()!
			print(String(temp.value) ,terminator: " ")
			if (temp.left != nil) {
				que1.add(temp.left!)
			}
			if (temp.right != nil) {
				que1.add(temp.right!)
			}
		}
		print()
	}
}

func printLevelOrderLineByLine2() {
	let que = Queue<Node>()
	var temp : Node
	var count : Int = 0
	if (self.root != nil) {
		que.add(self.root!)
	}

	while (que.size() != 0) {
		count = que.size()
		while (count > 0) {
			temp = que.remove()!
			print(String(temp.value) ,terminator: " ")
			if (temp.left != nil) {
				que.add(temp.left!)
			}
			if (temp.right != nil) {
				que.add(temp.right!)
			}
			count -= 1
		}
		print()
	}
}

func printSpiralTree() {
	let stk1 = Stack<Node>()
	let stk2 = Stack<Node>()
	var temp : Node

	if (self.root != nil) {
		stk1.push(self.root!)
	}

	while (stk1.size() != 0 || stk2.size() != 0) {
		while (stk1.size() != 0) {
			temp = stk1.pop()!
			print(String(temp.value) ,terminator: " ")
			if (temp.right != nil) {
				stk2.push(temp.right!)
			}
			if (temp.left != nil) {
				stk2.push(temp.left!)
			}
		}

		while (stk2.size() != 0) {
			temp = stk2.pop()!
			print(String(temp.value) ,terminator: " ")
			if (temp.left != nil) {
				stk1.push(temp.left!)
			}
			if (temp.right != nil) {
				stk1.push(temp.right!)
			}
		}
	}
	print()
}

public func find(value : Int) -> Bool {
	var node : Node? = self.root
	while let curr = node {
		if curr.value == value {
			return true
		} else if curr.value > value {
			node = curr.left
		} else {
			node = curr.right
		}
	}
	return false
}


public func findMin() -> (value : Int, flag : Bool) {
	guard var curr = self.root else {
		print("EmptyTreeException")
		return (0, false)
	}

	while let next = curr.left {
		curr = next
	}
	return (curr.value, true)
}

public func findMax() -> (value : Int, flag : Bool) {
	guard var curr = self.root else {
		print("EmptyTreeException")
		return (0, false)
	}

	while let next = curr.right{
		curr = next
	}
	return (curr.value, true)
}

public func findMaxNode() -> Node? {
	guard var curr = self.root else {
		print("EmptyTreeException")
		return nil
	}

	while let next = curr.right{
		curr = next
	}
	return curr
}

public func findMinNode() -> Node? {
	guard var curr = self.root else {
		return nil
	}

	while let next = curr.left {
		curr = next
	}
	return curr
}

public func findMax(curr : Node?) -> Int {
	guard var curr = curr else {
		print("EmptyTreeException")
		return 0
	}
	while let next = curr.right {
		curr = next
	}
	return curr.value
}

public func findMin(curr : Node?) -> Int {
	guard var curr = curr else {
		print("EmptyTreeException")
		return 0
	}

	while let next = curr.left {
		curr = next
	}
	return curr.value
}

// appendValues appends the elements of curr to values in order
// and returns the resulting slice.
class func appendValues(values : inout [Int], curr : Node?) {
	guard let curr = curr else {
		return
	}
	appendValues(values : &values, curr : curr.left)
	values.append(curr.value)
	appendValues(values : &values, curr : curr.right)
}

public func free() {
	self.root = nil
}

public func deleteNode(value : Int) {
	self.root = deleteNode(curr : self.root, value : value)
}

private func deleteNode(curr : Node?, value : Int) -> Node? {
	guard let curr = curr else {
		return nil
	}

	if curr.value == value {
		if curr.left == nil && curr.right == nil {
			return nil
		}
		if curr.left == nil {
			return curr.right
		}
		if curr.right == nil {
			return curr.left
		}
		let maxValue = findMax(curr : curr.left)
		curr.value = maxValue
		curr.left = deleteNode(curr : curr.left, value : maxValue)
	} else {
		if curr.value > value {
			curr.left = deleteNode(curr : curr.left, value : value)
		} else {
			curr.right = deleteNode(curr : curr.right, value : value)
		}
	}
	return curr
}

public func treeDepth() -> Int {
	return treeDepth(curr : self.root)
}

private func treeDepth(curr : Node?) -> Int {
	guard let curr = curr else {
		return 0
	}
	let lDepth = treeDepth(curr : curr.left)
	let rDepth = treeDepth(curr : curr.right)

	if lDepth > rDepth {
		return lDepth + 1
	}
	return rDepth + 1
}

public func isEqual(t2 : BinaryTree) -> Bool {
	return isEqual(node1 : self.root, node2 : t2.root)
}

private func isEqual(node1 : Node?, node2 : Node?) -> Bool {
	if node1 == nil && node2 == nil {
		return true
	} 
	else if node1 == nil || node2 == nil {
		return false
	} else {
		return ((node1!.value == node2!.value) &&
			isEqual(node1 : node1!.left, node2 : node2!.left) &&
			isEqual(node1 : node1!.right, node2 : node2!.right))
	}
}

public func ancestor(first : Int, second : Int) -> Node? {
	if first < second {
		return ancestor(curr : self.root, first : first, second : second)
	} else {
		return ancestor(curr : self.root, first : first, second : second)
	}
}

private func ancestor(curr : Node?, first : Int, second : Int) -> Node? {
	guard let curr = curr else {
		return nil
	}
	if curr.value > first && curr.value > second {
		return ancestor(curr : curr.left, first : first, second : second)
	}
	if curr.value < first && curr.value < second {
		return ancestor(curr : curr.right, first : first, second : second)
	}
	return curr
}

public func copyTree() -> BinaryTree {
	let tree2 = BinaryTree()
	tree2.root = copyTree(curr : self.root)
	return tree2
}

private func copyTree(curr : Node?) -> Node? {
	guard let curr = curr else {
		return nil
	}

	let temp = Node(curr.value)
	temp.left = copyTree(curr : curr.left)
	temp.right = copyTree(curr : curr.right)
	return temp
}

public func copyMirrorTree() -> BinaryTree {
	let tree = BinaryTree()
	tree.root = copyMirrorTree(curr : self.root)
	return tree
}

private func copyMirrorTree(curr : Node?) -> Node? {
	guard let curr = curr else {
		return nil
	}

	let temp = Node(curr.value)
	temp.right = copyMirrorTree(curr : curr.left)
	temp.left = copyMirrorTree(curr : curr.right)
	return temp
}

public func numNodes() -> Int {
	return numNodes(curr : self.root)
}

private func numNodes(curr : Node?) -> Int {
	guard let curr = curr else {
		return 0
	}
	return (1 + numNodes(curr : curr.right) + numNodes(curr : curr.left))
}

public func numFullNodesBT() -> Int {
	return numFullNodesBT(curr : self.root)
}

private func numFullNodesBT(curr : Node?) -> Int {
	guard let curr = curr else {
		return 0
	}

	var count = numFullNodesBT(curr : curr.right) + numFullNodesBT(curr : curr.left)
	if curr.right != nil && curr.left != nil {
		count += 1
	}
	return count
}

public func maxLengthPathBT() -> Int {
	return maxLengthPathBT(curr : self.root)
}

private func maxLengthPathBT(curr : Node?) -> Int {
	guard let curr = curr else {
		return 0
	}

	let leftPath = treeDepth(curr : curr.left)
	let rightPath = treeDepth(curr : curr.right)
	var max = leftPath + rightPath + 1
	let leftMax = maxLengthPathBT(curr : curr.left)
	let rightMax = maxLengthPathBT(curr : curr.right)
	if leftMax > max {
		max = leftMax
	}

	if rightMax > max {
		max = rightMax
	}
	return max
}

public func numLeafNodes() -> Int {
	return numLeafNodes(curr : self.root)
}

private func numLeafNodes(curr : Node?) -> Int {
	guard let curr = curr else {
		return 0
	}

	if curr.left == nil && curr.right == nil {
		return 1
	}
	return (numLeafNodes(curr : curr.right) + numLeafNodes(curr : curr.left))
}

public func sumAllBT() -> Int {
	return sumAllBT(curr : self.root)
}

private func sumAllBT(curr : Node?) -> Int {
	guard let curr = curr else {
		return 0
	}
	return sumAllBT(curr : curr.right) + sumAllBT(curr : curr.left) + curr.value
}

public func isBST3() -> Bool {
	return isBST3(curr : self.root)
}

public func isBST3(curr : Node?) -> Bool {
	guard let curr = curr else {
		return true
	}
	if curr.left != nil && findMax(curr : curr.left) > curr.value {
		return false
	}
	if curr.right != nil && findMin(curr : curr.right) <= curr.value {
		return false
	}
	return (isBST3(curr : curr.left) && isBST3(curr : curr.right))
}

public func isBST() -> Bool {
	return isBST(curr : self.root, min : Int.min, max : Int.max)
}

private func isBST(curr : Node?, min : Int, max : Int) -> Bool {
	guard let curr = curr else {
		return true
	}

	if curr.value < min || curr.value > max {
		return false
	}
	return isBST(curr : curr.left, min : min, max : curr.value) && 
		   isBST(curr : curr.right, min : curr.value, max : max)
}

public func isBST2() -> Bool {
	var c : Int = Int.min
	return isBST2(curr : self.root, count : &c)
}

private func isBST2(curr : Node?, count : inout Int) -> Bool {
	guard let curr = curr else {
		return true
	}	
	var ret = isBST2(curr : curr.left, count : &count)
	if !ret {
		return false
	}
	if count > curr.value {
		return false
	}
	count = curr.value
	ret = isBST2(curr : curr.right, count : &count)
	if !ret {
		return false
	}
	return true
}

 func isCompleteTree() -> Bool {
	let que = Queue<Node>()
	var temp : Node
	var noChild : Int = 0
	if (self.root != nil) {
		que.add(self.root!)
	}

	while (que.size() != 0) {
		temp = que.remove()!
		if (temp.left != nil) {
			if (noChild == 1) {
				return false
			}
			que.add(temp.left!)
		} else {
			noChild = 1
		}

		if (temp.right != nil) {
			if (noChild == 1) {
				return false
			}
			que.add(temp.right!)
		} else {
			noChild = 1
		}
	}
	return true
}

func isCompleteTreeUtil(_ curr : Node?, _ index : Int, _ count : Int) -> Bool {
	guard let curr = curr else {
		return true
	}
	if (index > count) {
		return false
	}
	return self.isCompleteTreeUtil(curr.left, index * 2 + 1, count) && 
	       self.isCompleteTreeUtil(curr.right, index * 2 + 2, count)
}

func isCompleteTree2() -> Bool {
	let count : Int = self.numNodes()
	return self.isCompleteTreeUtil(self.root, 0, count)
}

func isHeapUtil(_ curr : Node?, _ parentValue : Int) -> Bool {
	guard let curr = curr else {
		return true
	}

	if (curr.value < parentValue) {
		return false
	}
	return (self.isHeapUtil(curr.left, curr.value) && 
	        self.isHeapUtil(curr.right, curr.value))
}

func isHeap() -> Bool {
	let infinite : Int = -9999999
	return (self.isCompleteTree() && self.isHeapUtil(self.root, infinite))
}

func isHeapUtil2(_ curr : Node?, _ index : Int, _ count : Int, _ parentValue : Int) -> Bool {
	guard let curr = curr else {
		return true
	}
	if (index > count) {
		return false
	}
	if (curr.value < parentValue) {
		return false
	}
	return self.isHeapUtil2(curr.left, index * 2 + 1, count,curr.value) && 
	       self.isHeapUtil2(curr.right, index * 2 + 2, count,curr.value)
}

func isHeap2() -> Bool {
	let count : Int = self.numNodes()
	let parentValue : Int = -9999999
	return self.isHeapUtil2(self.root,0,count,parentValue)
}

public func printAllPath() {
	var stk = Stack<Int>()
	printAllPath(curr : self.root, stk : &stk)
}

private func printAllPath(curr : Node?, stk : inout Stack<Int>) {
	guard let curr = curr else {
		return
	}
	stk.push(curr.value)
	if curr.left == nil && curr.right == nil {
		stk.display()
		_ = stk.pop()
		return
	}
	printAllPath(curr : curr.right, stk : &stk)
	printAllPath(curr : curr.left, stk : &stk)
	_ = stk.pop()
}


public func lca(first : Int, second : Int) -> (value : Int, flag : Bool) {
	let ans = lcaUtil(curr : self.root, first : first, second : second)
	if ans != nil {
		return (ans!.value, true)
	}
	print("NotFoundException")
	return (0, false)
}

private func lcaUtil(curr : Node?, first : Int, second : Int) -> Node? {
	guard let curr = curr else {
		return nil
	}

	if curr.value == first || curr.value == second {
		return curr
	}

	let left = lcaUtil(curr : curr.left, first : first, second : second)
	let right = lcaUtil(curr : curr.right, first : first, second : second)

	if left != nil && right != nil {
		return curr
	} else if left != nil {
		return left
	} else {
		return right
	}
}



func lcaBST(_ curr : Node?, _ first : Int, _ second : Int) -> (value : Int, flag : Bool) {
	guard let curr = curr else {
		print("NotFoundException")
		return (Int.max, false)
	}

	if (curr.value > second) {
		return self.lcaBST(curr.left, first, second)
	}

	if (curr.value < first) {
		return self.lcaBST(curr.right, first, second)
	}
	
	if (self.find(value : first) && self.find(value : second)) {
		return (curr.value, true)
	}

	return (Int.max, false)
}

func lcaBST(_ first : Int, _ second : Int) -> (value : Int, flag : Bool) {
	var result : (value: Int, flag : Bool)
	if (first > second) {
		result = self.lcaBST(self.root, second, first)
	} else {
		result = self.lcaBST(self.root, first, second)
	}

	if (result.flag == false) {
		print("lca does not exist")
	} else {
		print("lca is :" + String(result.value))
	}
	return result
}

public func trimOutsideRange(min : Int, max : Int) {
	self.root = trimOutsideRange(curr : self.root, min : min, max : max)
}

private func trimOutsideRange(curr : Node?, min : Int, max : Int) -> Node? {
	guard let curr = curr else {
		return nil
	}
	curr.left = trimOutsideRange(curr : curr.left, min : min, max : max)
	curr.right = trimOutsideRange(curr : curr.right, min : min, max : max)
	if curr.value < min {
		return curr.right
	}
	if curr.value > max {
		return curr.left
	}
	return curr
}

public func printInRange(min : Int, max : Int) {
	printInRange(curr : self.root, min : min, max : max)
	print()
}

private func printInRange(curr : Node?, min : Int, max : Int) {
	guard let curr = curr else {
		return
	}
	printInRange(curr : curr.left, min : min, max : max)
	if curr.value >= min && curr.value <= max {
		print(curr.value, terminator:" ")
	}
	printInRange(curr : curr.right, min : min, max : max)
}

public func floorBST(val : Int) -> Int {
	var curr = self.root
	var floor = Int.max
	while curr != nil {
		if curr!.value == val {
			floor = curr!.value
			break
		} else if curr!.value > val {
			curr = curr!.left
		} else {
			floor = curr!.value
			curr = curr!.right
		}
	}
	return floor
}

public func ceilBST(val : Int) -> Int {
	var curr = self.root
	var ceil = Int.min
	while curr != nil {
		if curr!.value == val {
			ceil = curr!.value
			break
		} else if curr!.value > val {
			ceil = curr!.value
			curr = curr!.left
		} else {
			curr = curr!.right
		}
	}
	return ceil
}

public func findMaxBT() -> Int {
	return findMaxBT(curr : self.root)
}

private func findMaxBT(curr : Node?) -> Int {
	guard let curr = curr else {
		return Int.min
	}
	let mx = curr.value
	let left = findMaxBT(curr : curr.left)
	let right = findMaxBT(curr : curr.right)
	return max(mx, max(left, right))
}

public func searchBT(value : Int) -> Bool {
	return searchBT(curr : self.root, value : value)
}

public func searchBT(curr : Node?, value : Int) -> Bool {
	guard let curr = curr else {
		return false
	}
	
	if (curr.value == value) ||
		searchBT(curr : curr.left, value : value) ||
		searchBT(curr : curr.right, value : value) {
		return true
	}
	return false
}

public func createBinarySearchTree(_ arr : [Int]) {
	let size = arr.count
	self.root = createBinarySearchTreeUtil(arr : arr, start : 0, end : size-1)
}

public func createBinarySearchTreeUtil(arr : [Int], start : Int, end : Int) -> Node? {
	if start > end {
		return nil
	}

	let mid = (start + end) / 2
	let curr = Node(arr[mid])
	curr.left = createBinarySearchTreeUtil(arr : arr, start : start, end : mid-1)
	curr.right = createBinarySearchTreeUtil(arr : arr, start : mid+1, end : end)
	return curr
}
}

func main1() {
let t = BinaryTree()
let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
t.createCompleteBinaryTree(arr:arr)
	t.printPreOrder()
	// 1 2 4 8 9 5 10 3 6 7 

	t.printPostOrder()
	// 8 9 4 10 5 2 6 7 3 1 

t.printInOrder()
// 8 4 9 2 10 5 1 6 3 7 

t.printBreadthFirst()
	// 1 2 3 4 5 6 7 8 9 10 

t.printDepthFirst()
	// 1 3 7 6 2 5 10 4 9 8

t.printLevelOrderLineByLine()
	/*
	1 
	2 3 
	4 5 6 7 
	8 9 10 
	*/

	t.printLevelOrderLineByLine2()
	/*
	1 
	2 3 
	4 5 6 7 
	8 9 10 
	*/

t.printSpiralTree()
	// 1 2 3 7 6 5 4 8 9 10 

t.nthInOrder(index :2)
t.nthPostOrder(index :2)
t.nthPreOrder(index :2)

	/*
	4
	9
	2
	*/

t.printAllPath()

	/*
[1, 3, 7]
[1, 3, 6]
[1, 2, 5, 10]
[1, 2, 4, 9]
[1, 2, 4, 8]
	*/
}

func main2() {
let t = BinaryTree()
let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
t.createCompleteBinaryTree(arr:arr)

print(t.numNodes())
	// 10

print(t.sumAllBT())
	// 55

print(t.numLeafNodes())
	// 5

print(t.numFullNodesBT())
	// 4

print(t.searchBT(value:9))
	// true

print(t.findMaxBT())
	// 10

print(t.treeDepth())
	// 4

print(t.maxLengthPathBT())
	// 6
}

func main3() {
	let t = BinaryTree()
	let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
	t.createCompleteBinaryTree(arr:arr)

let t2 = t.copyTree()
	t2.printInOrder()
	/*
8 4 9 2 10 5 1 6 3 7 
	*/
let t3 = t.copyMirrorTree()
t3.printInOrder()
	/*
7 3 6 1 5 10 2 9 4 8
	*/
print(t.isEqual(t2:t2))
	/*
	true
	*/
print(t.isHeap())
	print(t.isHeap2())
print(t.isCompleteTree())
	print(t.isCompleteTree2())
	/*
	true
	true
	true
	true
	*/
}

func main4() {
let t = BinaryTree()
t.add(value:6)
t.add(value:4)
t.add(value:2)
t.add(value:5)
t.add(value:1)
t.add(value:3)
t.add(value:8)
t.add(value:7)
t.add(value:9)
t.add(value:10)
t.printInOrder()

	/*
	1 2 3 4 5 6 7 8 9 10 
	*/
print(t.find(value:3))
print(t.find(value:16))
	/*
	true
	false
	*/
	print(t.isBST())
	print(t.isBST2())
print(t.isBST3())
	/*
	true
	true
	true
	*/
}

func main5() {
let t = BinaryTree()
let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
t.createBinarySearchTree(arr)
print(t.findMin())
print(t.findMax())
print(t.lcaBST(3, 4))
print(t.lcaBST(1, 4))
print(t.lcaBST(10, 4))
}

/*
1
10
lca is :3
lca is :2
lca is :5
*/

func main6() {
	let t = BinaryTree()
	let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
	t.createBinarySearchTree(arr)
t.printInOrder()
t.printInRange(min:4, max:7)
t.trimOutsideRange(min:4, max:7)
t.printInOrder()
}

/*
1 2 3 4 5 6 7 8 9 10 
4 5 6 7 
4 5 6 7 
*/

func main7() {
	let t = BinaryTree()
let arr = [1, 2, 3, 4, 6, 7, 8, 9, 10]
	t.createBinarySearchTree(arr)
	t.printInOrder()
	t.deleteNode(value : 6)
	t.printInOrder()
	
	print(t.ancestor(first:1, second:10)!.value)
	// 6

	print(t.ceilBST(val:5))
	// 6

print(t.floorBST(val:5))
	// 4

}

func main8() {
	let t = BinaryTree()
	t.add(value:2)
	t.add(value:1)
	t.add(value:3)
	t.add(value:4)

	print("Before delete operation.")
	t.printInOrder()
t.deleteNode(value:2)
	print("After delete operation.")
	t.printInOrder()
}
/*
Before delete operation.
1 2 3 4 
After delete operation.
1 3 4 
*/

main1()
main2()
main3()
main4()
main5()
main6()
main7()
main8()