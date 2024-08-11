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

// Testing code
var s = Stack<Int>()
s.push(1)
s.push(2)
s.push(3)
s.display()
print(s.pop()!)
print(s.pop()!)


// [1, 2, 3]
// 3
// 2