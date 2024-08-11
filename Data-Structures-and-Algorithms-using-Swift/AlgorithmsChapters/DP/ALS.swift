import Foundation

func fastestWayBU2(_ a : inout [[Int]], _ t : inout [[Int]], _ e : inout [Int], _ x : inout [Int], _ n : Int) -> Int {
	var f1 : [Int] = Array(repeating: 0, count: n)
	var f2 : [Int] = Array(repeating: 0, count: n)
	
	// Time taken to leave first station.
	f1[0] = e[0] + a[0][0]
	f2[0] = e[1] + a[1][0]

	// Fill the tables f1[] and f2[] using
	// bottom up approach.
	var i : Int = 1
	while (i < n) {
		f1[i] = min(f1[i - 1] + a[0][i],f2[i - 1] + t[1][i - 1] + a[0][i])
		f2[i] = min(f2[i - 1] + a[1][i],f1[i - 1] + t[0][i - 1] + a[1][i])
		i += 1
	}
	
	// Consider exit times and return minimum.
	return min(f1[n - 1] + x[0],f2[n - 1] + x[1])
}

func fastestWayBU(_ a : inout [[Int]], _ t : inout [[Int]], _ e : inout [Int], _ x : inout [Int], _ n : Int) -> Int {
	var f : [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: 2)
	
	// Time taken to leave first station.
	f[0][0] = e[0] + a[0][0]
	f[1][0] = e[1] + a[1][0]

	// Fill the tables f1[] and f2[] using
	// bottom up approach.
	var i : Int = 1
	while (i < n) {
		f[0][i] = min(f[0][i - 1] + a[0][i],f[1][i - 1] + t[1][i - 1] + a[0][i])
		f[1][i] = min(f[1][i - 1] + a[1][i],f[0][i - 1] + t[0][i - 1] + a[1][i])
		i += 1
	}
	
	// Consider exit times and return minimum.
	return min(f[0][n - 1] + x[0],f[1][n - 1] + x[1])
}

func fastestWayTD(_ a : inout [[Int]], _ t : inout [[Int]], _ e : inout [Int], _ x : inout [Int], _ n : Int) -> Int {
	var f : [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: 2)
	
	// Time taken to leave first station.
	f[0][0] = e[0] + a[0][0]
	f[1][0] = e[1] + a[1][0]
	
	fastestWayTD( &f, &a, &t,n - 1)
	return min(f[0][n - 1] + x[0],f[1][n - 1] + x[1])
}

func fastestWayTD(_ f : inout [[Int]], _ a : inout [[Int]], _ t : inout [[Int]], _ i : Int) {
	if (i == 0) {
		return
	}

	fastestWayTD( &f, &a, &t,i - 1)

	// Fill the tables f1[] and f2[] using top-down approach.
	f[0][i] = min(f[0][i - 1] + a[0][i],f[1][i - 1] + t[1][i - 1] + a[0][i])
	f[1][i] = min(f[1][i - 1] + a[1][i],f[0][i - 1] + t[0][i - 1] + a[1][i])
}

// Testing code.
var a : [[Int]] = [[7, 9, 3, 4, 8, 4],[8, 5, 6, 4, 5, 7]]
var t : [[Int]] = [[2, 3, 1, 3, 4],[2, 1, 2, 2, 1]]
var e : [Int] = [2, 4]
var x : [Int] = [3, 2]
let n : Int = 6
print(fastestWayBU2( &a, &t, &e, &x,n))
print(fastestWayBU( &a, &t, &e, &x,n))
print(fastestWayTD( &a, &t, &e, &x,n))

/*
38
38
38
*/