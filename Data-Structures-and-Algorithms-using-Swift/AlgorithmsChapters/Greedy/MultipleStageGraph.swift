import Foundation

var INF : Int = 999

// Returns shortest distance from 0 to N-1.
func shortestDist(_ graph : inout [[Int]], _ n : Int) -> Int {
    var dist : [Int] = Array(repeating: INF, count: n)
    var path : [Int] = Array(repeating: 0, count: n)
    var value : Int
    path[0] = -1
    dist[0] = 0
    
    // Calculating shortest path for the nodes
    var i : Int = 0
    while (i < n) {
        // Check all the other nodes
        var j : Int = i
        while (j < n) {
            // Reject if no edge exists
            if (graph[i][j] == INF) {
                j += 1
                continue
            }
            value = graph[i][j] + dist[i]
            if (dist[j] > value) {
                dist[j] = value
                path[j] = i
            }
            j += 1
        }
        i += 1
    }
    value = n - 1
    while (value != -1) {
        print(String(value),terminator: " ")
        value = path[value]
    }
    print()
    return dist[n - 1]
}

// Testing code.
// Graph stored in the form of an adjacency Matrix
var graph : [[Int]] = 
[[INF, 1, 2, 5, INF, INF, INF, INF],
 [INF, INF, INF, INF, 4, 11, INF, INF],
 [INF, INF, INF, INF, 9, 5, 16, INF],
 [INF, INF, INF, INF, INF, INF, 2, INF],
 [INF, INF, INF, INF, INF, INF, INF, 18],
 [INF, INF, INF, INF, INF, INF, INF, 13],
 [INF, INF, INF, INF, INF, INF, INF, 2],
 [INF, INF, INF, INF, INF, INF, INF, INF]]
print(shortestDist( &graph,8))

/*
7 6 3 0 
9
*/
