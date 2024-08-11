class List {
	private var head : Node? = nil
    private var size : Int = 0

	class Node {
		var value : Int
		var next : Node?

		init(_ val : Int, _ nxt : Node? = nil) {
			self.value = val
			self.next = nxt
		}
	}

	public func length() -> Int {
		return self.size
	}

	public func isEmpty() -> Bool {
		return (self.size == 0)
	}

	public func peek() -> (value : Int, flag : Bool) {
		guard let head = self.head else {
			print("Empty List Error")
			return (0, false)
		}
		return (head.value, true)
	}
	// Other Methods.

	public func addHead(_ value : Int) {
		self.head = Node(value, self.head)
		self.size += 1
	}

	public func addTail(_ value : Int) {
		var curr = self.head
		let newNode = Node(value, nil)
		if curr == nil {
			self.head = newNode
			return
		}
		while curr!.next != nil {
			curr = curr!.next
		}
		curr!.next = newNode
	}

	public func display() {
		var curr = self.head
		while curr != nil {
			print(curr!.value, terminator: " ")
			curr = curr!.next
		}
		print("")
	}

	public func sum() -> Int {
		var temp = self.head
		var sum = 0
		while temp != nil {
			sum += temp!.value
			temp = temp!.next
		}
		return sum
	}

	public func sortedInsert(_ value : Int) {
		let newNode = Node(value, nil)
		var curr = self.head

		if curr == nil || curr!.value > value {
			newNode.next = self.head
			self.head = newNode
			return
		}
		while curr!.next != nil && curr!.next!.value < value {
			curr = curr!.next
		}
		newNode.next = curr!.next
		curr!.next = newNode
	}

	public func find(_ data : Int) -> Bool {
		var temp = self.head
		while temp != nil {
			if temp!.value == data {
				return true
			}
			temp = temp!.next
		}
		return false
	}

	public func removeHead() -> (value : Int, flag : Bool) {
		guard let head = self.head else {
			print("Empty List Error")
			return (0, false)
		}
		let value = head.value
		self.head = head.next
		self.size -= 1
		return (value, true)
	}

	public func deleteNode(_ delValue : Int) -> Bool {
		var temp = self.head
		if self.isEmpty() {
			print("Empty List Error")
			return false
		}
		if delValue == self.head!.value {
			self.head = self.head!.next
			self.size -= 1
			return true
		}
		while temp!.next != nil {
			if temp!.next!.value == delValue {
				temp!.next = temp!.next!.next
				self.size -= 1
				return true
			}
			temp = temp!.next
		}
		return false
	}

	public func deleteNodes(_ delValue : Int) -> Bool {
		var currNode = self.head
		var retVal : Bool = false
		while currNode != nil && currNode!.value == delValue {
			self.head = currNode!.next
			currNode = self.head
			retVal = true
		}

		while currNode != nil {
			let nextNode = currNode!.next
			if nextNode != nil && nextNode!.value == delValue {
				currNode!.next = nextNode!.next
				retVal = true
			} else {
				currNode = nextNode
			}
		}
		return retVal
	}

	public func freeList() {
		self.head = nil
		self.size = 0
	}

	public func reverse() {
		var curr = self.head
		var prev : Node?
		var next : Node?
		while curr != nil {
			next = curr!.next
			curr!.next = prev
			prev = curr
			curr = next
		}
		self.head = prev
	}

	public func reverseRecurse() {
		self.head = reverseRecurseUtil( currentNode : self.head, nextNode : nil)
	}

	private func reverseRecurseUtil(currentNode : Node?, nextNode : Node?) -> Node? {
		guard let currentNode = currentNode else {
			return nil
		}

		if currentNode.next == nil {
			currentNode.next = nextNode
			return currentNode
		}

		let ret = reverseRecurseUtil(currentNode : currentNode.next, nextNode : currentNode)
		currentNode.next = nextNode
		return ret
	}

	public func removeDuplicate() {
		var curr = self.head
		while curr != nil {
			if curr!.next != nil && curr!.value == curr!.next!.value {
				curr!.next = curr!.next!.next
			} else {
				curr = curr!.next
			}
		}
	}

	public func copyListReversed() -> List {
		var tempNode : Node? = nil
		var tempNode2 : Node? = nil
		var curr = self.head
		while curr != nil {
			tempNode2 = Node(curr!.value, tempNode)
			curr = curr!.next
			tempNode = tempNode2
		}
		let ll2 = List()
		ll2.head = tempNode
		return ll2
	}

	public func copyList() -> List {
		var headNode : Node, tailNode : Node, tempNode : Node
		var curr = self.head

		if curr == nil {
			let ll2 = List()
			ll2.head = nil
			return ll2
		}

		headNode = Node(curr!.value, nil)
		tailNode = headNode
		curr = curr!.next

		while curr != nil {
			tempNode = Node(curr!.value, nil)
			tailNode.next = tempNode
			tailNode = tempNode
			curr = curr!.next
		}
		let ll2 = List()
		ll2.head = headNode
		return ll2
	}

	public func compareList(_ ll : List) -> Bool {
		return compareListUtil(head1 : self.head, head2 : ll.head)
	}

	private func compareListUtil(head1 : Node?, head2 : Node?) -> Bool {
		if head1 == nil && head2 == nil {
			return true
		} else if (head1 == nil) || (head2 == nil) || (head1!.value != head2!.value) {
			return false
		} else {
			return compareListUtil(head1 : head1!.next, head2 : head2!.next)
		}
	}


	func compareList2(_ ll2 : List) -> Bool {
		var head1 : Node? = self.head
		var head2 : Node? = ll2.head
		while (head1 != nil && head2 != nil) {
			if (head1!.value != head2!.value) {
				return false
			}
			head1 = head1!.next
			head2 = head2!.next
		}
		if (head1 == nil && head2 == nil) {
			return true
		}
		return false
	}



	public func findLength() -> Int {
		var curr = self.head
		var count = 0
		while curr != nil {
			count += 1
			curr = curr!.next
		}
		return count
	}

	public func nthNodeFromBegining(_ index : Int) -> (value : Int, flag : Bool) {
		if index > self.length() || index < 1 {
			print("TooFewNodes")
			return (0, false)
		}
		var count = 0
		var curr = self.head
		while curr != nil && count < index-1 {
			count += 1
			curr = curr!.next
		}
		return (curr!.value, true)
	}

	public func nthNodeFromEnd(_ index : Int) -> (value : Int, flag : Bool) {
		let size = self.size
		if size != 0 && size < index {
			print("TooFewNodes")
			return (0, false)
		}
		let startIndex = size - index + 1
		return nthNodeFromBegining(startIndex)
	}

	public func nthNodeFromEnd2(_ index : Int) -> (value : Int, flag : Bool) {
		var count = 1
		var forward = self.head
		var curr = self.head
		while forward != nil && count <= index {
			count += 1
			forward = forward!.next
		}

		if forward == nil {
			print("TooFewNodes")
			return (0, false)
		}

		while forward != nil {
			forward = forward!.next
			curr = curr!.next
		}
		return (curr!.value, true)
	}

	public func makeLoop() {
		var temp = self.head
		while temp != nil {
			if temp!.next == nil {
				temp!.next = self.head
				return
			}
			temp = temp!.next
		}
	}

	/*
	func loopDetect() -> Bool {
		var curr : Node? = self.head
		let hs : Set<Node> = Set<Node>()
		while (curr != nil) {
			if (hs.contains(curr)) {
				print("loop found")
				return true
			}
			hs.insert(curr)
			curr = curr!.next
		}
		print("loop not found")
		return false
	}
	*/

	public func loopDetect2() -> Bool {
		var slowPtr = self.head
		var fastPtr = self.head

		while fastPtr!.next != nil && fastPtr!.next!.next != nil {
			slowPtr = slowPtr!.next
			fastPtr = fastPtr!.next!.next
			if slowPtr! === fastPtr! {
				print("loop found")
				return true
			}
		}
		print("loop not found")
		return false
	}


	public func reverseListLoopDetect() -> Bool {
		let tempHead = self.head
		reverse()
		if tempHead === self.head {
			reverse()
			print("loop found")
			return true
		}
		reverse()
		print("loop not found")
		return false
	}

	public func loopTypeDetect() -> Int {
		var slowPtr = self.head
		var fastPtr = self.head
		while fastPtr!.next != nil && fastPtr!.next!.next != nil {
			if self.head === fastPtr!.next || self.head === fastPtr!.next!.next {
				print("circular list loop found")
				return 2
			}
			slowPtr = slowPtr!.next
			fastPtr = fastPtr!.next!.next
			if slowPtr === fastPtr {
				print("loop found")
				return 1
			}
		}
		print("loop not found")
		return 0
	}

	public func removeLoop() {
		let loopPoint = loopPointDetect()
		if loopPoint === nil {
			return
		}

		var firstPtr = self.head
		if loopPoint === self.head {
			while firstPtr!.next !== self.head {
				firstPtr = firstPtr!.next
			}
			firstPtr!.next = nil
			return
		}

		var secondPtr = loopPoint
		while firstPtr!.next !== secondPtr!.next {
			firstPtr = firstPtr!.next
			secondPtr = secondPtr!.next
		}
		secondPtr!.next = nil
	}

	public func loopPointDetect() -> Node? {
		var slowPtr = self.head
		var fastPtr = self.head

		while fastPtr!.next != nil && fastPtr!.next!.next != nil {
			slowPtr = slowPtr!.next
			fastPtr = fastPtr!.next!.next
			if slowPtr === fastPtr {
				return slowPtr
			}
		}
		return nil
	}

	public func link(_ ll2 : List, _ n : Int) {
		var i : Int = 0
		var tempHead = head	
		while i < n {
			i += 1
			tempHead = tempHead!.next
		}
		ll2.head = tempHead
	}

	public func findIntersection(_ ll2 : List) -> Int {
		var head = self.head
		var head2 = ll2.head
		var l1 = 0
		var l2 = 0
		var tempHead = head
		var tempHead2 = head2
		while tempHead != nil {
			l1 += 1
			tempHead = tempHead!.next
		}
		while tempHead2 != nil {
			l2 += 1
			tempHead2 = tempHead2!.next
		}
		var diff : Int
		if l1 < 12 {
			let temp = head
			head = head2
			head2 = temp
			diff = l2 - l1
		} else {
			diff = l1 - l2
		}
		while diff > 0 {
			head = head!.next
			diff -= 1
		}
		while head! !== head2! {
			head = head!.next
			head2 = head2!.next
		}
		return head!.value
	}

    func nthNodeFromBeginning(_ index : Int) -> Int {
        if (index > self.length() || index < 1) {
            return Int.max
        }
        var count : Int = 0
        var curr : Node? = self.head
        while (curr != nil && count < index - 1) {
            count += 1
            curr = curr!.next
        }
        return curr!.value
    }

	func bubbleSort()
    {
        var curr : Node?
        var end : Node? = nil
        var temp : Int
        if (self.head == nil || self.head!.next == nil) {
            return
        }
        var flag : Bool = true
        while (flag) {
            flag = false
            curr = self.head
            while (!(curr!.next===end)) {
                if (curr!.value > curr!.next!.value) {
                    flag = true
                    temp = curr!.value
                    curr!.value = curr!.next!.value
                    curr!.next!.value = temp
                }
                curr = curr!.next
            }
            end = curr
        }
    }
    func selectionSort()
    {
        var curr : Node?
        var end : Node? = nil
        var maxNode : Node?
        var temp : Int
        var max : Int
        if (self.head == nil || self.head!.next == nil) {
            return
        }
        while (!(self.head===end)) {
            curr = self.head
            max = curr!.value
            maxNode = curr
            while (!(curr!.next===end)) {
                if (max < curr!.next!.value) {
                    maxNode = curr!.next
                    max = curr!.next!.value
                }
                curr = curr!.next
            }
            end = curr
            if (curr!.value < max) {
                temp = curr!.value
                curr!.value = max
                maxNode!.value = temp
            }
        }
    }
    func insertionSort()
    {
        var curr : Node?
        var stop : Node?
        var temp : Int
        if (self.head == nil || self.head!.next == nil) {
            return
        }
        stop = self.head!.next
        while (stop != nil) {
            curr = self.head
            while (!(curr===stop)) {
                if (curr!.value > stop!.value) {
                    temp = curr!.value
                    curr!.value = stop!.value
                    stop!.value = temp
                }
                curr = curr!.next
            }
            stop = stop!.next
        }
    }
}

