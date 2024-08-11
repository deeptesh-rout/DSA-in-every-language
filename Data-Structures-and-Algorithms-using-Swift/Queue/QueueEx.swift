import Foundation

func CircularTour(_ arr : inout [[Int]], _ n : Int) -> Int {
	var i : Int = 0
	while (i < n) {
		var total : Int = 0
		var found : Bool = true
		var j : Int = 0
		while (j < n) {
			total += (arr[(i + j) % n][0] - arr[(i + j) % n][1])
			if (total < 0) {
				found = false
				break
			}
			j += 1
		}
		
		if (found) {
			return i
		}
		i += 1
	}
	return -1
}

func CircularTour2(_ arr : inout [[Int]], _ n : Int) -> Int {
	var que : [Int] = [Int]()
	var nextPump : Int = 0
	var prevPump : Int
	var count : Int = 0
	var petrol : Int = 0

	while (que.count != n) {
		while (petrol >= 0 && que.count != n) {
			que.append(nextPump)
			petrol += (arr[nextPump][0] - arr[nextPump][1])
			nextPump = (nextPump + 1) % n
		}
		while (petrol < 0 && que.count > 0) {
			prevPump = que.removeFirst()
			petrol -= (arr[prevPump][0] - arr[prevPump][1])
		}
		count += 1
		if (count == n) {
			return -1
		}
	}
	if (petrol >= 0) {
		return que.removeFirst()
	}
	else
	{
		return -1
	}
}

// Testing code
func main1() {
	var tour : [[Int]] = [[8, 6], [1, 4], [7, 6]]
	print("Circular Tour : " + String(CircularTour( &tour,3)))
	print("Circular Tour : " + String(CircularTour2( &tour,3)))
}

// Circular Tour : 2
// Circular Tour : 2

func convertXY(_ src : Int, _ dst : Int) -> Int {
	var que : [Int] = [Int]()
	var arr : [Int] = Array(repeating: 0, count: 100)
	var steps : Int = 0
	var index : Int = 0
	var value : Int
	que.append(src)
	while (que.count != 0) {
		value = que.removeFirst()
		arr[index] = value
		index += 1
		if (value == dst) {
			return steps
		}
		steps += 1
		if (value < dst) {que.append(value * 2)
		}
		else
		{
			que.append(value - 1)
		}
	}
	return -1
}

// Testing code
func main2() {
	print("Steps count :: " + String(convertXY(2,7)))
}

// Steps count :: 3

func maxSlidingWindows(_ arr : inout [Int], _ size : Int, _ k : Int) {
	var i : Int = 0
	while (i < size - k + 1) {
		var mx : Int = arr[i]
		var j : Int = 1
		while (j < k) {
			mx = max(mx,arr[i + j])
			j += 1
		}
		
		print(String(mx) ,terminator: " ")
		i += 1
	}
	print()
}

func maxSlidingWindows2(_ arr : inout [Int], _ size : Int, _ k : Int) {
	var deq : [Int] = [Int]()
	var i : Int = 0
	while (i < size) {
		// Remove out of range elements
		if (deq.count > 0 && deq.first! <= i - k) {
			deq.removeFirst()
		}
		// Remove smaller values at left.
		while (deq.count > 0 && arr[deq.last!] <= arr[i]) {                    
			deq.removeLast()
		}
		deq.append(i)
		// Largest value in window of size k is at index que[0]
		// It is displayed to the screen.
		if (i >= (k - 1)) {
			print(String(arr[deq.first!]) ,terminator: " ")
		}
		i += 1
	}
	
	print()
}

// Testing code
func main3() {
	var arr : [Int] = [11, 2, 75, 92, 59, 90, 55]
	maxSlidingWindows( &arr,7,3)
	maxSlidingWindows2( &arr,7,3)
}

// 75 92 92 92 90 
// 75 92 92 92 90

func minOfMaxSlidingWindows(_ arr : inout [Int], _ size : Int, _ k : Int) -> Int {
	var deq : [Int] = [Int]()
	var minVal : Int = 999999
	var i : Int = 0
	while (i < size) {
		// Remove out of range elements
		if (deq.count > 0 && deq.first! <= i - k) {
			deq.removeFirst()
		}
		// Remove smaller values at left.
		while (deq.count > 0 && arr[deq.last!] <= arr[i]) {                    
			deq.removeLast()
		}
		deq.append(i)
		// window of size k
		if (i >= (k - 1) && minVal > arr[deq.first!]) {
			minVal = arr[deq.first!]
		}
		i += 1
	}
	
	print("Min of max is :: " + String(minVal))
	return minVal
}

