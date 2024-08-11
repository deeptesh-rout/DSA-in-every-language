class DCLLNode {
    value: number;
    next: DCLLNode | null;
    prev: DCLLNode | null;

    public constructor(v: number, nxt: DCLLNode | null = null, prv: DCLLNode | null = null) {
        this.value = v;
        this.next = nxt;
        this.prev = prv;
    }
}

class DoublyCircularLinkedList {
    head: DCLLNode | null = null;
    tail: DCLLNode | null = null;
    length: number = 0;

    public size(): number {
        return this.length;
    }

    public isEmpty(): boolean {
        return this.length === 0;
    }

    public peekHead(): number | null {
        if (this.isEmpty())
            throw new Error("EmptyListException");
        return this.head!.value;
    }

    public addHead(value: number): void {
        const newNode: DCLLNode = new DCLLNode(value);
        if (this.length === 0) {
            this.tail = this.head = newNode;
            newNode.next = newNode;
            newNode.prev = newNode;
        } else {
            newNode.next = this.head!;
            newNode.prev = this.head!.prev;
            this.head!.prev = newNode;
            newNode.prev!.next = newNode;
            this.head = newNode;
        }
        this.length++;
    }

    public addTail(value: number): void {
        const newNode: DCLLNode = new DCLLNode(value);
        if (this.length === 0) {
            this.head = this.tail = newNode;
            newNode.next = newNode;
            newNode.prev = newNode;
        } else {
            newNode.next = this.tail!.next;
            newNode.prev = this.tail;
            this.tail!.next = newNode;
            newNode.next!.prev = newNode;
            this.tail = newNode;
        }
        this.length++;
    }

    public removeHead(): number {
        if (this.length === 0)
            throw new Error("EmptyListException");
        const value: number = this.head!.value;
        this.length--;
        if (this.length === 0) {
            this.head = null;
            this.tail = null;
            return value;
        }
        const next: DCLLNode = this.head!.next!;
        next.prev = this.tail;
        this.tail!.next = next;
        this.head = next;
        return value;
    }

    public removeTail(): number {
        if (this.length === 0)
            throw new Error("EmptyListException");
        const value: number = this.tail!.value;
        this.length--;
        if (this.length === 0) {
            this.head = null;
            this.tail = null;
            return value;
        }
        const prev: DCLLNode = this.tail!.prev!;
        prev.next = this.head;
        this.head!.prev = prev;
        this.tail = prev;
        return value;
    }

    public find(key: number): boolean {
        let temp: DCLLNode | null = this.head;
        if (this.head == null)
            return false;
        do {
            if (temp.value === key)
                return true;
            temp = temp.next;
        } while (temp !== this.head);
        return false;
    }

    public freeList(): void {
        this.head = null;
        this.tail = null;
        this.length = 0;
    }

    public print(): void {
        if (this.isEmpty()) {
            console.log("Empty list.");
            return;
        }
        let temp: DCLLNode | null = this.head;
        let result: string = "";
        while (temp !== this.tail) {
            result += (temp.value + " ");
            temp = temp.next;
        }
        result += temp.value;
        console.log(result);
    }
}


function main1() {
    let ll = new DoublyCircularLinkedList();
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(3);
    ll.print();
    console.log("Size : " + ll.size());
    console.log("Is empty : " + ll.isEmpty());
    console.log("Peek : " + ll.peekHead());
    console.log("search : " + ll.find(3));
}

/*
3 2 1
Size : 3
Is empty : false
Peek : 3
search : true
*/

function main2() {
    let ll = new DoublyCircularLinkedList();
    ll.addTail(1);
    ll.addTail(2);
    ll.addTail(3);
    ll.print();

    ll.removeHead();
    ll.print();
    ll.removeTail();
    ll.print();
    ll.freeList();
    ll.print();
}

/*
1 2 3
2 3
2
Empty List.
*/

function main3() {
    let ll = new DoublyCircularLinkedList();
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(3);
    ll.print();
    ll.removeHead();
    ll.print();

}

/*
3 2 1
2 1
*/

function main4() {
    let ll = new DoublyCircularLinkedList();
    ll.addHead(1);
    ll.addHead(2);
    ll.addHead(3);
    ll.print();

    ll.removeTail();
    ll.print();
}

/*
3 2 1
3 2
*/

main1();
main2();
main3();
main4();
