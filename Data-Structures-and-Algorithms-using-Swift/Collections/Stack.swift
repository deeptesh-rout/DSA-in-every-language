var stk : [Int] = [Int]()

stk.append(1)
stk.append(2)
stk.append(3)

print("Stack :", stk)
print("Size :", stk.count)
print("IsEmpty :", stk.isEmpty)

print("Top :", stk.last!) // Stack Top
print("Pop :", stk.removeLast()) // Stack Pop
print("Stack :", stk)

/* 
Stack : [1, 2, 3]
Size : 3
IsEmpty : false
Top : 3
Pop : 3
Stack : [1, 2]
*/
