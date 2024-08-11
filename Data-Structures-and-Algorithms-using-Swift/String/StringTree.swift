class StringTree {
	class Node {
		var value : String
		var count : Int
		var lChild : Node?
		var rChild : Node?

		init(_ value : String){
			self.value = value
			self.count = 0
			self.lChild = nil
			self.rChild = nil
		}

		init(){
			self.value = ""
			self.count = 0
			self.lChild = nil
			self.rChild = nil
		}
	}

	var root : Node?

	public func display() {
		self.displayUtil(curr : self.root)
	}
	
	private func displayUtil(curr : Node?) {
		guard let curr = curr else {
			return
		}
		print(" value is :: \(curr.value)")
		print(" count is :: \(curr.count)")
		self.displayUtil(curr : curr.lChild)
		self.displayUtil(curr : curr.rChild)
	}
	
	public func insert(_ value : String) {
		self.root = self.insertUtil(value : value, curr : self.root)
	}
	
	private func insertUtil(value : String, curr : Node?) -> Node {
		guard let curr = curr else {
			let temp = Node(value)
			return temp
		} 
		if curr.value == value {
			curr.count+=1
		} else if curr.value > value {
			curr.lChild = self.insertUtil(value : value, curr : curr.lChild)
		} else {
			curr.rChild = self.insertUtil(value : value, curr : curr.rChild)
		}
		return curr
	}
	
	public  func freeTree() {
		self.root = nil
	}
	
	public func find(_ value : String) -> Bool {
		let ret = self.findUtil(curr : self.root, value : value)
		return ret
	}
	
	private func findUtil(curr : Node?, value : String) -> Bool {
		guard let curr = curr else {
			return false
		}

		if curr.value == value {
			return true
		}
	
		if curr.value > value {
			return self.findUtil(curr : curr.lChild, value : value)
		}
		return self.findUtil(curr : curr.rChild, value : value)
	}
	
	public func frequency(_ value : String) -> Int {
		return self.frequencyUtil(curr : self.root, value : value)
	}
	
	private func frequencyUtil(curr : Node?, value : String) -> Int {
		guard let curr = curr else {
			return 0
		}
		if curr.value == value {
			return curr.count
		}
		if curr.value > value {
			return self.frequencyUtil(curr : curr.lChild, value : value)
		}
		return self.frequencyUtil(curr : curr.rChild, value : value)
	}

}

// Testing code.
var tt = StringTree()
tt.insert("banana")
tt.insert("apple")
tt.insert("mango")
print("Apple Found :", tt.find("apple"))
print("Banana Found :", tt.find("banana"))
print("Grapes Found :", tt.find("grapes"))
