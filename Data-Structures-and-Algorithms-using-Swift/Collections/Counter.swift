class Counter<T: Hashable > {
	private var dict: [T:Int] = [:]

	public var isEmpty : Bool {
		return dict.count == 0
	}

	public func add(_ key : T) {
		guard let val = dict[key] else {
			dict[key] = 1
			return
		}
		dict[key] = val + 1
	}
	
	public func find(_ key : T) -> Bool {
		let keyExists = dict[key] != nil
		return keyExists
	}
	
	public func get(_ key : T) -> Int {
		guard let val = dict[key] else {
			return 0
		}
		return val
	}
	
	public func remove(_ key : T) {
		guard let val = dict[key] else {
			return
		}
		if(val == 1) {
			dict[key] = nil
		} else {
			dict[key] = val - 1
		}
	}
}

// Testing Code.
let mp = Counter<String>()
mp.add("a")
mp.add("b")
mp.add("a")

print("Find :", mp.find("a"))
print("Find :", mp.find("b"))
print("Find :", mp.find("c"))

print("Get :", mp.get("a"))
print("Get :", mp.get("b"))
print("Get :", mp.get("c"))

mp.remove("b")
print("Find :", mp.find("b"))
print("Get :", mp.get("b"))

/*
Find : true
Find : true
Find : false
Get : 2
Get : 1
Get : 0
Find : false
Get : 0
*/
