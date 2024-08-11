class Stack<T> {
	var stk = [T]()
	
	public init() {}

	public var isEmpty : Bool {
		return stk.isEmpty
	}
	
	public var count : Int {
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
}

class QueueUsingStack {
	var stk1 = Stack<Int>()
	var stk2 = Stack<Int>()

	public init() {}

	public func add(_ value : Int) {
		stk1.push(value)
	}

	public func remove() -> Int {
		if stk1.isEmpty == true && stk2.isEmpty == true {
			return 0
		}

		if stk2.isEmpty == true {
			while stk1.isEmpty == false {
				stk2.push(stk1.pop()!)
			}
		}
		return stk2.pop()!
	}
}

// Testing code
var que = QueueUsingStack()
que.add(1)
que.add(11)
que.add(111)
print(que.remove())
print(que.remove())
print(que.remove())
