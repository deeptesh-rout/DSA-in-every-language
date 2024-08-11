import Foundation

class Polynomial {
    class Node {
        var coeff : Int
        var pow : Int
        var next : Node?

        init(_ c : Int, _ p : Int) {
            self.coeff = c
            self.pow = p
            self.next = nil
        }
    }

    var head : Node? = nil
    var tail : Node? = nil

    init(_ coeffs : inout [Int], _ pows : inout [Int], _ size : Int) {
        var temp : Node? = nil
		var i : Int = 0
		while (i < size) {
			temp = Node(coeffs[i], pows[i])
			if (self.head == nil) {
				self.head = temp
				self.tail = temp
			} else {
				self.tail!.next = temp
				self.tail = self.tail!.next
			}
			i += 1
		}
    }

    init() {  
    }

    func add(_ poly2 : Polynomial) -> Polynomial {
        var p1 : Node? = self.head
        var p2 : Node? = poly2.head
        var temp : Node? = nil
        let poly : Polynomial = Polynomial()

        while (p1 != nil || p2 != nil) {
            if (p1 == nil || (p2 != nil && p1!.pow < p2!.pow)) {
                temp = Node(p2!.coeff, p2!.pow)
                p2 = p2!.next
            } else if (p2 == nil || p1!.pow > p2!.pow) {
                temp = Node(p1!.coeff, p1!.pow)
                p1 = p1!.next
            } else if (p1!.pow == p2!.pow) {
                temp = Node(p1!.coeff + p2!.coeff, p1!.pow)
                p1 = p1!.next
                p2 = p2!.next
            }

            if (poly.head == nil) {
                poly.head = temp
                poly.tail = temp
            } else {
                poly.tail!.next = temp
                poly.tail = poly.tail!.next
            }
        }
        return poly
    }

    func printPoly() {
        var curr : Node? = self.head
        while (curr != nil) {
            print(String(curr!.coeff) + "x^" + String(curr!.pow),terminator: "")
            if (curr!.next != nil) {
				print(" + ",terminator: "")
            }
            curr = curr!.next
        }
        print()
    }
}

var c1 : [Int] = [6, 5, 4]
var p1 : [Int] = [2, 1, 0]
let s1 : Int = c1.count
let first : Polynomial = Polynomial(&c1, &p1, s1)
first.printPoly()

var c2 : [Int] = [3, 2, 1]
var p2 : [Int] = [3, 1, 0]
let s2 : Int = c2.count
let second : Polynomial = Polynomial(&c2, &p2, s2)
second.printPoly()

var sum : Polynomial = first.add(second)
sum.printPoly()

/* 
6x^2 + 5x^1 + 4x^0
3x^3 + 2x^1 + 1x^0
3x^3 + 6x^2 + 7x^1 + 5x^0
 */