class TST {
	class Node  {
		var data : Character = "a"
		var isLastChar : Bool = false
		var left : Node? = nil
		var equal : Node? = nil
		var right : Node? = nil
	}	
	
	var root : Node? = nil

	func insert(_ word : String) {
		let str : [Character] = Array(word.lowercased())
		self.root = self.insertUtil(node : self.root, word : str, wordIndex : 0)
	}
	
	func insertUtil(node : Node?, word : [Character], wordIndex : Int) -> Node {
		var curr : Node
		if node == nil {
			curr = Node()
			curr.data = word[wordIndex]
		} else {
			curr = node!
		}
		if word[wordIndex] < curr.data {
			curr.left = self.insertUtil(node : curr.left, word : word, wordIndex : wordIndex)
		} else if word[wordIndex] > curr.data {
			curr.right = self.insertUtil(node : curr.right, word : word, wordIndex : wordIndex)
		} else {
			if wordIndex < word.count-1 {
				curr.equal = self.insertUtil(node : curr.equal, word : word, wordIndex : wordIndex+1)
			} else {
				curr.isLastChar = true
			}
		}
		return curr
	}
	
	func find(_ word : String) -> Bool {
		let str : [Character] = Array(word.lowercased())
		return self.findUtil(curr : self.root, word : str, wordIndex : 0)
	}

	func findUtil(curr : Node?, word : [Character], wordIndex : Int) -> Bool {
		guard let curr = curr else {
			return false
		}
	
		if word[wordIndex] < curr.data {
			return self.findUtil(curr : curr.left, word : word, wordIndex : wordIndex)
		} else if word[wordIndex] > curr.data {
			return self.findUtil(curr : curr.right, word : word, wordIndex : wordIndex)
		} else {
			if wordIndex == word.count-1 {
				return curr.isLastChar
			}
			return self.findUtil(curr : curr.equal, word : word, wordIndex : wordIndex+1)
		}
	}
}

// Testing code.
let tt = TST()
tt.insert("banana")
tt.insert("apple")
tt.insert("mango")
print("Apple Found :", tt.find("apple"))
print("Banana Found :", tt.find("banana"))
print("Grapes Found :", tt.find("grapes"))
