var deq : [Int] = [Int]()

deq.append(1)
deq.append(2)
deq.append(3)
deq.append(4)

print("Deque :", deq)
print("Size :", deq.count)
print("IsEmpty :", deq.isEmpty)

print("First :", deq.first!)
print("RemoveFirst", deq.removeFirst()) // Queue Remove
print("Deque :", deq)

print("Last :", deq.last!)
print("RemoveLast", deq.removeLast()) // Stack Pop
print("Deque :", deq)

/* 
Deque : [1, 2, 3, 4]
Size : 4
IsEmpty : false
First : 1
RemoveFirst 1
Deque : [2, 3, 4]
Last : 4
RemoveLast 4
Deque : [2, 3]
 */