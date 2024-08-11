import Foundation
class Queue {
    private var stk1 :  [Int]
    private var stk2 :  [Int]
    
	init() {
        self.stk1 =  [Int]()
        self.stk2 =  [Int]()
    }
    
	func add(_ value : Int) {
        self.stk1.append(value)
    }
    
	func remove() -> Int {
        var value : Int
        if (self.stk2.isEmpty == false) {
            return self.stk2.removeLast()
        }

        while (self.stk1.isEmpty == false) {
            value = self.stk1.removeLast()
            self.stk2.append(value)
        }
        return self.stk2.removeLast()
    }
}

// Testing code.
let que : Queue = Queue()
que.add(1)
que.add(2)
que.add(3)
print("Queue remove :", que.remove()!)
print("Queue remove :", que.remove()!)