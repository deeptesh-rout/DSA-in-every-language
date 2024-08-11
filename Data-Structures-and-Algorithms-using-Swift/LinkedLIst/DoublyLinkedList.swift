class DoublyLinkedList {
	private var head : Node? = nil
    private var tail : Node? = nil
    private var size : Int = 0
	
	class Node {
		var value : Int
		var next : Node?
		var prev : Node?

		init(_ val : Int, _ nxt : Node? = nil, _ prv : Node? = nil) {
			self.value = val
			self.next = nxt
			self.prev = prv
		}
	}

	public func length() -> Int {
		return self.size
	}
	
	public func isEmpty() -> Bool {
		return self.size == 0
	}
	
	public func peek() -> Int {
		if self.isEmpty() {
			print("Empty List Error")
		}
		return self.head!.value
	}
	/* Other methods */


	public func addHead(_ value : Int) {
		let newNode = Node(value, nil, nil)
		if self.size == 0 {
			self.tail = newNode
			self.head = newNode
		} else {
			self.head!.prev = newNode
			newNode.next = self.head
			self.head = newNode
		}
		self.size+=1 
	}

	public func addTail(_ value : Int) {
		let newNode = Node(value, nil, nil)
		if self.size == 0 {
			self.head = newNode
			self.tail = newNode
		} else {
			newNode.prev = self.tail
			self.tail!.next = newNode
			self.tail = newNode
		}
		self.size+=1 
	}

	public func removeHead() -> (value : Int, flag : Bool) {
		if self.isEmpty() {
			print("Empty List Error")
			return (0, false)
		}

		let value = self.head!.value
		self.head = self.head!.next

		if self.head == nil {
			self.tail = nil
		} else {
			self.head!.prev = nil
		}
		self.size-=1 
		return (value, true)
	}

	public func removeNode(_ key : Int) -> Bool {
		var curr = self.head
		if curr == nil { // empty list
			return false
		}
		if curr!.value == key { // head is the node with value key.
			curr = curr!.next
			self.size-=1 
			if curr != nil {
				self.head = curr
				self.head!.prev = nil
			} else {
				self.tail = nil // only one element in self.
			}
			return true
		}
		while curr!.next != nil {
			if curr!.next!.value == key {
				curr!.next = curr!.next!.next
				if curr!.next == nil { // last element case.
					self.tail = curr
				} else {
					curr!.next!.prev = curr
				}
				self.size-=1 
				return true
			}
			curr = curr!.next
		}
		return false
	}

	public func isPresent(_ key : Int) -> Bool {
		var temp = self.head
		while temp != nil {
			if temp!.value == key {
				return true
			}
			temp = temp!.next
		}
		return false
	}

	public func freeList() {
		self.tail = nil
		self.head = nil
		self.size = 0
	}

	public func display() {
		var temp = self.head
		while temp != nil {
			print(temp!.value, terminator:" ")
			temp = temp!.next
		}
		print()
	}

	public func reverseList() {
		var curr = self.head
		var tempNode: Node?
		while curr != nil {
			tempNode = curr!.next
			curr!.next = curr!.prev
			curr!.prev = tempNode
			if curr!.prev == nil {
				self.tail = self.head
				self.head = curr
				return
			}
			curr = curr!.prev
		}
		return
	}

	public func copyListReversed() -> DoublyLinkedList {
		let dll : DoublyLinkedList = DoublyLinkedList()
		var curr = self.head
		while curr != nil {
			dll.addHead(curr!.value)
			curr = curr!.next
		}
		return dll
	}

	public func copyList() -> DoublyLinkedList {
		let dll : DoublyLinkedList = DoublyLinkedList()
		var curr = self.head
		while curr != nil {
			dll.addTail(curr!.value)
			curr = curr!.next
		}
		return dll
	}

	public func sortedInsert(_ value : Int) {
		let newNode = Node(value, nil, nil)
		var curr = self.head

		if curr == nil { // first element
			self.head = newNode
			self.tail = newNode
			return
		}

		if self.head!.value > value { // at the begining
			newNode.next = self.head
			self.head!.prev = newNode
			self.head = newNode
			return
		}

		while curr!.next != nil && curr!.next!.value < value { // treversal
			curr = curr!.next
		}

		if curr!.next == nil { // at the end
			self.tail = newNode
			newNode.prev = curr
			curr!.next = newNode
		} else { // all other
			newNode.next = curr!.next
			newNode.prev = curr
			curr!.next = newNode
			newNode.next!.prev = newNode
		}
	}

	func removeDuplicate() {
		var curr : Node? = self.head
		while (curr != nil)
		{
			if ((curr!.next != nil) && curr!.value == curr!.next!.value)
			{
				curr!.next = curr!.next!.next
				if (curr!.next != nil)
				{
					curr!.next!.prev = curr
				}
				else
				{
					self.tail = curr
				}
			}
			else
			{
				curr = curr!.next
			}
		}
	}
}

// Testing code.
func main1() {
	let ll : DoublyLinkedList = DoublyLinkedList()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(3)
	ll.display()
	print("length : " + String(ll.length()))
	print("isEmpty : " + String(ll.isEmpty()))
	_ = ll.removeHead()
	ll.display()
}
// 3 2 1 
// length : 3
// isEmpty : false
// 2 1 
// true

// Testing code.
func main2() {
	let ll : DoublyLinkedList = DoublyLinkedList()
	ll.sortedInsert(1)
	ll.sortedInsert(2)
	ll.sortedInsert(3)
	ll.display()
	ll.sortedInsert(1)
	ll.sortedInsert(2)
	ll.sortedInsert(3)
	ll.display()
	ll.removeDuplicate()
	ll.display()
}
// 	1 2 3 
// 	1 1 2 2 3 3 
// 	1 2 3

// Testing code.
func main3() {
	let ll : DoublyLinkedList = DoublyLinkedList()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(3)
	ll.display()
	let l2 : DoublyLinkedList = ll.copyList()
	l2.display()
	let l3 : DoublyLinkedList = ll.copyListReversed()
	l3.display()
}
// 	3 2 1 
// 	3 2 1 
// 	1 2 3

// Testing code.
func main4() {
	let ll : DoublyLinkedList = DoublyLinkedList()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(3)
	ll.display()
	_ = ll.removeNode(2)
	ll.display()
}
// 	3 2 1 
// 	3 1

// Testing code.
func main5() {
	let ll : DoublyLinkedList = DoublyLinkedList()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(3)
	ll.display()
	ll.reverseList()
	ll.display()
}
// 	3 2 1
// 	1 2 3

main1()
main2()
main3()
main4()
main5()
