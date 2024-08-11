class CLNode {
    public value: number;
    public next: CLNode | null;

    public constructor(v: number, n: CLNode | null = null) {
        this.value = v;
        this.next = n;
    }
}

class CircularLinkedList {
    tail: CLNode | null;
    length: number;

    constructor() {
        this.length = 0;
        this.tail = null;
    }

    public size(): number {
        return this.length;
    }

    public isEmpty(): boolean {
        return this.length === 0;
    }

    public peek(): number | null {
        if (this.isEmpty())
            throw new Error("EmptyListException");
        return this.tail!.next!.value;
    }

    public addTail(value: number): void {
        let temp: CLNode = new CLNode(value);
        if (this.isEmpty()) {
            this.tail = temp;
            temp.next = temp;
        } else {
            temp.next = this.tail!.next;
            this.tail!.next = temp;
            this.tail = temp;
        }
        this.length++;
    }

    public addHead(value: number): void {
        let temp: CLNode = new CLNode(value);
        if (this.isEmpty()) {
            this.tail = temp;
            temp.next = temp;
        } else {
            temp.next = this.tail!.next;
            this.tail!.next = temp;
        }
        this.length++;
    }

    public removeHead(): number {
        if (this.isEmpty()) {
            throw new Error("EmptyListException");
        }
        let value: number = this.tail!.next!.value;
        if (this.tail === this.tail!.next)
            this.tail = null;
        else
            this.tail!.next = this.tail!.next!.next;
        this.length--;
        return value;
    }

    public removeNode(key: number): boolean {
        if (this.isEmpty()) {
            return false;
        }
        let prev: CLNode = this.tail!;
        let curr: CLNode = this.tail!.next!;
        let head: CLNode = this.tail!.next!;
        if (curr.value === key) {
            if (curr === curr.next)
                this.tail = null;
            else
                this.tail!.next = this.tail!.next!.next;
            return true;
        }
        prev = curr;
        curr = curr.next!;
        while (curr !== head) {
            if (curr.value === key) {
                if (curr === this.tail)
                    this.tail = prev;
                prev.next = curr.next;
                return true;
            }
            prev = curr;
            curr = curr.next!;
        }
        return false;
    }

    public copyListReversed(): CircularLinkedList {
        let cl: CircularLinkedList = new CircularLinkedList();
        let curr: CLNode | null = this.tail!.next;
        let head: CLNode | null = curr;
        if (curr != null) {
            cl.addHead(curr.value);
            curr = curr.next;
        }
        while (curr !== head) {
            cl.addHead(curr.value);
            curr = curr.next;
        }
        return cl;
    }

    public copyList(): CircularLinkedList {
        let cl: CircularLinkedList = new CircularLinkedList();
        let curr: CLNode | null = this.tail!.next;
        let head: CLNode | null = curr;
        if (curr != null) {
            cl.addTail(curr.value);
            curr = curr.next;
        }
        while (curr !== head) {
            cl.addTail(curr!.value);
            curr = curr!.next;
        }
        return cl;
    }

    public find(data: number): boolean {
        let temp: CLNode | null = this.tail;
        for (let i: number = 0; i < this.length; i++) {
            if (temp!.value === data)
                return true;
            temp = temp!.next;
        }
        return false;
    }

    public freeList(): void {
        this.tail = null;
        this.length = 0;
    }

    public print(): void {
        if (this.isEmpty()) {
            console.log("Empty list.");
            return;
        }
        let result: string = "";
        let temp: CLNode | null = this.tail!.next;
        while (temp !== this.tail) {
            result += (temp!.value + " ");
            temp = temp!.next;
        }
        result += temp!.value;
        console.log(result);
    }
}

function main1() {
    let ll = new CircularLinkedList();
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(3);
    ll.print();
    console.log(ll.size());
    console.log(ll.isEmpty());
    console.log(ll.peek());
    console.log(ll.find(3));
}

/*
3 2 1
3
false
3
true
*/

function main2() {
    let ll = new CircularLinkedList();
    ll.addTail(1);
    ll.addTail(2);
    ll.addTail(3);
    ll.print();
}

/*
1 2 3
*/

function main3() {
    let ll = new CircularLinkedList();
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(3);
    ll.print();
    ll.removeHead();
    ll.print();
    ll.removeNode(2);
    ll.print();
    ll.freeList();
    ll.print();
}

/*
3 2 1
2 1
1
Empty List.
*/

function main4() {
    let ll = new CircularLinkedList();
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(3);
    ll.print();
    let ll2 = ll.copyList();
    ll2.print();
    let ll3 = ll.copyListReversed();
    ll3.print();
}

/*
3 2 1
3 2 1
1 2 3
*/

function main5() {
    let ll = new CircularLinkedList();
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(3);
    ll.print();
    ll.removeNode(2);
    ll.print();
}

/*
3 2 1
3 1
*/

main1();
main2();
main3();
main4();
main5();
