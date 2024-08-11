class Queue<T> {

	var tail : Node? = nil
	var count : Int = 0

	class Node {
		var value : T
		var next : Node?

		public init(_ val : T, _ nxt : Node? = nil) {
			self.value = val
			self.next = nxt
		}
	}

	public init() {
		self.tail = nil
		self.count = 0
	}

	public func size() -> Int {
		return self.count
	}
	
	public func isEmpty() -> Bool {
		return self.count == 0
	}
	
	public func front() -> T? {
		if self.isEmpty() {
			print("QueueEmptyException")
			return nil
		}
		return self.tail!.next!.value
	}

		public func display() {
		if self.isEmpty() {
			print("Queue is empty.")
			return
		}
		var temp : Node? = self.tail!.next
        print("Queue is : ",terminator: "")
        var i : Int = 0
        while (i < self.count) {
            print(temp!.value, terminator: " ")
            temp = temp!.next
            i += 1
        }
        print()
	}
	/* Other Methods */
	
	public func add(_ value : T) {
		let temp = Node(value)
		if self.tail == nil {
			self.tail = temp
			temp.next = temp
		} else {
			temp.next = self.tail!.next
			self.tail!.next = temp
			self.tail = temp
		}
		self.count += 1
	}
	
	public func remove() -> T? {
		if self.isEmpty() {
			print("QueueEmptyException")
			return nil
		}

		var value : T
        if (self.tail === self.tail!.next) {
            value = self.tail!.value
            self.tail = nil
        } else {
            value = self.tail!.next!.value
            self.tail!.next = self.tail!.next!.next
        }
		self.count -= 1
		return value
	}
}

// Testing code.
let que : Queue<Int> = Queue<Int>()
que.add(1)
que.add(2)
que.add(3)
que.display()
print("IsEmpty :", que.isEmpty())
print("Size :", que.size())
print("Queue remove :", que.remove()!)
print("Queue remove :", que.remove()!)

/*
Queue : 1 2 3 
IsEmpty : false
Size : 3
Queue remove : 1
Queue remove : 2
*/