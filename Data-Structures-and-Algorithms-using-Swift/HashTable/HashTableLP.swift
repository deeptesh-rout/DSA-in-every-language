
class HashTable {
	var Keys : [Int]
	var Values : [Int]
	var Flags : [NodeState]
	var tableSize : Int

	enum NodeState {
		case EmptyNode
		case LazyDeleted
		case FilledNode
	}

	public init(tSize : Int) {
		self.tableSize = tSize
		self.Keys = Array(repeating:0, count:(tSize + 1))
		self.Values = Array(repeating:0, count:(tSize + 1))
		self.Flags = Array(repeating:NodeState.EmptyNode, count:(tSize + 1))
	}

	/* Other Methods */ 

	func computeHash(key : Int) -> Int {
		return key % self.tableSize
	}
		
	func resolverFun(index : Int) -> Int {
		return index
	}
		
	func add(_ key : Int, _ value : Int) -> Bool {
		var hashValue = self.computeHash(key : key)
		var i = 0
		while i < self.tableSize {
			if self.Flags[hashValue] == NodeState.EmptyNode || self.Flags[hashValue] == NodeState.LazyDeleted {
				self.Keys[hashValue] = key
				self.Values[hashValue] = value
				self.Flags[hashValue] = NodeState.FilledNode
				return true
			}
			hashValue  +=  self.resolverFun(index:i)
			hashValue %= self.tableSize
			i += 1
		}
		return false
	}
	
	func add(_ value : Int) -> Bool {
		return add(value, value)
	}
		
	func find(_ key : Int) -> Bool {
		var hashValue = self.computeHash(key : key)
	
		var i = 0
		while  i < self.tableSize {
			if self.Flags[hashValue] == NodeState.EmptyNode {
				return false
			}
			if self.Flags[hashValue] == NodeState.FilledNode && self.Keys[hashValue] == key {
				return true
			}
			hashValue  +=  self.resolverFun(index:i)
			hashValue %= self.tableSize
			i += 1
		}
		return false
	}
	
	func get(_ key : Int) -> Int {
		var hashValue = self.computeHash(key : key)
		var i = 0
		while  i < self.tableSize {
			if self.Flags[hashValue] == NodeState.EmptyNode {
				return -1
			}
			if self.Flags[hashValue] == NodeState.FilledNode && self.Keys[hashValue] == key {
				return Values[hashValue]
			}
			hashValue  +=  self.resolverFun(index:i)
			hashValue %= self.tableSize
			i += 1
		}
		return -1
	}
		
	func remove(_ key : Int) -> Bool {
		var hashValue = self.computeHash(key : key)
		var i = 0
		while i < self.tableSize {
			if self.Flags[hashValue] == NodeState.EmptyNode {
				return false
			}
			if self.Flags[hashValue] == NodeState.FilledNode && self.Keys[hashValue] == key {
				self.Flags[hashValue] = NodeState.LazyDeleted
				return true
			}
			hashValue  +=  self.resolverFun(index:i)
			hashValue %= self.tableSize
			i += 1
		}
		return false
	}
		
	func display() {
		print("Hash Table contains : ", terminator: "")
		var i = 0
		while i < self.tableSize {
			if self.Flags[i] == NodeState.FilledNode {
				print("(", self.Keys[i], "=>", self.Values[i], terminator: ") ")
			}
			i += 1
		}
		print()
	}
}

// Testing code
var ht = HashTable(tSize:1000)
_ = ht.add(1, 10)
_ = ht.add(2, 20)
_ = ht.add(3, 30)
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
