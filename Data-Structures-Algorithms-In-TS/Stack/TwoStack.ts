class TwoStack<T> {
    private readonly MAX_SIZE: number;
    private top1: number;
    private top2: number;
    private data: T[];

    constructor() {
        this.MAX_SIZE = 1000;
        this.top1 = -1;
        this.top2 = this.MAX_SIZE;
        this.data = new Array<T>(this.MAX_SIZE);
    }

    push1(value: T): void {
        if (this.top1 < this.top2 - 1) {
            this.data[++this.top1] = value;
        } else {
            console.log("Stack is Full!");
        }
    }

    push2(value: T): void {
        if (this.top1 < this.top2 - 1) {
            this.data[--this.top2] = value;
        } else {
            console.log("Stack is Full!");
        }
    }

    pop1(): T {
        if (this.top1 >= 0) {
            const value = this.data[this.top1--];
            return value;
        } else {
            console.log("Stack Empty!");
            return undefined!;
        }
    }

    pop2(): T {
        if (this.top2 < this.MAX_SIZE) {
            const value = this.data[this.top2++];
            return value;
        } else {
            console.log("Stack Empty!");
            return undefined!;
        }
    }
}

// Testing code.
const st = new TwoStack<number>();
st.push1(1);
st.push1(2);
st.push2(3);
st.push2(4);
console.log("stk1 pop: " + st.pop1());
console.log("stk1 pop: " + st.pop1());
console.log("stk2 pop: " + st.pop2());
console.log("stk2 pop: " + st.pop2());

/*
stk1 pop: 2
stk1 pop: 1
stk2 pop: 4
stk2 pop: 3
*/