class LNode {
    public value: number;
    public next: LNode | null;

    public constructor(v: number, n: LNode | null = null) {
        this.value = v;
        this.next = n;
    }
}

const ErrorValue = 2147483647;

class LinkedList {
    head: LNode | null;
    length: number = 0;

    constructor() {
        this.head = null;
    }

    public size(): number {
        return this.length;
    }

    public isEmpty(): boolean {
        return this.length === 0;
    }

    public peek(): number {
        if (this.isEmpty())
            throw new Error("EmptyListException");
        return this.head!.value;
    }

public addHead(value: number): void {
    this.head = new LNode(value, this.head);
    this.length++;
}

public addTail(value: number): void {
    let newNode: LNode = new LNode(value, null);
    if (this.head == null) {
        this.head = newNode;
    } else {
        let curr: LNode = this.head;
        while (curr.next != null) {
            curr = curr.next;
        }
        curr.next = newNode;
    }
    this.length++;
}

public removeHead(): number {
    if (this.isEmpty())
        throw new Error("EmptyListException");

    let value: number = this.head!.value;
    this.head = this.head!.next;
    this.length--;
    return value;
}


public find(data: number): boolean {
    let temp: LNode | null = this.head;
    while (temp !== null) {
        if (temp.value === data)
            return true;
        temp = temp.next;
    }
    return false;
}

public deleteNode(delValue: number): boolean {
    if (this.isEmpty())
        return false;

    if (delValue === this.head.value) {
        this.head = this.head.next;
        this.length--;
        return true;
    }

    let temp: LNode | null = this.head;
    while (temp.next !== null) {
        if (temp.next.value === delValue) {
            temp.next = temp.next.next;
            this.length--;
            return true;
        }
        temp = temp.next;
    }
    return false;
}

public deleteNodes(delValue: number): void {
    let currNode: LNode | null = this.head;
    let nextNode: LNode | null;

    while (currNode !== null && currNode.value === delValue) {
        this.head = currNode.next;
        currNode = this.head;
    }

    while (currNode !== null) {
        nextNode = currNode.next;
        if (nextNode !== null && nextNode.value === delValue) {
            currNode.next = nextNode.next;
        } else {
            currNode = nextNode;
        }
    }
}

private reverseRecurseUtil(currentNode: LNode | null, nextNode: LNode | null): LNode | null {
    if (currentNode === null)
        return null;

    if (currentNode.next === null) {
        currentNode.next = nextNode;
        return currentNode;
    }

    const ret: LNode | null = this.reverseRecurseUtil(currentNode.next, currentNode);
    currentNode.next = nextNode;
    return ret;
}

public reverseRecurse(): void {
    this.head = this.reverseRecurseUtil(this.head, null);
}

public reverse(): void {
    let curr: LNode | null = this.head;
    let prev: LNode | null = null;
    let next: LNode | null = null;

    while (curr !== null) {
        next = curr.next;
        curr.next = prev;
        prev = curr;
        curr = next;
    }

    this.head = prev;
}

public copyListReversed(): LinkedList {
    let tempNode: LNode | null = null;
    let tempNode2: LNode | null = null;
    let curr: LNode | null = this.head;

    while (curr !== null) {
        tempNode2 = new LNode(curr.value, tempNode);
        curr = curr.next;
        tempNode = tempNode2;
    }

    const ll2: LinkedList = new LinkedList();
    ll2.head = tempNode;
    return ll2;
}

public copyList(): LinkedList {
    if (this.head === null)
        return new LinkedList();

    let headNode: LNode = new LNode(this.head.value, null);
    let tailNode: LNode = headNode;
    let curr: LNode | null = this.head.next;

    while (curr !== null) {
        const tempNode: LNode = new LNode(curr.value, null);
        tailNode.next = tempNode;
        tailNode = tempNode;
        curr = curr.next;
    }

    const ll2: LinkedList = new LinkedList();
    ll2.head = headNode;
    return ll2;
}

public compareList(ll: LinkedList): boolean {
    return this.compareListUtil(this.head, ll.head);
}

private compareListUtil(head1: LNode | null, head2: LNode | null): boolean {
    if (head1 === null && head2 === null)
        return true;
    else if (head1 === null || head2 === null || head1.value !== head2.value)
        return false;
    else
        return this.compareListUtil(head1.next, head2.next);
}

public compareList2(ll2: LinkedList): boolean {
    let head1: LNode | null = this.head;
    let head2: LNode | null = ll2.head;

    while (head1 !== null && head2 !== null) {
        if (head1.value !== head2.value)
            return false;
        head1 = head1.next;
        head2 = head2.next;
    }

    if (head1 === null && head2 === null)
        return true;
    return false;
}

public findLength(): number {
    let curr: LNode | null = this.head;
    let count: number = 0;
    while (curr !== null) {
        count++;
        curr = curr.next;
    }
    return count;
}


public nthNodeFromBeginning(index: number): number {
    if (index > this.size() || index < 1)
        throw new Error('TooFewNodes')
    let count: number = 0;
    let curr: LNode | null = this.head;
    while (curr !== null && count < index - 1) {
        count++;
        curr = curr.next;
    }
    if (curr === null)
        return ErrorValue;
    return curr.value;
}

public nthNodeFromEnd(index: number): number {
    let size: number = this.findLength();
    if (size !== 0 && size < index) {
        throw new Error('TooFewNodes')
    }
    let startIndex: number = size - index;
    return this.nthNodeFromBeginning(startIndex + 1);
}

public nthNodeFromEnd2(index: number): number {
    let count: number = 1;
    let forward: LNode | null = this.head;
    let curr: LNode | null = this.head;
    while (forward !== null && count <= index) {
        count++;
        forward = forward.next;
    }
    if (forward === null)
        throw new Error('TooFewNodes')
    while (forward !== null) {
        forward = forward.next;
        curr = curr.next;
    }
    return curr.value;
}

public findIntersection(lst2: LinkedList): LNode | null {
    let head2: LNode | null = lst2.head;
    let l1: number = 0;
    let l2: number = 0;
    let tempHead: LNode | null = this.head;
    let tempHead2: LNode | null = head2;
    while (tempHead !== null) {
        l1++;
        tempHead = tempHead.next;
    }
    while (tempHead2 !== null) {
        l2++;
        tempHead2 = tempHead2.next;
    }
    let diff: number;
    if (l1 < l2) {
        let temp: LNode | null = this.head;
        this.head = head2;
        head2 = temp;
        diff = l2 - l1;
    } else {
        diff = l1 - l2;
    }
    for (; diff > 0; diff--) {
        this.head = this.head!.next;
    }
    while (this.head !== head2) {
        this.head = this.head!.next;
        head2 = head2!.next;
    }
    return this.head;
}

public freeList() {
    this.head = null;
    this.length = 0;
}

public print() {
    let temp: LNode | null = this.head;
    let result: string = "";
    while (temp !== null) {
        result += (temp.value + " ");
        temp = temp.next;
    }
    console.log(result);
}

public sortedInsert(value: number) {
    let newNode: LNode = new LNode(value, null);
    if (this.head === null || this.head.value > value) {
        newNode.next = this.head;
        this.head = newNode;
        return;
    }
    let curr: LNode | null = this.head;
    while (curr!.next !== null && curr!.next.value < value) {
        curr = curr!.next;
    }
    newNode.next = curr!.next;
    curr!.next = newNode;
}

public removeDuplicate() {
    let curr: LNode | null = this.head;
    while (curr !== null) {
        if (curr.next !== null && curr.value === curr.next.value) {
            curr.next = curr.next.next;
        } else {
            curr = curr.next;
        }
    }
}

public makeLoop() {
    let temp: LNode | null = this.head;
    while (temp !== null) {
        if (temp.next === null) {
            temp.next = this.head;
            return;
        }
        temp = temp.next;
    }
}

public loopDetect(): boolean {
    let curr = this.head;
    let hs = new Set();

    while (curr != null) {
        if (hs.has(curr)) {
            console.log("loop found");
            return true;
        }

        hs.add(curr);
        curr = curr.next;
    }

    console.log("loop not found");
    return false;
}


public loopDetect2(): boolean {
    let slowPtr: LNode | null;
    let fastPtr: LNode | null;
    slowPtr = fastPtr = this.head;
    while (fastPtr !== null && fastPtr.next !== null) {
        slowPtr = slowPtr!.next;
        fastPtr = fastPtr!.next.next;
        if (slowPtr === fastPtr) {
            console.log("loop found");
            return true;
        }
    }
    console.log("loop not found");
    return false;
}

public reverseListLoopDetect(): boolean {
    let tempHead: LNode | null = this.head;
    this.reverse();
    if (tempHead === this.head) {
        this.reverse();
        console.log("loop found");
        return true;
    } else {
        this.reverse();
        console.log("loop not found");
        return false;
    }
}

public loopTypeDetect(): number {
    let slowPtr: LNode | null;
    let fastPtr: LNode | null;
    slowPtr = fastPtr = this.head;
    while (fastPtr !== null && fastPtr.next !== null) {
        if (this.head === fastPtr.next || this.head === fastPtr.next.next) {
            console.log("circular list loop found");
            return 2;
        }
        slowPtr = slowPtr!.next;
        fastPtr = fastPtr!.next.next;
        if (slowPtr === fastPtr) {
            console.log("loop found");
            return 1;
        }
    }
    console.log("loop not found");
    return 0;
}


private loopPointDetect(): LNode | null {
    let slowPtr: LNode | null = this.head;
    let fastPtr: LNode | null = this.head;
    while (fastPtr !== null && fastPtr.next !== null) {
        slowPtr = slowPtr!.next;
        fastPtr = fastPtr!.next.next;
        if (slowPtr === fastPtr) {
            return slowPtr;
        }
    }
    return null;
}

public removeLoop() {
    const loopPoint = this.loopPointDetect();
    if (loopPoint === null)
        return;
    let firstPtr: LNode | null = this.head;
    if (loopPoint === this.head) {
        while (firstPtr!.next !== this.head)
            firstPtr = firstPtr!.next;
        firstPtr!.next = null;
        return;
    }
    let secondPtr: LNode | null = loopPoint;
    while (firstPtr!.next !== secondPtr!.next) {
        firstPtr = firstPtr!.next;
        secondPtr = secondPtr!.next;
    }
    secondPtr!.next = null;
}

bubbleSort() {
    let curr: LNode | null = null;
    let end: LNode | null = null;
    let temp: number;

    if (this.head === null || this.head.next === null) {
        return;
    }

    let flag = true;
    while (flag) {
        flag = false;
        curr = this.head;
        while (curr!.next !== end) {
            if (curr!.value > curr!.next!.value) {
                flag = true;
                temp = curr!.value;
                curr!.value = curr!.next!.value;
                curr!.next!.value = temp;
            }
            curr = curr!.next;
        }
        end = curr;
    }
}

selectionSort() {
    let curr: LNode | null = null;
    let end: LNode | null = null;
    let maxNode: LNode | null;
    let temp: number;
    let max: number;

    if (this.head === null || this.head.next === null) {
        return;
    }

    while (this.head !== end) {
        curr = this.head;
        max = curr!.value;
        maxNode = curr;
        while (curr!.next !== end) {
            if (max < curr!.next!.value) {
                maxNode = curr!.next;
                max = curr!.next!.value;
            }
            curr = curr!.next;
        }
        end = curr;
        if (curr!.value < max) {
            temp = curr!.value;
            curr!.value = max;
            maxNode!.value = temp;
        }
    }
}

insertionSort() {
    let curr: LNode | null;
    let stop: LNode | null;
    let temp: number;

    if (this.head === null || this.head.next === null) {
        return;
    }

    stop = this.head.next;
    while (stop !== null) {
        curr = this.head;
        while (curr !== stop) {
            if (curr!.value > stop!.value) {
                temp = curr!.value;
                curr!.value = stop!.value;
                stop!.value = temp;
            }
            curr = curr!.next;
        }
        stop = stop!.next;
    }
}
}

