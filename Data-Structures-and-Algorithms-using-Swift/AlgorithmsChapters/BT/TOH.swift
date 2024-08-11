import Foundation
// Towers Of Hanoi problem.
func tohUtil(_ num : Int, _ from : Character, _ to : Character, _ temp : Character) {
	if (num < 1) {
		return
	}
	tohUtil(num - 1, from, temp, to)
	print("Move disk " + String(num) + " from peg " + String(from) + " to peg " + String(to))
	tohUtil(num - 1, temp, to, from)
}

func toh(_ num : Int) {
	print("The sequence of moves involved in the Tower of Hanoi are :")
	tohUtil(num,"A", "C", "B")
}

// Testing code.
toh(3)

/*
The sequence of moves involved in the Tower of Hanoi are :
Move disk 1 from peg A to peg C
Move disk 2 from peg A to peg B
Move disk 1 from peg C to peg B
Move disk 3 from peg A to peg C
Move disk 1 from peg B to peg A
Move disk 2 from peg B to peg C
Move disk 1 from peg A to peg C
*/