class CountMap {
    private hm: Map<any, number>;

    constructor() {
        this.hm = new Map();
    }

    add(key: any): void {
        if (this.hm.has(key)) {
            const count = this.hm.get(key)!;
            this.hm.set(key, count + 1);
        } else {
            this.hm.set(key, 1);
        }
    }

    remove(key: any): void {
        if (this.hm.has(key)) {
            const count = this.hm.get(key)!;
            if (count === 1) {
                this.hm.delete(key);
            } else {
                this.hm.set(key, count - 1);
            }
        }
    }

    get(key: any): number {
        return this.hm.get(key) || 0;
    }

    find(key: any): boolean {
        return this.hm.has(key);
    }

    size(): number {
        return this.hm.size;
    }
}

/* Testing Code */
const cm = new CountMap();
cm.add(2);
cm.add(2);
console.log(`Count of 2 is: ${cm.get(2)}`);
cm.remove(2);
console.log(`Count of 2 is: ${cm.get(2)}`);
cm.remove(2);
console.log(`Count of 2 is: ${cm.get(2)}`);
console.log(`Count of 3 is: ${cm.get(3)}`);

/*
Count of 2 is: 2
Count of 2 is: 1
Count of 2 is: 0
Count of 3 is: 0
*/