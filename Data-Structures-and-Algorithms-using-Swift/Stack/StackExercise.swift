import Foundation

func function2() {
	print("fun2 line 1")
}

func function1() {
	print("fun1 line 1")
	function2()
	print("fun1 line 2")
}

// Testing code.  
func main1() {
	print("main line 1")
	function1()
	print("main line 2")
}

// main line 1
// fun1 line 1
// fun2 line 1
// fun1 line 2
// main line 2

func isBalancedParenthesis(_ expn : String) -> Bool {
	var stk : [Character] = [Character]()
	var val : Character
	for ch in expn {
		switch (ch) {
			case "{", "[", "(":
				stk.append(ch)
				break
			case "}":
				if(stk.isEmpty) {
					return false
				}
				val = stk.removeLast()
				if (!(val == "{")) {
					return false
				}
				break
			case "]":
				if(stk.isEmpty) {
					return false
				}
				val = stk.removeLast()
				if (!(val == "[")) {
					return false
				}
				break
			case ")":
				if(stk.isEmpty) {
					return false
				}
				val = stk.removeLast()
				if (!(val == "(")) {
					return false
				}
				break
			default:
				break
		}
	}
	return stk.isEmpty
}

// Testing code. 
func main2() {
	let expn : String = "{()}[]"
	let value : Bool = isBalancedParenthesis(expn)
	print("isBalancedParenthesis: " + String(value))
}
// isBalancedParenthesis: true

func postfixEvaluate(_ expn : String) -> Int {
	var stk : [Int] = [Int]()
	let expArr = expn.split(separator : " ")
	for tkn in expArr {
		if let value = Int(tkn) {
			stk.append(value)
		} else {
			let num1 : Int = stk.removeLast()
			let num2 : Int = stk.removeLast()
			
			switch (tkn) {
				case "+":
					stk.append(num1 + num2)
					break
				case "-":
					stk.append(num1 - num2)
					break
				case "*":
					stk.append(num1 * num2)
					break
				case "/":
					stk.append(num1 / num2)
					break
				default :
					break
			}
		}
	}
	return stk.removeLast()
}

// Testing code. 
func main3() {
	let expn : String = "6 5 2 3 + 8 * + 3 + *"
	let value : Int = postfixEvaluate(expn)
	print("Result after Evaluation: " + String(value))
}
// Result after Evaluation: 288

func precedence(_ x : Character) -> Int {
	if (x == "(") {
		return (0)
	}
	if (x == "+" || x == "-") {
		return (1)
	}
	if (x == "*" || x == "/" || x == "%") {
		return (2)
	}
	if (x == "^") {
		return (3)
	}
	return (4)
}

func infixToPostfix(_ expn : String) -> String {
	var stk : [Character] = [Character]()
	var output : String = ""
	var out : Character

	for ch in expn{
		if (ch <= "9" && ch >= "0") {
			output = output + String(ch)
		} else {
			switch (ch) {
				case "+", "-", "*", "/", "%", "^":
					while (stk.isEmpty == false && precedence(ch) <= precedence(stk.last!)) {
						out = stk.removeLast()
						output = output + " " + String(out)
					}
					stk.append(ch)
					output = output + " "
					break
				case "(":
					stk.append(ch)
					break
				case ")":
					while (stk.isEmpty == false && stk.last != "(") {
						out = stk.removeLast()
						output = output + " " + String(out) + " "
					}
					if (stk.isEmpty == false) {
						out = stk.removeLast()
					}
					break
				default :
					break
			}
		}
	}
	while (stk.isEmpty == false) {
		out = stk.removeLast()
		output = output + String(out) + " "
	}
	return output
}

// Testing code. 
func main4() {
	let expn : String = "10+((3))*5/(16-4)"
	let value : String = infixToPostfix(expn)
	print("Infix Expn: " + expn)
	print("Postfix Expn: " + value)
}
// Infix Expn: 10+((3))*5/(16-4)
// Postfix Expn: 10 3 5 * 16 4 - / +

