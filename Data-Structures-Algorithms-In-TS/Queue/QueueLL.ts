class QueueNode<T> {
    value: T;
    next: QueueNode<T> | null;

    constructor(v: T, n: QueueNode<T> | null) {
        this.value = v;
        this.next = n;
    }
}

class Queue<T> {
    head: QueueNode<T> | null;
    tail: QueueNode<T> | null;
    length: number;

    constructor() {
        this.head = null;
        this.tail = null;
        this.length = 0;
    }

    size(): number {
        return this.length;
    }

    isEmpty(): boolean {
        return this.length === 0;
    }

    peek(): T {
        if (this.isEmpty())
            throw new Error("Queue is empty.");
        return this.head!.value;
    }
    
    print(): void {
        let output = "";
        let temp = this.head;
        while (temp !== null) {
            output += `${temp.value} `;
            temp = temp.next;
        }
        console.log(output);
    }
    
    add(value: T): void {
        const temp = new QueueNode(value, null);
        if (this.head === null)
            this.head = this.tail = temp;
        else {
            this.tail!.next = temp;
            this.tail = temp;
        }
        this.length++;
    }

    remove(): T {
        if (this.isEmpty())
            throw new Error("Queue is empty.");
        const value = this.head!.value;
        this.head = this.head!.next;
        if (this.head === null)
            this.tail = null;
        this.length--;
        return value;
    }
}

// Testing code
const que = new Queue<number>();
que.add(1);
que.add(2);
que.add(3);
que.print();
console.log("IsEmpty: " + que.isEmpty());
console.log("Size: " + que.size());
console.log("Queue remove: " + que.remove());
console.log("Queue remove: " + que.remove());

/*
1 2 3
IsEmpty: false
Size: 3
Queue remove: 1
Queue remove: 2
*/
