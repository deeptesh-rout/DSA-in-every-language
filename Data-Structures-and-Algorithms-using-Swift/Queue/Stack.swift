
class Stack {
	private var que1 : [Int] = [Int]()
    private var que2 : [Int] = [Int]()
	var size : Int = 0

	public init() {}

	func push(_ value : Int) {
		que1.append(value)
		size += 1
	}

	func pop() -> Int {
		var value : Int = 0
		var s : Int = size
		while (s > 0) {
			value = que1.first!
			que1.removeFirst()
			if (s > 1) {
				que2.append(value)
			}
			s -= 1
		}
		let temp = que1
		que1 = que2
		que2 = temp
		size -= 1
		return value
	}

	func push2(_ value : Int) {
		que1.append(value)
		size += 1
	}

	func pop2() -> Int{
		var value = 0
		var s = size
		while (s > 0) {
			value = que1.first!
			que1.removeFirst()
			if (s > 1) {
				que1.append(value)
			}
			s -= 1
		}
		size -= 1
		return value
	}
}

// Testing code.
let stk : Stack = Stack()
stk.push(1)
stk.push(2)
stk.push(3)
print("Stack pop : ", stk.pop())
print("Stack pop : ", stk.pop())

/*
Stack pop : 3
Stack pop : 2
*/