func infixToPrefix(_ expn : String) -> String {
	var arr : [Character] = Array(expn)
	reverseArray(&arr)
	replaceParenthesis(&arr)
	arr = Array(infixToPostfix(String(arr)))
	reverseArray(&arr)
	return String(arr)
}

func replaceParenthesis(_ a : inout [Character]) {
	var lower : Int = 0
	let upper : Int = a.count - 1
	while (lower <= upper) {
		if (a[lower] == "(") {
			a[lower] = ")"
		} else if (a[lower] == ")") {
			a[lower] = "("
		}
		lower += 1
	}
}

func reverseArray(_ expn : inout [Character]) {
	var lower : Int = 0
	var upper : Int = expn.count - 1
	var tempChar : Character
	while (lower < upper) {
		tempChar = expn[lower]
		expn[lower] = expn[upper]
		expn[upper] = tempChar
		lower += 1
		upper -= 1
	}
}

// Testing code. 
func main5() {
	let expn : String = "10+((3))*5/(16-4)"
	let value : String = infixToPrefix(expn)
	print("Infix Expn: " + expn)
	print("Prefix Expn: " + value)
}
// Infix Expn: 10+((3))*5/(16-4)
// Prefix Expn:  +10 * 3 / 5  - 16 4

func stockSpanRange(_ arr : inout [Int]) -> [Int] {
	var SR : [Int] = Array(repeating: 0, count: arr.count)
	SR[0] = 1
	var i : Int = 1
	while (i < arr.count) {
		SR[i] = 1
		var j : Int = i - 1
		while ((j >= 0) && (arr[i] >= arr[j])) {
			SR[i] += 1
			j -= 1
		}
		i += 1
	}
	return SR
}

func stockSpanRange2(_ arr : inout [Int]) -> [Int] {
	var stk : [Int] = [Int]()
	var SR : [Int] = Array(repeating: 0, count: arr.count)
	stk.append(0)
	SR[0] = 1
	var i : Int = 1
	while (i < arr.count) {
		while (!stk.isEmpty && arr[stk.last!] <= arr[i]) {
			stk.removeLast()
		}
		SR[i] = (stk.isEmpty) ? (i + 1) : (i - stk.last!)
		stk.append(i)
		i += 1
	}
	return SR
}

// Testing code. 
func main6() {
	var arr : [Int] = [6, 5, 4, 3, 2, 4, 5, 7, 9]
	var value : [Int] = stockSpanRange( &arr)
	print("stockSpanRange : ",terminator: "")
	for val in value{
		print(String(val) ,terminator: " ")
	}
	print()
	value = stockSpanRange2( &arr)
	print("stockSpanRange : ",terminator: "")
	for val in value{
		print(String(val) ,terminator: " ")
	}
	print()
}
// stockSpanRange : 1 1 1 1 1 4 6 8 9 
// stockSpanRange : 1 1 1 1 1 4 6 8 9

func getMaxArea(_ arr : inout [Int]) -> Int {
	let size : Int = arr.count
	var maxArea : Int = -1
	var currArea : Int
	var minHeight : Int = 0
	var i : Int = 1
	while (i < size) {
		minHeight = arr[i]
		var j : Int = i - 1
		while (j >= 0) {
			if (minHeight > arr[j]) {
				minHeight = arr[j]
			}
			currArea = minHeight * (i - j + 1)
			if (maxArea < currArea) {
				maxArea = currArea
			}
			j -= 1
		}
		i += 1
	}
	return maxArea
}

func getMaxArea2(_ arr : inout [Int]) -> Int {
	let size : Int = arr.count
	var stk : [Int] = [Int]()
	var maxArea : Int = 0
	var top : Int
	var topArea : Int
	var i : Int = 0
	while (i < size) {
		while ((i < size) && (stk.isEmpty || arr[stk.last!] <= arr[i])) {
			stk.append(i)
			i += 1
		}
		while (!stk.isEmpty && (i == size || arr[stk.last!] > arr[i])) {
			top = stk.last!
			stk.removeLast()
			topArea = arr[top] * (stk.isEmpty ? i : i - stk.last! - 1)
			if (maxArea < topArea) {
				maxArea = topArea
			}
		}
	}
	return maxArea
}

