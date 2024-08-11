import Foundation
// Also known as Activity Selection Weighted.
class Job {
	var start : Int
	var stop : Int
	var value : Int

	init(_ s : Int, _ f : Int, _ v : Int) {
		self.start = s
		self.stop = f
		self.value = v
	}
}

func jobCompare(_ j1 : Job?, _ j2 : Job?) -> Bool {
	return j1!.stop < j2!.stop
}

func maxValueJobUtil(_ arr : inout [Job?], _ n : Int) -> Int {
	// Base case
	if (n == 1) {
		return arr[0]!.value
	}
	// Find Value when current job is included
	var incl : Int = arr[n - 1]!.value
	var j : Int = n - 1
	while (j >= 0) {
		if (arr[j]!.stop <= arr[n - 1]!.start) {
			incl += maxValueJobUtil( &arr,j + 1)
			break
		}
		j -= 1
	}
	// Find Value when current job is excluded
	let excl : Int = maxValueJobUtil( &arr,n - 1)
	return max(incl,excl)
}

func maxValueJobs(_ s : inout [Int], _ f : inout [Int], _ v : inout [Int], _ n : Int) -> Int {
	var act : [Job?] = Array(repeating: nil, count: n)
	var i : Int = 0
	while (i < n) {
		act[i] = Job(s[i], f[i], v[i])
		i += 1
	}
	
	act = act.sorted(by:jobCompare) // sort according to finish time.
	return maxValueJobUtil( &act,n)
}

func maxValueJobUtilTD(_ dp : inout [Int], _ arr : inout [Job?], _ n : Int) -> Int {
	// Base case
	if (n == 0) {
		return 0
	}
	if (dp[n - 1] != 0) {
		return dp[n - 1]
	}
	// Find Value when current job is included
	var incl : Int = arr[n - 1]!.value
	var j : Int = n - 2
	while (j >= 0) {
		if (arr[j]!.stop <= arr[n - 1]!.start) {
			incl += maxValueJobUtilTD( &dp, &arr,j + 1)
			break
		}
		j -= 1
	}
	// Find Value when current job is excluded
	let excl : Int = maxValueJobUtilTD( &dp, &arr,n - 1)
	dp[n - 1] = max(incl,excl)
	return dp[n - 1]
}

func maxValueJobsTD(_ s : inout [Int], _ f : inout [Int], _ v : inout [Int], _ n : Int) -> Int {
	var act : [Job?] = Array(repeating: nil, count: n)
	var i : Int = 0
	while (i < n) {
		act[i] = Job(s[i], f[i], v[i])
		i += 1
	}
	act = act.sorted(by:jobCompare)
	// sort according to finish time.
	var dp : [Int] = Array(repeating: 0, count: n)
	return maxValueJobUtilTD( &dp, &act,n)
}
func maxValueJobsBU(_ s : inout [Int], _ f : inout [Int], _ v : inout [Int], _ n : Int) -> Int {
	var act : [Job?] = Array(repeating: nil, count: n)
	var i : Int = 0
	while (i < n) {
		act[i] = Job(s[i], f[i], v[i])
		i += 1
	}
	
	act = act.sorted(by:jobCompare)

	// sort according to finish time.
	var dp : [Int] = Array(repeating: 0, count: n)
	dp[0] = act[0]!.value

	i = 1
	while (i < n) {
		var incl : Int = act[i]!.value
		var j : Int = i - 1
		while (j >= 0) {
			if (act[j]!.stop <= act[i]!.start) {
				incl += dp[j]
				break
			}
			j -= 1
		}
		
		dp[i] = max(incl,dp[i - 1])
		i += 1
	}
	return dp[n - 1]
}

// Testing code.
var start : [Int] = [1, 5, 0, 3, 5, 6, 8]
var finish : [Int] = [2, 6, 5, 4, 9, 7, 9]
var value : [Int] = [2, 2, 4, 3, 10, 2, 8]
let n : Int = start.count
print(maxValueJobs( &start, &finish, &value,n))
print(maxValueJobsTD( &start, &finish, &value,n))
print(maxValueJobsBU( &start, &finish, &value,n))
/* 
17
17
17
 */
