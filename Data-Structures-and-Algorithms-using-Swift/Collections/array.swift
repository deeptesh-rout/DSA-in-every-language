
var arr = [1, 2, 3, 4, 5]
print("Array :", arr)
print("IsEmpty :", arr.isEmpty)
print("Size :", arr.count)
arr[1] = 6
print("Value at index 1 : ", arr[1])

for ele in arr {
    print(ele, terminator: " ")
}
print()

var i = 0
while (i < arr.count) {
    print(arr[i], terminator: " ")
    i += 1
}
print()


/* 
Array : [1, 2, 3, 4, 5]
IsEmpty : false
Size : 5
Value at index 1 : 6
1 6 3 4 5 
1 6 3 4 5 
*/

var arr3 : [Int] = [Int]() // Empty Array

arr3.append(1)
arr3.append(2)
arr3.append(3)

print("Last :", arr3.last!) // Stack Top
print("RemoveLast :", arr3.removeLast()) // Stack behaviour

print("First :", arr3.first!) // Queue Front
print("RemoveFirst :", arr3.removeFirst()) // Queue behaviour

/* 
Last : 3
RemoveLast : 3
First : 1
RemoveFirst : 1 
*/

var arr4 : [Int] = Array(repeating: 1, count: 5) // Array with repeating elements.
print("Array : ", arr4)

// Array :  [1, 1, 1, 1, 1]

