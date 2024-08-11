class Queue<T> {
	private var que = [T]()

	public init() {}

	public func isEmpty() -> Bool {
		return que.count == 0
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


// Testing code
var que  = Queue<Int>()
que.add(1)
que.add(2)
que.add(3)
que.display()
print("IsEmpty :", que.isEmpty())
print("Size :", que.size())
print("Queue remove :" ,que.remove()!)
print("Queue remove :" ,que.remove()!)

/*
Queue : [1, 2, 3]
IsEmpty : false
Size : 3
Queue remove : 1
Queue remove : 2
*/