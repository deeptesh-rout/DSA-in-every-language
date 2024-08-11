func main1() {
	let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
	var sum = 0
	for number in numbers {
		sum += number
	}
	print("Sum is :: \(sum)")
}

func main2() {
	let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
	var count = 0
	for _ in numbers {
		count += 1
	}
	print("Count is :: \(count)")
}

func main3() {
	let numbers : [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
	var sum : Int = 0
	var i = 0
	let n = numbers.count
	while i < n {
		sum += numbers[i]
		i+=1
	}
	print("Sum is :: \(sum)")
}

func main4() {
	let numbers : [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
	var sum : Int = 0
	var i = 0
	let n = numbers.count
	repeat {
		sum += numbers[i]
		i+=1
	} while i < n
	print("Sum is :: \(sum)")
}

main2()
main3()
main4()
main1()