// Testing code. 
func main7() {
	var arr : [Int] = [7, 6, 5, 4, 4, 1, 6, 3, 1]
	var value : Int = getMaxArea( &arr)
	print("getMaxArea :: " + String(value))
	value = getMaxArea2( &arr)
	print("getMaxArea :: " + String(value))
}
// getMaxArea :: 20
// getMaxArea :: 20

func stockAnalystAdd(_ stk : inout [Int], _ value : Int) {
	while (!stk.isEmpty && stk.last! <= value) {            
		stk.removeLast()
	}
	stk.append(value)
}

// Testing code. 
func main8() {
let arr : [Int] = [20, 19, 10, 21, 40, 35, 39, 50, 45, 42]
var stk : [Int] = [Int]()
var i : Int = arr.count - 1
while (i >= 0) {
	stockAnalystAdd(&stk,arr[i])
	i -= 1
}
print(stk)
}

func sortedInsert(_ stk : inout [Int], _ element : Int) {
	var temp : Int
	if (stk.isEmpty || element > stk.last!) {
		stk.append(element)
	} else {
		temp = stk.removeLast()
		sortedInsert(&stk,element)
		stk.append(temp)
	}
}

// Testing code.
func main9() {
	var stk : [Int] = [Int]()
	stk.append(1)
	stk.append(3)
	stk.append(4)
	print(stk)
	sortedInsert(&stk,2)
	print(stk)
}
// [1, 3, 4]
// [1, 2, 3, 4]

func sortStack(_ stk : inout  [Int]) {
	var temp : Int
	if (stk.isEmpty == false) {
		temp = stk.removeLast()
		sortStack(&stk)
		sortedInsert(&stk,temp)
	}
}

func sortStack2(_ stk : inout [Int]) {
	var temp : Int
	var stk2 : [Int] = [Int]()
	while (stk.isEmpty == false) {
		temp = stk.removeLast()
		while ((stk2.isEmpty == false) && (stk2.last! < temp)) {                
			stk.append(stk2.removeLast())
		}
		stk2.append(temp)
	}
	while (stk2.isEmpty == false) {            
		stk.append(stk2.removeLast())
	}
}

// Testing code.
func main10() {
	var stk : [Int] = [Int]()
	stk.append(3)
	stk.append(1)
	stk.append(4)
	stk.append(2)
	print(stk)
	sortStack(&stk)
	print(stk)
	stk =  [Int]()
	stk.append(3)
	stk.append(1)
	stk.append(4)
	stk.append(2)
	print(stk)
	sortStack2(&stk)
	print(stk)
}
// [3, 1, 4, 2]
// [1, 2, 3, 4]
// [3, 1, 4, 2]
// [1, 2, 3, 4]

func bottomInsert(_ stk : inout [Int], _ element : Int) {
	var temp : Int
	if (stk.isEmpty) {
		stk.append(element)
	} else {
		temp = stk.removeLast()
		bottomInsert(&stk,element)
		stk.append(temp)
	}
}

// Testing code.
func main11() {
	var stk : [Int] = [Int]()
	stk.append(1)
	stk.append(2)
	stk.append(3)
	print(stk)
	bottomInsert(&stk,4)
	print(stk)
}
// [1, 2, 3]
// [4, 1, 2, 3]

func reverseStack(_ stk : inout [Int]) {
	if (stk.isEmpty) {
		return
	} else {
		let value = stk.removeLast()
		reverseStack(&stk)
		bottomInsert(&stk,value)
	}
}

