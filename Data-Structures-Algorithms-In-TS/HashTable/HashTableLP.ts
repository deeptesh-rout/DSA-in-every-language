const EMPTY_VALUE = -1;
const DELETED_VALUE = -2;
const FILLED_VALUE = 0;

class HashTable {
    private tableSize: number;
    private KeyArr: any[];
    private DataArr: any[];
    private FlagArr: number[];
    private comp: (a: any, b: any) => number;
    private HashFun: (key: any) => number;

    constructor(tSize: number, cmp?: (a: any, b: any) => number, hashFun?: (key: any) => number) {
        this.comp = cmp || this.DefaultCompare;
        this.HashFun = hashFun || this.DefaultHashFun;
        this.tableSize = tSize;
        this.KeyArr = new Array(tSize + 1);
        this.DataArr = new Array(tSize + 1);
        this.FlagArr = new Array(tSize + 1).fill(EMPTY_VALUE);
    }

	private ComputeHash(key: any): number {
	    return this.HashFun(key) % this.tableSize;
	}
	
	private resolverFun(index: number): number {
	    return index;
	}

    private DefaultCompare(first: any, second: any): number {
        return first - second;
    }

    private DefaultHashFun(key: any): number {
        return key;
    }
		
	public add(key: any, value?: any): boolean {
	    if (key == null) {
	        return false;
	    }
	
	    if (value == null) {
	        value = key;
	    }
	
	    let hashValue = this.ComputeHash(key);
	    for (let i = 0; i < this.tableSize; i++) {
	        if (this.FlagArr[hashValue] === EMPTY_VALUE ||
	            this.FlagArr[hashValue] === DELETED_VALUE) {
	            this.DataArr[hashValue] = value;
	            this.KeyArr[hashValue] = key;
	            this.FlagArr[hashValue] = FILLED_VALUE;
	            return true;
	        } else if (this.FlagArr[hashValue] === FILLED_VALUE &&
	            this.KeyArr[hashValue] === key) {
	            this.DataArr[hashValue] = value;
	            return true;
	        }
	
	        hashValue += this.resolverFun(i);
	        hashValue %= this.tableSize;
	    }
	    return false;
	}
	
	public find(key: any): boolean {
	    if (key == null) {
	        return false;
	    }
	
	    let hashValue = this.ComputeHash(key);
	    for (let i = 0; i < this.tableSize; i++) {
	        if (this.FlagArr[hashValue] === EMPTY_VALUE) {
	            return false;
	        }
	        if (this.FlagArr[hashValue] === FILLED_VALUE &&
	            this.KeyArr[hashValue] === key) {
	            return true;
	        }
	        hashValue += this.resolverFun(i);
	        hashValue %= this.tableSize;
	    }
	    return false;
	}
	
	public get(key: any): any {
	    if (key == null) {
	        return 0;
	    }
	
	    let hashValue = this.ComputeHash(key);
	    for (let i = 0; i < this.tableSize; i++) {
	        if (this.FlagArr[hashValue] === EMPTY_VALUE) {
	            return 0;
	        }
	        if (this.FlagArr[hashValue] === FILLED_VALUE &&
	            this.KeyArr[hashValue] === key) {
	            return this.DataArr[hashValue];
	        }
	        hashValue += this.resolverFun(i);
	        hashValue %= this.tableSize;
	    }
	    return 0;
	}
	
	public remove(key: any): boolean {
	    if (key == null) {
	        return false;
	    }
	
	    let hashValue = this.ComputeHash(key);
	    for (let i = 0; i < this.tableSize; i++) {
	        if (this.FlagArr[hashValue] === EMPTY_VALUE) {
	            return false;
	        }
	        if (this.FlagArr[hashValue] === FILLED_VALUE &&
	            this.KeyArr[hashValue] === key) {
	            this.FlagArr[hashValue] = DELETED_VALUE;
	            return true;
	        }
	        hashValue += this.resolverFun(i);
	        hashValue %= this.tableSize;
	    }
	    return false;
	}
	
	public print(): void {
	    let output = "Hash Table contains:";
	    for (let i = 0; i < this.tableSize; i++) {
	        if (this.FlagArr[i] === FILLED_VALUE) {
	            output += ` (${this.KeyArr[i]}=>${this.DataArr[i]})`;
	        }
	    }
	    console.log(output);
	}
}

// Testing code.
const ht = new HashTable(1000);
ht.add(1, 10);
ht.add(2, 20);
ht.add(3, 30);
ht.print();

console.log("Find key 2:", ht.find(2));
console.log("Value at key 2:", ht.get(2));
ht.remove(1);
ht.print();

/*
Hash Table contains: (1=>10) (2=>20) (3=>30)
Find key 2: true
Value at key 2: 20
Hash Table contains: (2=>20) (3=>30)
*/
