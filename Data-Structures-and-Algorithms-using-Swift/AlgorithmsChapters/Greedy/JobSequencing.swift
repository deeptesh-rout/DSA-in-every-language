import Foundation

class Job : Comparable {
    var id : Character
    var deadline : Int
    var profit : Int

    init(_ id : Character, _ deadline : Int, _ profit : Int) {
        self.id = id
        self.deadline = deadline
        self.profit = profit
    }

    static func < (lhs: Job, rhs: Job) -> Bool {
        return lhs.profit < rhs.profit
    }

    static func > (lhs: Job, rhs: Job) -> Bool {
        return lhs.profit > rhs.profit
    }

    static func == (lhs: Job, rhs: Job) -> Bool {
        return lhs.profit == rhs.profit
    }
}

func JobSequencing(_ ids : inout [Character], _ deadlines : inout [Int], _ profits : inout [Int], _ n : Int) {
    var maxDL = deadlines[0]
    var i : Int = 1
    while (i < n) {
        maxDL = max(maxDL, deadlines[i])
        i += 1
    }
    
    var jobs : [Job] = []
    i = 0
    while (i < n) {
        jobs.append(Job(ids[i], deadlines[i], profits[i]))
        i += 1
    }
    
    jobs.sort(by: >)// Decreasing order.
    
    var result : [Bool] = Array(repeating: false, count: maxDL)
    var answer : [Character] = Array(repeating: "0", count: maxDL)
    var profit : Int = 0

    i = 0 // Iterate through all given jobs
    while (i < n) {
        var j : Int = jobs[i].deadline - 1
        while (j >= 0) {
            if (result[j] == false) {
                result[j] = true
                answer[j] = jobs[i].id
                profit += jobs[i].profit
                break
            }
            j -= 1
        }
        i += 1
    }
    
    print("Profit is :: " + String(profit))
    print("Jobs selected are ::", terminator: " ")
    i = 0
    while (i < maxDL) {
        if (answer[i] != "0") {
            print(String(answer[i]), terminator: " ")
        }
        i += 1
    }
}

// Testing code.
var id : [Character] = ["a", "b", "c", "d", "e"]
var deadline : [Int] = [3, 1, 2, 4, 4]
var profit : [Int] = [50, 40, 27, 31, 30]
JobSequencing(&id, &deadline, &profit, 5)
/* 
Profit is :: 151
Jobs selected are :: b e a d 
 */