import Foundation

func andEx(_ a : Int, _ b : Int) -> Int {
    return a & b
}
func orEx(_ a : Int, _ b : Int) -> Int {
    return a | b
}
func xorEx(_ a : Int, _ b : Int) -> Int {
    return a ^ b
}
func leftShiftEx(_ a : Int) -> Int { // multiply by 2
    return a << 1
}
func rightShiftEx(_ a : Int) -> Int { // divide by 2
    
    return a >> 1
}
func bitReversalEx(_ a : Int) -> Int {
    return ~a
}
func twoComplementEx(_ a : Int) -> Int {
    return -a
}
func kthBitCheck(_ a : Int, _ k : Int) -> Bool
{
    return (a & 1 << (k - 1)) > 0
}
func kthBitSet(_ a : Int, _ k : Int) -> Int {
    return (a | 1 << (k - 1))
}
func kthBitReset(_ a : Int, _ k : Int) -> Int {
    return (a & ~(1 << (k - 1)))
}
func kthBitToggle(_ a : Int, _ k : Int) -> Int {
    return (a ^ (1 << (k - 1)))
}
func rightMostBit(_ a : Int) -> Int {
    return a & -a
}
func resetRightMostBit(_ a : Int) -> Int {
    return a & (a - 1)
}
func isPowerOf2(_ a : Int) -> Bool
{
    if ((a & (a - 1)) == 0) {
        return true
    }
    else
    {
        return false
    }
}

func countBits(_ a : Int) -> Int {
    var a : Int = a
    var count : Int = 0
    while (a > 0) {
        count += 1
        a = a & (a - 1)
    }
    return count
}

let a : Int = 4
let b : Int = 8
print(andEx(a,b))
print(orEx(a,b))
print(xorEx(a,b))
print(leftShiftEx(a)) // multiply by 2
print(rightShiftEx(a)) // divide by 2
print(bitReversalEx(a))
print(twoComplementEx(a))
print(kthBitCheck(a,3))
print(kthBitSet(a,2))
print(kthBitReset(a,3))
print(kthBitToggle(a,3))
print(rightMostBit(a))
print(resetRightMostBit(a))
print(isPowerOf2(a))
var i : Int = 0
while (i < 10) {
    print(String(i) + " bit count : " + String(countBits(i)))
    i += 1
}