func reverseStack2(_ stk : inout [Int]) {
	var que : [Int] = [Int]()
	while (stk.isEmpty == false) {            
		que.append(stk.removeLast())
	}
	while (que.isEmpty == false) {            
		stk.append(que.removeFirst())
	}
}

func reverseKElementInStack(_ stk : inout [Int], _ k : Int) {
	var que : [Int] = [Int]()
	var i : Int = 0
	while (stk.isEmpty == false && i < k) {
		que.append(stk.removeLast())
		i += 1
	}
	while (que.isEmpty == false) {            
		stk.append(que.removeFirst())
	}
}

func reverseQueue(_ que : inout [Int]) {
	var stk : [Int] = [Int]()
	while (que.isEmpty == false) {            
		stk.append(que.removeFirst())
	}
	while (stk.isEmpty == false) {            
		que.append(stk.removeLast())
	}
}

func reverseKElementInQueue(_ que : inout [Int], _ k : Int) {
	var stk : [Int] = [Int]()
	var i : Int = 0
	var diff : Int
	var temp : Int
	while (que.isEmpty == false && i < k) {
		stk.append(que.removeFirst())
		i += 1
	}
	while (stk.isEmpty == false) {
		que.append(stk.removeLast())
	}
	diff = que.count - k
	while (diff > 0) {
		temp = que.removeFirst()
		que.append(temp)
		diff -= 1
	}
}

// Testing code.
func main12() {
	var stk : [Int] = [Int]()
	stk.append(1)
	stk.append(2)
	stk.append(3)
	print(stk)
}
// [1, 2, 3]

// Testing code.
func main13() {
	var stk : [Int] = [Int]()
	stk.append(1)
	stk.append(2)
	stk.append(3)
	stk.append(4)
	print(stk)
	reverseStack(&stk)
	print(stk)
	reverseStack2(&stk)
	print(stk)
	reverseKElementInStack(&stk,2)
	print(stk)
	print()
}
// [1, 2, 3, 4]
// [4, 3, 2, 1]
// [1, 2, 3, 4]
// [1, 2, 4, 3]

// Testing code.
func main14() {
	var que : [Int] = [Int]()
	que.append(1)
	que.append(2)
	que.append(3)
	print(que)
	reverseQueue(&que)
	print(que)
	reverseKElementInQueue(&que,2)
	print(que)
}
// [1, 2, 3]
// [3, 2, 1]
// [2, 3, 1]

func maxDepthParenthesis(_ expn : String, _ size : Int) -> Int {
	var stk : [Character] = [Character]()
	var maxDepth : Int = 0
	var depth : Int = 0
	var ch : Character
	var i : Int = 0
	while (i < size) {
		ch = Array(expn)[i]
		if (ch == "(") {
			stk.append(ch)
			depth += 1
		} else if (ch == ")") {
			stk.removeLast()
			depth -= 1
		}

		if (depth > maxDepth) {
			maxDepth = depth
		}
		i += 1
	}
	return maxDepth
}

func maxDepthParenthesis2(_ expn : String, _ size : Int) -> Int {
	var maxDepth : Int = 0
	var depth : Int = 0
	var ch : Character
	var i : Int = 0
	while (i < size) {
		ch = Array(expn)[i]
		if (ch == "(") {
			depth += 1
		} else if (ch == ")") {
			depth -= 1
		}

		if (depth > maxDepth) {
			maxDepth = depth
		}
		i += 1
	}
	return maxDepth
}

// Testing code.
func main15() {
	let expn : String = "((((A)))((((BBB()))))()()()())"
	let size : Int = expn.count
	print("Max depth parenthesis is " + String(maxDepthParenthesis(expn,size)))
	print("Max depth parenthesis is " + String(maxDepthParenthesis2(expn,size)))
}
// Max depth parenthesis is 6
// Max depth parenthesis is 6

