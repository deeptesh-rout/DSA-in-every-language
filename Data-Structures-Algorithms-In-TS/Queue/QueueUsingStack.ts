class QueueUsingStack<T> {
    stk1: T[];
    stk2: T[];

    constructor() {
        this.stk1 = [];
        this.stk2 = [];
    }

    add(value: T): void {
        this.stk1.push(value);
    }

    length(): number {
        return this.stk1.length + this.stk2.length;
    }

    isEmpty(): boolean {
        return this.length() === 0;
    }

    remove(): T {
        if (this.stk2.length === 0) {
            while (this.stk1.length > 0) {
                const value = this.stk1.pop();
                this.stk2.push(value);
            }
        }
        return this.stk2.pop();
    }
}

// Testing code.
const que: QueueUsingStack<number> = new QueueUsingStack<number>();
que.add(1);
que.add(2);
que.add(3);
console.log(que.remove());
console.log(que.remove());
