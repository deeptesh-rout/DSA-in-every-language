import Foundation

class DoublyCircularLinkedList {
    private var head : Node? = nil
    private var tail : Node? = nil
    private var size : Int = 0

    class Node {
        var value : Int
        var next : Node?
        var prev : Node?

        init(_ v : Int, _ nxt : Node? = nil, _ prv : Node? = nil) {
            self.value = v
            self.next = nxt
            self.prev = prv
        }
    }
    
	func length() -> Int {
        return self.size
    }
	
    
	func isEmpty() -> Bool {
        return self.size == 0
    }

    
	func peekHead() -> Int {
        if (self.isEmpty()) {
			print("Empty List Error")
        }
        return self.head!.value
    }
	// Other methods
    
	func addHead(_ value : Int) {
		let newNode : Node? = Node(value, nil, nil)
		if (self.size == 0) {
			self.tail = newNode
			self.head = newNode
			newNode!.next = newNode
			newNode!.prev = newNode
		} else {
			newNode!.next = self.head
			newNode!.prev = self.head!.prev
			self.head!.prev = newNode
			newNode!.prev!.next = newNode
			self.head = newNode
		}
		self.size += 1
	}

	func addTail(_ value : Int) {
		let newNode : Node? = Node(value, nil, nil)
		if (self.size == 0) {
			self.head = newNode
			self.tail = newNode
			newNode!.next = newNode
			newNode!.prev = newNode
		} else {
			newNode!.next = self.tail!.next
			newNode!.prev = self.tail
			self.tail!.next = newNode
			newNode!.next!.prev = newNode
			self.tail = newNode
		}
		self.size += 1
	}

	func removeHead() -> Int {
		if (self.size == 0) {
			print("Empty List Error")
			return 0
		}
		let value : Int = self.head!.value
		self.size -= 1
		if (self.size == 0) {
			self.head = nil
			self.tail = nil
			return value
		}
		let next : Node? = self.head!.next
		next!.prev = self.tail
		self.tail!.next = next
		self.head = next
		return value
	}

	func removeTail() -> Int {
		if (self.size == 0) {
			print("Empty List Error")
			return 0
		}

		let value : Int = self.tail!.value
		self.size -= 1
		if (self.size == 0) {
			self.head = nil
			self.tail = nil
			return value
		}
		let prev : Node? = self.tail!.prev
		prev!.next = self.head
		self.head!.prev = prev
		self.tail = prev
		return value
	}

	func search(_ data : Int) -> Bool {
		var temp : Node? = self.tail
		var i : Int = 0
		while (i < self.size) {
			if (temp!.value == data) {
				return true
			}
			temp = temp!.next
			i += 1
		}
		return false
	}


	func deleteList() {
		self.head = nil
		self.tail = nil
		self.size = 0
	}

	func display() {
		if (self.isEmpty()) {
			print("Empty List.")
			return
		}
		var temp : Node? = self.head
		while (!(temp===self.tail)) {
			print(String(temp!.value) + " ",terminator: "")
			temp = temp!.next
		}
		print(temp!.value)
	}
}

// Testing code.
func main1() {
	let ll : DoublyCircularLinkedList = DoublyCircularLinkedList()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(3)
	ll.display()
	print(ll.length())
	print(ll.isEmpty())
	print(ll.peekHead())
	print(ll.search(3))
}
// 3 2 1
// 3
// false
// 3
// true

// Testing code.
func main2() {
	let ll : DoublyCircularLinkedList = DoublyCircularLinkedList()
	ll.addTail(1)
	ll.addTail(2)
	ll.addTail(3)
	ll.display()
	_ = ll.removeHead()
	ll.display()
	_ = ll.removeTail()
	ll.display()
	ll.deleteList()
	ll.display()
}
// 1 2 3
// 2 3
// 2
// Empty List.

// Testing code.
func main3() {
	let ll : DoublyCircularLinkedList = DoublyCircularLinkedList()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(3)
	ll.display()
	_ = ll.removeHead()
	ll.display()
}
// 3 2 1
// 2 1

// Testing code.
func main4() {
	let ll : DoublyCircularLinkedList = DoublyCircularLinkedList()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(3)
	ll.display()
	_ = ll.removeTail()
	ll.display()
}
// 3 2 1
// 3 2

main1()
main2()
main3()
main4()