func longestContBalParen(_ string : String, _ size : Int) -> Int {
	var stk : [Int] = [Int]()
	stk.append(-1)
	var length : Int = 0
	var i : Int = 0
	while (i < size) {
		if (Array(string)[i] == "(") {stk.append(i)
		} else {
			stk.removeLast()
			if (stk.count != 0) {
				length = max(length,i - stk.last!)
			} else {
				stk.append(i)
			}
		}
		i += 1
	}
	return length
}

func longestContBalParen2(_ string : String, _ size : Int) -> Int {
	var stk : [Int] = [Int]()
	var length : Int = 0
	var i : Int = 0
	while (i < size) {
		if (Array(string)[i] == "(") {
			stk.append(i)
		} else {
			// string[i] == ')'
			if (stk.count != 0) {
				length = max(length,i - stk.last! + 1)
				stk.removeLast()
			}
		}
		i += 1
	}
	return length
}

// Testing code.
func main16() {
	let expn : String = "())((()))(())()(()"
	let size : Int = expn.count
	print("longestContBalParen " + String(longestContBalParen(expn,size)))
	print("longestContBalParen " + String(longestContBalParen2(expn,size)))
}
// longestContBalParen 12

func reverseParenthesis(_ expn : String, _ size : Int) -> Int {
	var stk : [Character] = [Character]()
	var openCount : Int = 0
	var closeCount : Int = 0
	var ch : Character
	if (size % 2 == 1) {
		print("Invalid odd length " + String(size))
		return -1
	}
	var i : Int = 0
	while (i < size) {
		ch = Array(expn)[i]
		if (ch == "(") {
			stk.append(ch)
		} else if (ch == ")") {
			if (stk.count != 0 && stk.last! == "(") {
				stk.removeLast()
			} else {
				stk.append(")")
			}
		}
		i += 1
	}
	
	while (stk.count != 0) {
		if (stk.removeLast() == "(") {
			openCount += 1
		} else {
			closeCount += 1
		}
	}
	let reversal : Int = Int(ceil(Double(openCount) / 2.0)) + Int(ceil(Double(closeCount) / 2.0))
	return reversal
}

// Testing code.
func main17() {
	let expn2 : String = ")(())((("
	let size : Int = expn2.count
	let value : Int = reverseParenthesis(expn2,size)
	print("reverse Parenthesis is : " + String(value))
}
// reverse Parenthesis is : 3

func findDuplicateParenthesis(_ expn : String, _ size : Int) -> Bool {
	var stk : [Character] = [Character]()
	var ch : Character
	var count : Int
	var i : Int = 0
	while (i < size) {
		ch = Array(expn)[i]
		if (ch == ")") {
			count = 0
			while (stk.count != 0 && !(stk.last != "(")) {
				stk.removeLast()
				count += 1
			}
			if (count <= 1) {
				return true
			}
		} else {
			stk.append(ch)
		}
		i += 1
	}
	return false
}

// Testing code. 
func main18() {
	let expn : String = "(((a+b))+c)"
	let size : Int = expn.count
	let value : Bool = findDuplicateParenthesis(expn,size)
	print("Duplicate Found : " + String(value))
}
// Duplicate Found : true

func printParenthesisNumber(_ expn : String, _ size : Int) {
	var ch : Character
	var stk : [Int] = [Int]()
	var output : String = String()
	var count : Int = 1
	var i : Int = 0
	while (i < size) {
		ch = Array(expn)[i]
		if (ch == "(") {
			stk.append(count)
			output += String(count) + " "
			count += 1
		} else if (ch == ")") {
			output += String(stk.removeLast()) + " "
		}
		i += 1
	}
	print("Parenthesis Count :: " + output)
}

// Testing code. 
func main19() {
	let expn1 : String = "(((a+(b))+(c+d)))"
	let expn2 : String = "(((a+b))+c)((("
	printParenthesisNumber(expn1,expn1.count)
	printParenthesisNumber(expn2,expn2.count)
}
// Parenthesis Count :: 1 2 3 4 4 3 5 5 2 1 
// Parenthesis Count :: 1 2 3 3 2 1 4 5 6