// Testing code.
func main1() {
	let ll : List = List()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(3)
	ll.display()
	print("Size : " + String(ll.length()))
	print("Is empty : " + String(ll.isEmpty()))
	print("Size : " + String(ll.findLength()))
	ll.addTail(4)
	ll.display()
}
// 3 2 1 
// Size : 3
// Size : 3
// Is empty : false
// Peek : 3
// 3 2 1 4

// Testing code.
func main2() {
	let ll : List = List()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(3)
	ll.display()
	print("find : " + String(ll.find(2)))
	_ = ll.removeHead()
	ll.display()
}
// 3 2 1 
// find : true
// 2 1

// Testing code.
func main3() {
	let ll : List = List()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(1)
	ll.addHead(3)
	ll.display()
	print("deleteNode : " + String(ll.deleteNode(2)))
	ll.display()
	print("deleteNodes : " + String(ll.deleteNodes(1)))
	ll.display()
}
// 3 1 2 1 2 1 
// deleteNode : true
// 3 1 1 2 1 
// deleteNodes : true
// 3 2

// Testing code.
func main4() {
	let ll : List = List()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(3)
	ll.display()
	ll.reverse()
	ll.display()
	ll.reverseRecurse()
	ll.display()
	let l2 : List = ll.copyList()
	l2.display()
	let l3 : List = ll.copyListReversed()
	l3.display()
}
// 3 2 1 
// 1 2 3 
// 3 2 1 
// 3 2 1 
// 1 2 3