// Testing code
func main4() {
	var arr : [Int] = [11, 2, 75, 92, 59, 90, 55]
	_ = minOfMaxSlidingWindows( &arr,7,3)
}

// Min of max is :: 75

func maxOfMinSlidingWindows(_ arr : inout [Int], _ size : Int, _ k : Int) {
	var deq : [Int] = [Int]()
	var maxVal : Int = -999999
	var i : Int = 0
	while (i < size) {
		// Remove out of range elements
		if (deq.count > 0 && deq.first! <= i - k) {
			deq.removeFirst()
		}
		// Remove smaller values at left.
		while (deq.count > 0 && arr[deq.last!] >= arr[i]) {                    
			deq.removeLast()
		}
		deq.append(i)
		// window of size k
		if (i >= (k - 1) && maxVal < arr[deq.first!]) {
			maxVal = arr[deq.first!]
		}
		i += 1
	}
	print("Max of min is :: " + String(maxVal))
}

// Testing code
func main5() {
	var arr : [Int] = [11, 2, 75, 92, 59, 90, 55]
	maxOfMinSlidingWindows( &arr,7,3)
}

// Max of min is :: 59

func firstNegSlidingWindows(_ arr : inout [Int], _ size : Int, _ k : Int) {
	var que : [Int] = [Int]()
	var i : Int = 0
	while (i < size) {
		// Remove out of range elements
		if (que.count > 0 && que.first! <= i - k) {
			que.removeFirst()
		}
		if (arr[i] < 0) {
			que.append(i)
		}
		// window of size k
		if (i >= (k - 1)) {
			if (que.count > 0) {
				print(String(arr[que.first!]) ,terminator: " ")
			}
			else
			{
				print("NAN",terminator: "")
			}
		}
		i += 1
	}
}

// Testing code
func main6() {
	var arr : [Int] = [3, -2, -6, 10, -14, 50, 14, 21]
	firstNegSlidingWindows( &arr,8,3)
}

// -2 -2 -6 -14 -14 NAN

func rottenFruitUtil(_ arr : inout [[Int]], _ maxCol : Int, _ maxRow : Int, _ currCol : Int, _ currRow : Int, _ traversed : inout [[Int]], _ day : Int) {
	let dir : [[Int]] = [[-1, 0], [1, 0], [0, -1], [0, 1]]
	var x : Int, y : Int, i : Int = 0
	while (i < 4) {
		x = currCol + dir[i][0]
		y = currRow + dir[i][1]
		if (x >= 0 && x < maxCol && y >= 0 && y < maxRow && traversed[x][y] > day + 1 && arr[x][y] == 1) {
			traversed[x][y] = day + 1
			rottenFruitUtil( &arr,maxCol,maxRow,x,y, &traversed,day + 1)
		}
		i += 1
	}
}

func rottenFruit(_ arr : inout [[Int]], _ maxCol : Int, _ maxRow : Int) -> Int {
	var traversed : [[Int]] = Array(repeating: Array(repeating: 0, count: maxRow), count: maxCol)
	var i : Int = 0
	while (i < maxCol) {
		var j : Int = 0
		while (j < maxRow) {
			traversed[i][j] = Int.max
			j += 1
		}
		
		i += 1
	}
	
	i = 0
	while (i < maxCol) {
		var j : Int = 0
		while (j < maxRow) {
			if (arr[i][j] == 2) {
				traversed[i][j] = 0
				rottenFruitUtil( &arr,maxCol,maxRow,i,j, &traversed,0)
			}
			j += 1
		}
		i += 1
	}
	
	var maxDay : Int = 0
	i = 0
	while (i < maxCol) {
		var j : Int = 0
		while (j < maxRow) {
			if (arr[i][j] == 1) {
				if (traversed[i][j] == Int.max)
				{
					return -1
				}
				if (maxDay < traversed[i][j])
				{
					maxDay = traversed[i][j]
				}
			}
			j += 1
		}
		i += 1
	}
	return maxDay
}

