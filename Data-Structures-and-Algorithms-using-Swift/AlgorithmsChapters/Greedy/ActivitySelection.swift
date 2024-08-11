import Foundation

// Prints a maximum set of activities that can be done by a
// single person performing one task at a time.
// s[] is an array that contains start time of all activities
// f[] is an array that contains finish time of all activities

class Activity {
	var start : Int
	var stop : Int

	init(_ s : Int, _ f : Int) {
		self.start = s
		self.stop = f
	}
}

func compareActivity(_ s1 : Activity?, _ s2 : Activity?) -> Bool {
	return s1!.stop < s2!.stop
}

func maxActivities(_ s : inout [Int], _ f : inout [Int], _ n : Int) {
	var act : [Activity?] = Array(repeating: nil, count: n)
	var i : Int = 0
	while (i < n) {
		act[i] = Activity(s[i], f[i])
		i += 1
	}
	act = act.sorted(by: compareActivity) // sort according to finish time.
	
	i = 0
	// The first activity at index 0 is always gets selected.
	print("Activities are : (" + String(act[i]!.start) + "," + String(act[i]!.stop) + ")",terminator: "")
	var j : Int = 1
	while (j < n) {
		// Find next activity whose start time is greater than or equal
		// to the finish time of previous activity.
		if (act[j]!.start >= act[i]!.stop) {
			print(", (" + String(act[j]!.start) + "," + String(act[j]!.stop) + ")",terminator: "")
			i = j
		}
		j += 1
	}
}

// Testing code.
var s : [Int] = [1, 5, 0, 3, 5, 6, 8]
var f : [Int] = [2, 6, 5, 4, 9, 7, 9]
let n : Int = s.count
maxActivities( &s, &f,n)

/*
Activities are : (1,2), (3,4), (5,6), (6,7), (8,9)
*/