// Testing code.
func main5() {
	let ll : List = List()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(3)
	ll.display()
	let l2 : List = ll.copyList()
	l2.display()
	let l3 : List = ll.copyListReversed()
	l3.display()
	print("compareList : " + String(ll.compareList(l2)))
	print("compareList : " + String(ll.compareList2(l2)))
	print("compareList : " + String(ll.compareList(l3)))
	print("compareList : " + String(ll.compareList2(l3)))
}
// 3 2 1 
// 3 2 1 
// 1 2 3 
// compareList : true
// compareList : true
// compareList : false
// compareList : false

// Testing code.
func main6() {
	let ll : List = List()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(3)
	ll.addHead(4)
	print(ll.nthNodeFromBeginning(2))
	print(ll.nthNodeFromEnd(2))
	print(ll.nthNodeFromEnd2(2))
}
// 3 2 1 
// 2
// 2
// 2

// Testing code.
func main7() {
	let ll : List = List()
	ll.sortedInsert(1)
	ll.sortedInsert(2)
	ll.sortedInsert(3)
	ll.sortedInsert(1)
	ll.sortedInsert(2)
	ll.sortedInsert(3)
	ll.display()
	ll.removeDuplicate()
	ll.display()
}
// 1 2 3 
// 1 1 2 2 3 3 
// 1 2 3