func nextLargerElement(_ arr : inout [Int], _ size : Int) {
	var output : [Int] = Array(repeating: 0, count: size)
	var outIndex : Int = 0
	var next : Int
	var i : Int = 0
	while (i < size) {
		next = -1
		var j : Int = i + 1
		while (j < size) {
			if (arr[i] < arr[j]) {
				next = arr[j]
				break
			}
			j += 1
		}
		output[outIndex] = next
		outIndex += 1
		i += 1
	}
	
	for val in output{
		print(String(val) ,terminator: " ")
	}
	print()
}

func nextLargerElement2(_ arr : inout [Int], _ size : Int) {
	var stk : [Int] = [Int]()
	var output : [Int] = Array(repeating: 0, count: size)
	var index : Int = 0
	var curr : Int
	var i : Int = 0
	while (i < size) {
		curr = arr[i]
		// stack always have values in decreasing order.
		while (stk.isEmpty == false && arr[stk.last!] <= curr) {
			index = stk.removeLast()
			output[index] = curr
		}
		stk.append(i)
		i += 1
	}
	
	// index which dont have any next Larger.
	while (stk.isEmpty == false) {
		index = stk.removeLast()
		output[index] = -1
	}
	for val in output{
		print(String(val) ,terminator: " ")
	}
	print()
}

func nextSmallerElement(_ arr : inout [Int], _ size : Int) {
	var output : [Int] = Array(repeating: -1, count: size)
	var i : Int = 0
	while (i < size) {
		var j : Int = i + 1
		while (j < size) {
			if (arr[j] < arr[i]) {
				output[i] = arr[j]
				break
			}
			j += 1
		}
		i += 1
	}
	
	for val in output{
		print(String(val) ,terminator: " ")
	}
	print()
}

func nextSmallerElement2(_ arr : inout [Int], _ size : Int) {
	var stk : [Int] = [Int]()
	var output : [Int] = Array(repeating: 0, count: size)
	var curr : Int
	var index : Int
	var i : Int = 0
	while (i < size) {
		curr = arr[i]
		// stack always have values in increasing order.
		while (stk.isEmpty == false && arr[stk.last!] > curr) {
			index = stk.removeLast()
			output[index] = curr
		}
		stk.append(i)
		i += 1
	}
	
	// index which dont have any next Smaller.
	while (stk.isEmpty == false) {
		index = stk.removeLast()
		output[index] = -1
	}
	for val in output{
		print(String(val) ,terminator: " ")
	}
	print()
}

// Testing code. 
func main20() {
var arr : [Int] = [13, 21, 3, 6, 20, 3]
let size : Int = arr.count
	nextLargerElement( &arr,size)
	nextLargerElement2( &arr,size)
nextSmallerElement( &arr,size)
	nextSmallerElement2( &arr,size)
}
// 21 -1 6 20 -1 -1 
// 21 -1 6 20 -1 -1 
// 3 3 -1 3 3 -1

func nextLargerElementCircular(_ arr : inout [Int], _ size : Int) {
	var output : [Int] = Array(repeating: -1, count: size)
	var i : Int = 0
	while (i < size) {
		var j : Int = 1
		while (j < size) {
			if (arr[i] < arr[(i + j) % size]) {
				output[i] = arr[(i + j) % size]
				break
			}
			j += 1
		}
		i += 1
	}
	
	for val in output{
		print(String(val) ,terminator: " ")
	}
	print()
}

func nextLargerElementCircular2(_ arr : inout [Int], _ size : Int) {
	var stk : [Int] = [Int]()
	var curr : Int
	var index : Int
	var output : [Int] = Array(repeating: 0, count: size)
	var i : Int = 0
	while (i < (2 * size - 1)) {
		curr = arr[i % size]
		// stack always have values in decreasing order.
		while (stk.isEmpty == false && arr[stk.last!] <= curr) {
			index = stk.removeLast()
			output[index] = curr
		}
		stk.append(i % size)
		i += 1
	}
	
	// index which dont have any next Larger.
	while (stk.isEmpty == false) {
		index = stk.removeLast()
		output[index] = -1
	}
	for val in output{
		print(String(val) ,terminator: " ")
	}
	print()
}

