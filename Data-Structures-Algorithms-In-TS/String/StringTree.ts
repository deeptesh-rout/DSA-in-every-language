class StringTreeNode {
    value: string;
    count: number;
    left: StringTreeNode;
    right: StringTreeNode;

    constructor() {
        this.value = null;
        this.count = 0;
        this.left = null;
        this.right = null;
    }
}

class StringTree {
    root: StringTreeNode = null;

    public print() {
        this.printUtil(this.root);
    }

    private printUtil(curr: StringTreeNode) {
        if (curr != null) {
            console.log(" value is: " + curr.value);
            console.log(" count is: " + curr.count);
            this.printUtil(curr.left);
            this.printUtil(curr.right);
        }
    }


    public insert(value: string) {
        this.root = this.insertUtil(value, this.root);
    }

    private insertUtil(value: string, curr: StringTreeNode): StringTreeNode {
        if (curr == null) {
            curr = new StringTreeNode();
            curr.value = value;
            curr.left = curr.right = null;
            curr.count = 1;
        } else {
            let compare: number = curr.value.localeCompare(value);
            if (compare === 0)
                curr.count++;
            else if (compare === 1)
                curr.left = this.insertUtil(value, curr.left);
            else
                curr.right = this.insertUtil(value, curr.right);
        }
        return curr;
    }

    public find(value: string): boolean {
        let ret: boolean = this.findUtil(this.root, value);
        return ret;
    }

    private findUtil(curr: StringTreeNode, value: string): boolean {
        if (curr == null)
            return false;
        let compare: number = curr.value.localeCompare(value);
        if (compare === 0)
            return true;
        else {
            if (compare === 1)
                return this.findUtil(curr.left, value);
            else
                return this.findUtil(curr.right, value);
        }
    }


    public frequency(value: string): number {
        return this.frequencyUtil(this.root, value);
    }

    private frequencyUtil(curr: StringTreeNode, value: string): number {
        if (curr == null)
            return 0;
        let compare: number = curr.value.localeCompare(value);
        if (compare === 0)
            return curr.count;
        else {
            if (compare > 0)
                return this.frequencyUtil(curr.left, value);
            else
                return this.frequencyUtil(curr.right, value);
        }
    }

    public freeTree() {
        this.root = null;
    }
}

// Testing code.
const tt = new StringTree();
tt.insert("banana");
tt.insert("apple");
tt.insert("mango");
console.log("Apple Found :", tt.find("apple"));
console.log("Grapes Found :", tt.find("grapes"));
console.log("Banana Found :", tt.find("banana"));

/*
Apple Found : true
Grapes Found : false
Banana Found : true
*/