// Testing code.
func main8() {
	let ll : List = List()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(3)
	ll.display()
	ll.makeLoop()
	//print(ll.loopDetect())
	print(ll.loopDetect2())
	print(ll.reverseListLoopDetect())
	print(ll.loopTypeDetect())
	ll.removeLoop()
	print(ll.loopDetect2())
}
// 3 2 1 
// loop found
// circular list loop found
// loop not found

// Testing code.
func main9() {
	let ll : List = List()
	ll.addHead(1)
	ll.addHead(2)
	ll.addHead(3)
	ll.addHead(4)

	let ll2 : List = List()
	ll.link(ll2, 2)
	ll2.addHead(5)
	ll2.addHead(6)
	ll.display()
	ll2.display()

	let val : Int = ll.findIntersection(ll2)
	print("Intersection:: " + String(val))
}

// 4 3 2 1 
// 6 5 2 1 
// Intersection:: 2

// Testing code.
func main10() {
	let ll : List = List()
	ll.addHead(1)
	ll.addHead(10)
	ll.addHead(9)
	ll.addHead(7)
	ll.addHead(2)
	ll.addHead(3)
	ll.addHead(5)
	ll.addHead(4)
	ll.addHead(6)
	ll.addHead(8)
	ll.display()
	ll.bubbleSort()
	ll.display()
}

// 8 6 4 5 3 2 7 9 10 1 
// 1 2 3 4 5 6 7 8 9 10 

// Testing code.
func main11() {
	let ll : List = List()
	ll.addHead(1)
	ll.addHead(10)
	ll.addHead(9)
	ll.addHead(7)
	ll.addHead(2)
	ll.addHead(3)
	ll.addHead(5)
	ll.addHead(4)
	ll.addHead(6)
	ll.addHead(8)
	ll.display()
	ll.selectionSort()
	ll.display()
}

// Testing code.
func main12() {
	let ll : List = List()
	ll.addHead(1)
	ll.addHead(10)
	ll.addHead(9)
	ll.addHead(7)
	ll.addHead(2)
	ll.addHead(3)
	ll.addHead(5)
	ll.addHead(4)
	ll.addHead(6)
	ll.addHead(8)
	ll.display()
	ll.insertionSort()
	ll.display()
}

main1()
main2()
main3()
main4()
main5()
main6()
main7()
main8()
main9()
main10()
main11()
main12()
