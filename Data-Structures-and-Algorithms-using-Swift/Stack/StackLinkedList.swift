

class Stack<T> {

	var head : Node?
	var count : Int

	class Node {
		var value : T
		var next : Node?

		public init(_ val : T, _ nxt : Node? = nil) {
			self.value = val
			self.next = nxt
		}
	}

	public init() {
		self.head = nil
		self.count = 0
	}

	public func size() -> Int {
		return self.count
	}
	
	public func isEmpty() -> Bool {
		return self.count == 0
	}
	
	public func top() -> T? {
		if self.isEmpty() {
			print("Stack Empty Error")
			return nil
		}
		return self.head!.value
	}
	
	public func push(_ value : T) {
		self.head = Node(value, self.head)
		self.count += 1
	}
	
	public func pop() -> T? {
		if self.isEmpty() {
			print("Stack Empty Error")
			return nil
		}
	
		let value = self.head!.value
		self.head = self.head!.next
		self.count -= 1
		return value
	}
	
	public func display() {
		var temp = self.head
		print("Stack :: ", terminator:"")
		while temp != nil {
			print(temp!.value, terminator:" ")
			temp = temp!.next
		}
		print()
	}
}

// Testing code
var s = Stack<Int>()
s.push(1)
s.push(2)
s.push(3)
s.display()
print(s.pop()!)
print(s.pop()!)

// Stack :: 3 2 1 
// 3
// 2