class Fruit {
	var x : Int
	var y : Int
	var day : Int

	init(_ a : Int, _ b : Int, _ d : Int) {
		self.x = a
		self.y = b
		self.day = d
	}
}

func rottenFruit2(_ arr : inout [[Int]], _ maxCol : Int, _ maxRow : Int) -> Int {
	var traversed : [[Bool]] = Array(repeating: Array(repeating: false, count: maxRow), count: maxCol)
	let dir : [[Int]] = [[-1, 0], [1, 0], [0, -1], [0, 1]]
	var que : [Fruit] = [Fruit]()
	var i : Int = 0
	while (i < maxCol) {
		var j : Int = 0
		while (j < maxRow) {
			traversed[i][j] = false
			if (arr[i][j] == 2) {
				que.append(Fruit(i, j, 0))
				traversed[i][j] = true
			}
			j += 1
		}
		i += 1
	}

	var mx : Int = 0
	var x : Int
	var y : Int
	var day : Int
	var temp : Fruit?
	while (!que.isEmpty) {
		temp = que.removeFirst()
		var i : Int = 0
		while (i < 4) {
			x = temp!.x + dir[i][0]
			y = temp!.y + dir[i][1]
			day = temp!.day + 1
			if (x >= 0 && x < maxCol && y >= 0 && y < maxRow && arr[x][y] != 0 && traversed[x][y] == false) {
				que.append(Fruit(x, y, day))
				mx = max(mx,day)
				traversed[x][y] = true
			}
			i += 1
		}
	}
	i = 0
	while (i < maxCol) {
		var j : Int = 0
		while (j < maxRow) {
			if (arr[i][j] == 1 && traversed[i][j] == false) {
				return -1
			}
			j += 1
		}
		i += 1
	}
	return mx
}

// Testing code
func main7() {
	var arr : [[Int]] = [[1, 0, 1, 1, 0], [2, 1, 0, 1, 0], [0, 0, 0, 2, 1], [0, 2, 0, 0, 1], [1, 1, 0, 0, 1]]
	print("rottenFruit : " + String(rottenFruit( &arr,5,5)))
	print("rottenFruit : " + String(rottenFruit2( &arr,5,5)))
}

// rottenFruit : 3
// rottenFruit : 3

func stepsOfKnightUtil(_ size : Int, _ currCol : Int, _ currRow : Int, _ traversed : inout [[Int]], _ dist : Int) {
	let dir : [[Int]] = [[-2, -1], [-2, 1], [2, -1], [2, 1], [-1, -2], [1, -2], [-1, 2], [1, 2]]
	var x : Int, y : Int, i : Int = 0
	while (i < 8) {
		x = currCol + dir[i][0]
		y = currRow + dir[i][1]
		if (x >= 0 && x < size && y >= 0 && y < size && traversed[x][y] > dist + 1) {
			traversed[x][y] = dist + 1
			stepsOfKnightUtil(size,x,y, &traversed,dist + 1)
		}
		i += 1
	}
}

func stepsOfKnight(_ size : Int, _ srcX : Int, _ srcY : Int, _ dstX : Int, _ dstY : Int) -> Int {
	var traversed : [[Int]] = Array(repeating: Array(repeating: 0, count: size), count: size)
	var i : Int = 0
	while (i < size) {
		var j : Int = 0
		while (j < size) {
			traversed[i][j] = Int.max
			j += 1
		}
		i += 1
	}
	traversed[srcX - 1][srcY - 1] = 0
	stepsOfKnightUtil(size,srcX - 1,srcY - 1, &traversed,0)
	return traversed[dstX - 1][dstY - 1]
}

class Knight {
	var x : Int
	var y : Int
	var cost : Int
	init(_ a : Int, _ b : Int, _ c : Int) {
		self.x = a
		self.y = b
		self.cost = c
	}
}

