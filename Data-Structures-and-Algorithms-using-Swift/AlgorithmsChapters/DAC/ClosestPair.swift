import Foundation

class Point {
	var x : Double
	var y : Double
	init(_ a : Double, _ b : Double) {
		x = a
		y = b
	}
}

func closestPairBF(_ arr : inout [[Double]]) -> Double {
	let n : Int = arr.count
	var dmin : Double = 999999
	var d : Double
	var i : Int = 0
	while (i < n - 1) {
		var j : Int = i + 1
		while (j < n) {
			d = Double((arr[i][0] - arr[j][0]) * (arr[i][0] - arr[j][0]) + (arr[i][1] - arr[j][1]) * (arr[i][1] - arr[j][1])).squareRoot()
			if (d < dmin) {
				dmin = d
			}
			j += 1
		}
		i += 1
	}
	return dmin
}

func distance(_ a : Point?, _ b : Point?) -> Double {
	return Double((a!.x - b!.x) * (a!.x - b!.x) + (a!.y - b!.y) * (a!.y - b!.y)).squareRoot()
}

func stripMin(_ q : inout [Point?], _ n : Int, _ d : inout Double) -> Double {
	var min : Double = d
	var i : Int = 0
	// Find the distance between all the points in the strip.
	// Array q is sorted according to the y axis coordinate.
	// The inner loop will run at most 6 times for each point.
	while (i < n) {
		var j : Int = i + 1
		while (j < n && (q[j]!.y - q[i]!.y) < min) {
			d = distance(q[i],q[j])
			if (d < min) {
				min = d
			}
			j += 1
		}
		i += 1
	}
	return min
}

func closestPairUtil(_ p : inout [Point?], _ start : Int, _ stop : Int, _ q : inout [Point?], _ n : Int) -> Double {
	if (stop - start < 1) {
		return 999999
	}
	if (stop - start == 1) {
		return distance(p[start],p[stop])
	}
	// Find the middle point
	let mid : Int = (start + stop) / 2
	let dl : Double = closestPairUtil( &p,start,mid, &q,n)
	let dr : Double = closestPairUtil( &p,mid + 1,stop, &q,n)
	var d : Double = min(dl,dr)
	// Build an array strip[] that contains points whose x axis coordinate
	// in the range p[mid]-d and p[mid]+d
	// Points are already sorted according to y axis.
	var strip : [Point?] = Array(repeating: nil, count: n)
	var j : Int = 0
	var i : Int = 0
	while (i < n) {
		if (abs(q[i]!.x - p[mid]!.x) < d) {
			strip[j] = q[i]
			j += 1
		}
		i += 1
	}
	// Find the closest points in strip and compare with d.
	return min(d, stripMin( &strip,j,&d))
}

func xComp(_ s1 : Point?, _ s2 : Point?) -> Bool {
	return (s1!.x < s2!.x)
}

func yComp(_ s1 : Point?, _ s2 : Point?) -> Bool {
	return (s1!.y < s2!.y)
}  

func closestPairDC(_ arr : inout [[Double]]) -> Double {
	let n : Int = arr.count
	var p : [Point?] = Array(repeating: nil, count: n)
	var i : Int = 0
	while (i < n) {
		p[i] = Point(arr[i][0], arr[i][1])
		i += 1
	}
	p = p.sorted(by: xComp) // Sort according to x axis.
	var q = p.map { $0 } // clone
	q = q.sorted(by: yComp) // Sort according to y axis.
	return closestPairUtil( &p,0,n - 1, &q,n)
}

// Testing code.
var arr : [[Double]] = [[648, 896], [269, 879], [250, 922], [453, 347], [213, 17]]
print("Smallest distance is:" + String(closestPairBF( &arr)))
print("Smallest distance is:" + String(closestPairDC( &arr)))

/*
Smallest distance is:47.01063709417264
Smallest distance is:47.01063709417264
*/