class Stack {
    var que1: ArrayDeque<Int> = ArrayDeque<Int>()
    var que2: ArrayDeque<Int> = ArrayDeque<Int>()
    var size = 0

    fun push(value: Int) {
        que1.add(value)
        size += 1
    }

    fun pop(): Int {
        var value = 0
        var s = size
        while (s > 0) {
            value = que1.first()
            que1.removeFirst()
            if (s > 1) que2.add(value)
            s--
        }
        val temp: ArrayDeque<Int> = que1
        que1 = que2
        que2 = temp
        size -= 1
        return value
    }

	fun push2(value: Int) {
	    que1.add(value)
	    size += 1
	}
	
	fun pop2(): Int {
	    var value = 0
	    var s = size
	    while (s > 0) {
	        value = que1.first()
	        que1.removeFirst()
	        if (s > 1) que1.add(value)
	        s--
	    }
	    size -= 1
	    return value
	}
}

// Testing code
fun main() {
    val stk = Stack()
    stk.push(1)
    stk.push(2)
    stk.push(3)
    println("Stack pop : " + stk.pop())
    println("Stack pop : " + stk.pop())
}
 