func stepsOfKnight2(_ size : Int, _ srcX : Int, _ srcY : Int, _ dstX : Int, _ dstY : Int) -> Int {
	var traversed : [[Int]] = Array(repeating: Array(repeating: 0, count: size), count: size)
	let dir : [[Int]] = [[-2, -1], [-2, 1], [2, -1], [2, 1], [-1, -2], [1, -2], [-1, 2], [1, 2]]
	var que : [Knight] = [Knight]()
	var i : Int = 0
	while (i < size) {
		var j : Int = 0
		while (j < size) {
			traversed[i][j] = Int.max
			j += 1
		}
		i += 1
	}
	
	que.append(Knight(srcX - 1, srcY - 1, 0))
	traversed[srcX - 1][srcY - 1] = 0
	var x : Int
	var y : Int
	var cost : Int
	var temp : Knight?
	while (!que.isEmpty) {
		temp = que.removeFirst()
		i = 0
		while (i < 8) {
			x = temp!.x + dir[i][0]
			y = temp!.y + dir[i][1]
			cost = temp!.cost + 1
			if (x >= 0 && x < size && y >= 0 && y < size && traversed[x][y] > cost) {
				que.append(Knight(x, y, cost))
				traversed[x][y] = cost
			}
			i += 1
		}
	}
	return traversed[dstX - 1][dstY - 1]
}

// Testing code
func main8() {
	print(stepsOfKnight(20,10,10,20,20))
	print(stepsOfKnight2(20,10,10,20,20))
}

// 8
// 8

func distNearestFillUtil(_ arr : inout [[Int]], _ maxCol : Int, _ maxRow : Int, _ currCol : Int, _ currRow : Int, _ traversed : inout [[Int]], _ dist : Int) {
	var x : Int, y : Int
	let dir : [[Int]] = [[-1, 0], [1, 0], [0, -1], [0, 1]]
	var i : Int = 0
	while (i < 4) {
		x = currCol + dir[i][0]
		y = currRow + dir[i][1]
		if (x >= 0 && x < maxCol && y >= 0 && y < maxRow && traversed[x][y] > dist + 1) {
			traversed[x][y] = dist + 1
			distNearestFillUtil( &arr,maxCol,maxRow,x,y, &traversed,dist + 1)
		}
		i += 1
	}
}

func distNearestFill(_ arr : inout [[Int]], _ maxCol : Int, _ maxRow : Int) {
	var traversed : [[Int]] = Array(repeating: Array(repeating: 0, count: maxRow), count: maxCol)
	var i : Int = 0
	while (i < maxCol) {
		var j : Int = 0
		while (j < maxRow) {
			traversed[i][j] = Int.max
			j += 1
		}
		i += 1
	}
	
	i = 0
	while (i < maxCol) {
		var j : Int = 0
		while (j < maxRow) {
			if (arr[i][j] == 1) {
				traversed[i][j] = 0
				distNearestFillUtil( &arr,maxCol,maxRow,i,j, &traversed,0)
			}
			j += 1
		}
		i += 1
	}
	
	i = 0
	while (i < maxCol) {
		var j : Int = 0
		while (j < maxRow) {
			print(String(traversed[i][j]) ,terminator: " ")
			j += 1
		}
		print()
		i += 1
	}
}

class Node {
	var x : Int
	var y : Int
	var dist : Int
	init(_ a : Int, _ b : Int, _ d : Int) {
		self.x = a
		self.y = b
		self.dist = d
	}
}

func distNearestFill2(_ arr : inout [[Int]], _ maxCol : Int, _ maxRow : Int) {
	var traversed : [[Int]] = Array(repeating: Array(repeating: 0, count: maxRow), count: maxCol)
	let dir : [[Int]] = [[-1, 0], [1, 0], [0, -1], [0, 1]]
	var que : [Node] = [Node]()
	var i : Int = 0
	while (i < maxCol) {
		var j : Int = 0
		while (j < maxRow) {
			traversed[i][j] = Int.max
			if (arr[i][j] == 1) {
				que.append(Node(i, j, 0))
				traversed[i][j] = 0
			}
			j += 1
		}
		i += 1
	}
	
	var x : Int, y : Int, dist : Int
	var temp : Node?
	while (!que.isEmpty) {
		temp = que.removeFirst()
		i = 0
		while (i < 4) {
			x = temp!.x + dir[i][0]
			y = temp!.y + dir[i][1]
			dist = temp!.dist + 1
			if (x >= 0 && x < maxCol && y >= 0 && y < maxRow && traversed[x][y] > dist) {
				que.append(Node(x, y, dist))
				traversed[x][y] = dist
			}
			i += 1
		}
	}

	i = 0
	while (i < maxCol) {
		var j : Int = 0
		while (j < maxRow) {
			print(String(traversed[i][j]) ,terminator: " ")
			j += 1
		}
		print()
		i += 1
	}
}