// Testing code. 
func main21() {
var arr : [Int] = [6, 3, 9, 8, 10, 2, 1, 15, 7]
nextLargerElementCircular( &arr,arr.count)
	nextLargerElementCircular2( &arr,arr.count)
}
// 9 9 10 10 15 15 15 -1 9

func isKnown(_ relation : inout [[Int]], _ a : Int, _ b : Int) -> Bool {
	if (relation[a][b] == 1) {
		return true
	}
	return false
}

func findCelebrity(_ relation : inout [[Int]], _ count : Int) -> Int {
	var i : Int = 0
	var j : Int
	var cel : Bool = true
	while (i < count) {
		cel = true
		j = 0
		while (j < count) {
			if (i != j && (!isKnown( &relation,j,i) || isKnown( &relation,i,j))) {
				cel = false
				break
			}
			j += 1
		}
		
		if (cel == true) {
			return i
		}
		i += 1
	}
	return -1
}

func findCelebrity2(_ relation : inout [[Int]], _ count : Int) -> Int {
	var stk : [Int] = [Int]()
	var first : Int = 0
	var second : Int = 0
	var i : Int = 0
	while (i < count) {
		stk.append(i)
		i += 1
	}
	
	first = stk.removeLast()
	while (stk.count != 0) {
		second = stk.removeLast()
		if (isKnown( &relation,first,second)) {
			first = second
		}
	}
	i = 0
	while (i < count) {
		if (first != i && isKnown( &relation,first,i)) {
			return -1
		}
		if (first != i && isKnown( &relation,i,first) == false) {
			return -1
		}
		i += 1
	}
	return first
}

func findCelebrity3(_ relation : inout [[Int]], _ count : Int) -> Int {
	var first : Int = 0
	var second : Int = 1
	var i : Int = 0
	while (i < (count - 1)) {
		if (isKnown( &relation,first,second)) {
			first = second
		}
		second = second + 1
		i += 1
	}
	i = 0
	while (i < count) {
		if (first != i && isKnown( &relation,first,i)) {
			return -1
		}
		if (first != i && isKnown( &relation,i,first) == false) {
			return -1
		}
		i += 1
	}
	return first
}

// Testing code. 
func main22() {
var arr : [[Int]] = [[1, 0, 1, 1, 0],[1, 0, 0, 1, 0],[0, 0, 1, 1, 1],
[0, 0, 0, 0, 0],[1, 1, 0, 1, 1]]
print("Celebrity : " + String(findCelebrity3( &arr,5)))
	print("Celebrity : " + String(findCelebrity( &arr,5)))
	print("Celebrity : " + String(findCelebrity2( &arr,5)))
}
// Celebrity : 3
// Celebrity : 3

func isMinHeap(_ arr : inout [Int], _ size : Int) -> Int {
	var i : Int = 0
	while (i <= (size - 2) / 2) {
		if (2 * i + 1 < size) {
			if (arr[i] > arr[2 * i + 1]) {
				return 0
			}
		}
		if (2 * i + 2 < size) {
			if (arr[i] > arr[2 * i + 2]) {
				return 0
			}
		}
		i += 1
	}
	return 1
}

func isMaxHeap(_ arr : inout [Int], _ size : Int) -> Int {
	var i : Int = 0
	while (i <= (size - 2) / 2) {
		if (2 * i + 1 < size) {
			if (arr[i] < arr[2 * i + 1]) {
				return 0
			}
		}
		if (2 * i + 2 < size) {
			if (arr[i] < arr[2 * i + 2]) {
				return 0
			}
		}
		i += 1
	}
	return 1
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
main13()
main14()
main15()
main16()
main17()
main18()
main19()
main20()
main21()
main22()