// Testing code.
function main1() {
    const ll = new LinkedList();
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(3);
    ll.print();

    console.log("Size : " + ll.size());
    console.log("Size : " + ll.findLength());
    console.log("Is empty : " + ll.isEmpty());
    console.log("Peek : " + ll.peek());
    ll.addTail(4);
    ll.print();
}

main1();

/*
3 2 1 
Size : 3
Size : 3
Is empty : false
Peek : 3
3 2 1 4 
*/

function main2() {
    const ll = new LinkedList();
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(3);
    ll.print();
    console.log("search : " + ll.find(2));
    ll.removeHead();
    ll.print();
}

main2();

/*
3 2 1 
search : true
2 1
*/

function main3() {
    const ll = new LinkedList();
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(1);
    ll.addHead(3);
    ll.print();
    ll.deleteNode(2);
    ll.print();
    ll.deleteNodes(1);
    ll.print();
}
main3();
/*
3 1 2 1 2 1 
3 1 1 2 1 
3 2 
*/

function main4() {
    const ll = new LinkedList();
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(3);
    ll.print();

    ll.reverse();
    ll.print();

    ll.reverseRecurse();
    ll.print();

    const l2 = ll.copyList();
    l2.print();
    const l3 = ll.copyListReversed();
    l3.print();
}
main4();
/*
3 2 1 
1 2 3 
3 2 1 
3 2 1 
1 2 3 
*/