// Testing code
func main9() {
	var arr : [[Int]] = [[1, 0, 1, 1, 0], [1, 1, 0, 1, 0], [0, 0, 0, 0, 1], [0, 0, 0, 0, 1], [0, 0, 0, 0, 1]]
	distNearestFill( &arr,5,5)
	distNearestFill2( &arr,5,5)
}

// 0 1 0 0 1 
// 0 0 1 0 1 
// 1 1 2 1 0 
// 2 2 2 1 0 
// 3 3 2 1 0

func findLargestIslandUtil(_ arr : inout [[Int]], _ maxCol : Int, _ maxRow : Int, _ currCol : Int, _ currRow : Int, _ traversed : inout [[Bool]]) -> Int {
	let dir : [[Int]] = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
	var x : Int, y : Int, sum : Int = 1
	var i : Int = 0
	while (i < 8) {
		x = currCol + dir[i][0]
		y = currRow + dir[i][1]
		if (x >= 0 && x < maxCol && y >= 0 && y < maxRow && traversed[x][y] == false && arr[x][y] == 1) {
			traversed[x][y] = true
			sum += findLargestIslandUtil( &arr,maxCol,maxRow,x,y, &traversed)
		}
		i += 1
	}
	return sum
}

func findLargestIsland(_ arr : inout [[Int]], _ maxCol : Int, _ maxRow : Int) -> Int {
	var maxVal : Int = 0, currVal : Int = 0
	var traversed : [[Bool]] = Array(repeating: Array(repeating: false, count: maxRow), count: maxCol)
	var i : Int = 0
	while (i < maxCol) {
		var j : Int = 0
		while (j < maxRow) {
			traversed[i][j] = false
			j += 1
		}
		i += 1
	}
	
	i = 0
	while (i < maxCol) {
		var j : Int = 0
		while (j < maxRow) {
			if (arr[i][j] == 1) {
				traversed[i][j] = true
				currVal = findLargestIslandUtil( &arr,maxCol,maxRow,i,j, &traversed)
				if (currVal > maxVal)
				{
					maxVal = currVal
				}
			}
			j += 1
		}
		i += 1
	}
	return maxVal
}

// Testing code
func main10() {
	var arr : [[Int]] = [[1, 0, 1, 1, 0], [1, 0, 0, 1, 0], [0, 1, 1, 1, 1], [0, 1, 0, 0, 0], [1, 1, 0, 0, 1]]
	print("Largest Island : " + String(findLargestIsland( &arr,5,5)))
}

// Largest Island : 12

func reverseStack(_ stk : inout [Int]) {
	var que : [Int] = [Int]()
	while (!stk.isEmpty) {
		que.append(stk.removeLast())
	}
	while (!que.isEmpty) {
		stk.append(que.removeFirst())
	}
}

func reverseQueue(_ que : inout [Int]) {
	var stk :  [Int] =  [Int]()
	while (!que.isEmpty) {
		stk.append(que.removeFirst())
	}
	while (!stk.isEmpty) {
		que.append(stk.removeLast())
	}
}

// Testing code
func main11() {
	var stk :  [Int] =  [Int]()
	var i : Int = 0
	while (i < 5) {
		stk.append(i)
		i += 1
	}
	
	print(stk)
	reverseStack(&stk)
	print(stk)

	var que : [Int] = [Int]()
	i = 0
	while (i < 5) {
		que.append(i)
		i += 1
	}
	
	print(que)
	reverseQueue(&que)
	print(que)
}

// [0, 1, 2, 3, 4]
// [4, 3, 2, 1, 0]
// [0, 1, 2, 3, 4]
// [4, 3, 2, 1, 0]

func josephus(_ n : Int, _ k : Int) -> Int {
	var que : [Int] = [Int]()
	var i : Int = 0
	while (i < n) {
		que.append(i + 1)
		i += 1
	}
	
	while (que.count > 1) {
		i = 0
		while (i < k - 1) {
			que.append(que.removeFirst())
			i += 1
		}
		que.removeFirst()
	}
	return que.first!
}

// Testing code
func main12() {
	print("Position : " + String(josephus(11,5)))
}

// Position : 8

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
