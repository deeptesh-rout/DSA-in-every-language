class HashTableSC{
	class Node{
		var key : Int
		var value : Int
		var next : Node?

		init(_ key : Int, _ value : Int, _ next : Node?) {
			self.key = key
			self.value = value
			self.next = next
		}
	}

	var listArray : [Node?]
	var tableSize : Int
	
	public init( _ size : Int = 101) {
		self.tableSize = size
		self.listArray = Array(repeating: nil, count: self.tableSize)
	}
	
	// This is most simple hash function more complex hash function can be used.
	func computeHash(_ key : Int) -> Int {
		return key % self.tableSize
	}
	
	func add(_ key : Int, _ value : Int) {
		let index = self.computeHash(key)
		self.listArray[index] = Node(key, value, self.listArray[index])
	}

	func add(_ value : Int) {
		add(value, value)
	}

	func find(_ key : Int) -> Bool {
		let index = self.computeHash(key)
		var head = self.listArray[index]
		while head != nil {
			if head!.key == key {
				return true
			}
			head = head!.next
		}
		return false
	}

	func get(_ key : Int) -> Int {
		let index = self.computeHash(key)
		var head = self.listArray[index]
		while head != nil {
			if head!.key == key {
				return head!.value
			}
			head = head!.next
		}
		return -1
	}
	
	func remove(_ key : Int) -> Bool {
		let index = self.computeHash(key)
		var nextNode : Node? 
		var head : Node? = self.listArray[index]
		if head != nil && head!.key == key {
			self.listArray[index] = head!.next
			return true
		}
		while head != nil {
			nextNode = head!.next
			if nextNode != nil && nextNode!.key == key {
				head!.next = nextNode!.next
				return true
			}
			head = nextNode
		}
		return false
	}
	
	func display() {
		print("Hash Table contains : ", terminator: "")
		var i = 0
		while i < self.tableSize {
			var head = self.listArray[i]
			while head != nil {
				print("(", head!.key, "=>", head!.value, terminator: ") ")
				head = head!.next
			}
			i += 1
		}
		print()
	}
}

// Testing code
var ht = HashTableSC()
ht.add(1, 10)
ht.add(2, 20)
ht.add(3, 30)
ht.display()
print("Find key 2 : \(ht.find(2))")
print("Value at key 2 : \(ht.get(2))")
_ = ht.remove(2)
print("Find key 2 : \(ht.find(2))")

/*
Hash Table contains : ( 1 => 10) ( 2 => 20) ( 3 => 30) 
Find key 2 : true
Value at key 2 : 20
Find key 2 : false
*/