function main5() {
    const ll = new LinkedList();
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(3);
    ll.print();

    const l2 = ll.copyList();
    l2.print();
    const l3 = ll.copyListReversed();
    l3.print();
    console.log("compareList : " + ll.compareList(l2));
    console.log("compareList : " + ll.compareList2(l2));
    console.log("compareList : " + ll.compareList(l3));
    console.log("compareList : " + ll.compareList2(l3));
}
main5();
/*
3 2 1 
3 2 1 
1 2 3 
compareList : true
compareList : true
compareList : false
compareList : false
*/

function main6() {
    const ll = new LinkedList();
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(3);
    console.log(ll.nthNodeFromBeginning(2));
    console.log(ll.nthNodeFromEnd(2));
    console.log(ll.nthNodeFromEnd2(2));
}
main6();
/*
2
2
2
*/

function main7() {
    const ll = new LinkedList();
    ll.sortedInsert(1);
    ll.sortedInsert(2);
    ll.sortedInsert(3);
    ll.sortedInsert(1);
    ll.sortedInsert(2);
    ll.sortedInsert(3);
    ll.print();
    ll.removeDuplicate();
    ll.print();
}
main7();
/*
1 1 2 2 3 3 
1 2 3
*/

function main8() {
    const ll = new LinkedList();
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(3);
    ll.print();
    ll.makeLoop();
    ll.loopDetect();
    ll.loopDetect2();
    ll.reverseListLoopDetect();
    ll.loopTypeDetect();
    ll.removeLoop();
    ll.loopDetect();
}
main8();
/*
3 2 1 
loop found
circular list loop found
loop not found
*/

function main9() {
    const ll = new LinkedList();
    ll.addHead(1);
    ll.addHead(2);
    const ll2 = new LinkedList();
    ll2.addHead(3);
    ll2.head.next = ll.head;
    ll.addHead(4);
    ll2.addHead(5);
    ll.print();
    ll2.print();

    const nd = ll.findIntersection(ll2);
    if (nd != null)
        console.log("Intersection:: " + nd.value);
}
main9();
/*
4 2 1 
5 3 2 1 
Intersection:: 2
*/

function main10() {
    const ll = new LinkedList();
    ll.addHead(1);
    ll.addHead(10);
    ll.addHead(9);
    ll.addHead(7);
    ll.addHead(2);
    ll.addHead(3);
    ll.addHead(5);
    ll.addHead(4);
    ll.addHead(6);
    ll.addHead(8);
    ll.print();
    ll.bubbleSort();
    ll.print();
    ll.selectionSort();
    ll.print();
    ll.insertionSort();
    ll.print();
}

main10();