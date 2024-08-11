class CircularLinkedList {
    private var tail : Node? = nil
    private var size : Int = 0

    class Node {
        var value : Int
        var next : Node?

        init(_ v : Int, _ n : Node? = nil) {
            self.value = v
            self.next = n
        }
    }
    
    public func length() -> Int {
        return self.size
    }
    
    public func isEmpty() -> Bool {
        return self.size == 0
    }
    
    public func peek() -> Int {
        if (self.isEmpty()) {
            print("Empty List Error")
			return 0
        }
        return self.tail!.next!.value
    }

    // Other methods

    public func addTail(_ value : Int) {
        let temp : Node = Node(value)
        if (self.isEmpty()) {
            self.tail = temp
            temp.next = temp
        } else {
            temp.next = self.tail!.next
            self.tail!.next = temp
            self.tail = temp
        }
        self.size += 1
    }

    public func addHead(_ value : Int) {
        let temp : Node = Node(value)
        if (self.isEmpty()) {
            self.tail = temp
            temp.next = temp
        } else {
            temp.next = self.tail!.next
            self.tail!.next = temp
        }
        self.size += 1
    }

    public func removeHead(){
        if (self.isEmpty()) {
            print("Empty List Error")
            return
        }
        if (self.tail === self.tail!.next) {
            self.tail = nil
        } else {
            self.tail!.next = self.tail!.next!.next
        }
        self.size -= 1
    }

    public func removeNode(_ key : Int) {
        if (self.isEmpty()) {
            print("Empty List Error")
            return
        }
        var prev : Node? = self.tail
        var curr : Node? = self.tail!.next
        let head : Node? = self.tail!.next
        if (curr!.value == key) {
            // head and single node case.
            if (curr === curr!.next) {
                // single node case
                self.tail = nil
            } else {
                // head case
                self.tail!.next = self.tail!.next!.next
            }
            return
        }
        prev = curr
        curr = curr!.next
        while (!(curr===head)) {
            if (curr!.value == key) {
                if (curr === self.tail) {
                    self.tail = prev
                }
                prev!.next = curr!.next
                return
            }
            prev = curr
            curr = curr!.next
        }
    }

    public func copyListReversed() -> CircularLinkedList {
        let cl : CircularLinkedList = CircularLinkedList()
        if (self.isEmpty()) {
            return cl
        }
        var curr : Node? = self.tail!.next
        let head : Node? = curr
        if (curr != nil) {
            cl.addHead(curr!.value)
            curr = curr!.next
        }

        while (curr !== head) {
            cl.addHead(curr!.value)
            curr = curr!.next
        }
        return cl
    }

    public func copyList() -> CircularLinkedList {
        let cl : CircularLinkedList = CircularLinkedList()
        if (self.isEmpty()) {
            return cl
        }

        var curr : Node? = self.tail!.next
        let head : Node? = curr
        if (curr != nil) {
            cl.addTail(curr!.value)
            curr = curr!.next
        }

        while (curr !== head) {
            cl.addTail(curr!.value)
            curr = curr!.next
        }
        return cl
    }

    public func search(_ data : Int) -> Bool {
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

    public func deleteList() {
        self.tail = nil
        self.size = 0
    }

    public func display() {
        if (self.isEmpty()) {
            print("Empty List.")
            return
        }
        var temp : Node? = self.tail!.next
        while (!(temp===self.tail)) {
            print(String(temp!.value) + " ",terminator: "")
            temp = temp!.next
        }
        print(temp!.value)
    }
}

// Testing code.
func main1() {
    let ll : CircularLinkedList = CircularLinkedList()
    ll.addHead(1)
    ll.addHead(2)
    ll.addHead(3)
    ll.display()
    print(ll.length())
    print(ll.isEmpty())
    print(ll.peek())
    print(ll.search(3))
}
// 3 2 1
// 3
// false
// 3
// true

// Testing code.
func main2() {
    let ll : CircularLinkedList = CircularLinkedList()
    ll.addTail(1)
    ll.addTail(2)
    ll.addTail(3)
    ll.display()
}
// 1 2 3

// Testing code.
func main3() {
    let ll : CircularLinkedList = CircularLinkedList()
    ll.addHead(1)
    ll.addHead(2)
    ll.addHead(3)
    ll.display()
    ll.removeHead()
    ll.display()
    ll.removeNode(2)
    ll.display()
    ll.deleteList()
    ll.display()
}
// 3 2 1
// 2 1
// 1
// Empty List.

// Testing code.
func main4() {
    let ll : CircularLinkedList = CircularLinkedList()
    ll.addHead(1)
    ll.addHead(2)
    ll.addHead(3)
    ll.display()
    let ll2 : CircularLinkedList = ll.copyList()
    ll2.display()
    let ll3 : CircularLinkedList = ll.copyListReversed()
    ll3.display()
}
// 3 2 1
// 3 2 1
// 1 2 3

// Testing code.
func main5() {
    let ll : CircularLinkedList = CircularLinkedList()
    ll.addHead(1)
    ll.addHead(2)
    ll.addHead(3)
    ll.display()
    ll.removeNode(2)
    ll.display()
}
// 3 2 1
// 3 1

main1()
main2()
main3()
main4()
main5()
