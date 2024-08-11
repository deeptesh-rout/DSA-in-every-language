    class Queue<T> {
    arr: T[];

    constructor() {
        this.arr = [];
    }

    add(value: T): void {
        this.arr.push(value);
    }

    remove(): T | undefined {
        return this.arr.shift();
    }

    front(): T | undefined {
        return this.arr[0];
    }

    isEmpty(): boolean {
        return this.arr.length === 0;
    }

    length(): number {
        return this.arr.length;
    }
    }

    const MAX_INT = 2147483647;
    const MIN_INT = -2147483647;

    class TreeNode {
    value: any;
    left: TreeNode | null;
    right: TreeNode | null;

    constructor(data: any, left: TreeNode | null = null, right: TreeNode | null = null) {
        this.value = data;
        this.left = left;
        this.right = right;
    }
    }

    class Tree {
    root: TreeNode | null;

    constructor() {
        this.root = null;
    }

    /* Other Functions */

    public createCompleteBinaryTree(arr: any[]): void {
        this.root = this.createCompleteBinaryTreeUtil(arr, 0);
    }

    private createCompleteBinaryTreeUtil(arr: any[], start: number): TreeNode | null {
        const size = arr.length;
        const curr = new TreeNode(arr[start]);
        const left = 2 * start + 1;
        const right = 2 * start + 2;

        if (left < size)
            curr.left = this.createCompleteBinaryTreeUtil(arr, left);
        if (right < size)
            curr.right = this.createCompleteBinaryTreeUtil(arr, right);

        return curr;
    }

    public printPreOrder(): void {
        let output = "Pre Order: ";
        output += this.printPreOrderUtil(this.root);
        console.log(output);
    }

    private printPreOrderUtil(node: TreeNode | null): string {
        let output: string = "";
        if (node != null) {
            output += `${node.value} `;
            output += this.printPreOrderUtil(node.left);
            output += this.printPreOrderUtil(node.right);
        }
        return output;
    }

    public printPostOrder(): void {
        let output = "Post Order: ";
        output += this.printPostOrderUtil(this.root);
        console.log(output);
    }

    private printPostOrderUtil(node: TreeNode | null): string {
        let output: string = "";
        if (node != null) {
            output += this.printPostOrderUtil(node.left);
            output += this.printPostOrderUtil(node.right);
            output += `${node.value} `;
        }
        return output;
    }

    public printInOrder(): void {
        let output = "In Order: ";
        output += this.printInOrderUtil(this.root);
        console.log(output);
    }

    private printInOrderUtil(node: TreeNode | null): string {
        let output: string = "";
        if (node != null) {
            output = this.printInOrderUtil(node.left);
            output += `${node.value} `;
            output += this.printInOrderUtil(node.right);
        }
        return output;
    }

    public printBreadthFirst(): void {
        const que = new Queue<TreeNode>();
        let temp: TreeNode | null;

        if (this.root != null)
            que.add(this.root);

        let output: string = "Breadth First: ";
        while (que.isEmpty() === false) {
            temp = que.remove();
            output += `${temp.value} `;
            if (temp.left != null)
                que.add(temp.left);
            if (temp.right != null)
                que.add(temp.right);
        }
        console.log(output);
    }

    public printDepthFirst(): void {
        const stk: TreeNode[] = [];
        let temp: TreeNode | null;
        if (this.root != null)
            stk.push(this.root);

        let output: string = "Depth First: ";
        while (stk.length > 0) {
            temp = stk.pop();
            output += `${temp.value} `;
            if (temp.right != null)
                stk.push(temp.right);
            if (temp.left != null)
                stk.push(temp.left);
        }
        console.log(output);
    }

    public printLevelOrderLineByLine(): void {
        const que1 = new Queue<TreeNode>();
        const que2 = new Queue<TreeNode>();
        let temp: TreeNode | null = null;
        if (this.root != null)
            que1.add(this.root);

        let output: string;
        while (que1.length() !== 0 || que2.length() !== 0) {
            output = "";
            while (que1.length() !== 0) {
                temp = que1.remove();
                output += `${temp.value} `;
                if (temp.left != null)
                    que2.add(temp.left);
                if (temp.right != null)
                    que2.add(temp.right);
            }
            console.log(output);
            output = "";
            while (que2.length() !== 0) {
                temp = que2.remove();
                output += `${temp.value} `;
                if (temp.left != null)
                    que1.add(temp.left);
                if (temp.right != null)
                    que1.add(temp.right);
            }
            console.log(output);
        }
    }

    public printLevelOrderLineByLine2(): void {
        const que = new Queue<TreeNode>();
        let temp: TreeNode | null = null;
        let count = 0;
        if (this.root != null)
            que.add(this.root);

        let output: string;
        while (que.length() !== 0) {
            output = "";
            count = que.length();
            while (count > 0) {
                temp = que.remove();
                output += `${temp.value} `;
                if (temp.left != null)
                    que.add(temp.left);
                if (temp.right != null)
                    que.add(temp.right);
                count -= 1;
            }
            console.log(output);
        }
    }

    public printSpiralTree(): void {
        const stk1: TreeNode[] = [];
        const stk2: TreeNode[] = [];
        let temp: TreeNode | null;
        if (this.root != null)
            stk1.push(this.root);

        let output: string = "Spiral Tree:";
        while (stk1.length !== 0 || stk2.length !== 0) {
            while (stk1.length !== 0) {
                temp = stk1.pop();
                output += ` ${temp.value}`;
                if (temp.right != null)
                    stk2.push(temp.right);
                if (temp.left != null)
                    stk2.push(temp.left);
            }
            while (stk2.length !== 0) {
                temp = stk2.pop();
                output += ` ${temp.value}`;
                if (temp.left != null)
                    stk1.push(temp.left);
                if (temp.right != null)
                    stk1.push(temp.right);
            }
        }
        console.log(output);

    }


    public nthPreOrder(index: number): void {
        const counter: number[] = [0];
        this.nthPreOrderUtil(this.root, index, counter);
    }

    private nthPreOrderUtil(node: TreeNode | null, index: number, counter: number[]): void {
        if (node != null) {
            counter[0]++;
            if (counter[0] === index) {
                console.log(`Nth Preorder Node: ${node.value}`);
                return;
            }
            this.nthPreOrderUtil(node.left, index, counter);
            this.nthPreOrderUtil(node.right, index, counter);
        }
    }

    public nthPostOrder(index: number): void {
        const counter: number[] = [0];
        this.nthPostOrderUtil(this.root, index, counter);
    }

    private nthPostOrderUtil(node: TreeNode | null, index: number, counter: number[]): void {
        if (node != null) {
            this.nthPostOrderUtil(node.left, index, counter);
            this.nthPostOrderUtil(node.right, index, counter);
            counter[0]++;
            if (counter[0] === index) {
                console.log(`Nth PostOrder Node: ${node.value}`);
            }
        }
    }

    public nthInOrder(index: number): void {
        const counter: number[] = [0];
        this.nthInOrderUtil(this.root, index, counter);
    }

    private nthInOrderUtil(node: TreeNode | null, index: number, counter: number[]): void {
        if (node != null) {
            this.nthInOrderUtil(node.left, index, counter);
            counter[0]++;
            if (counter[0] === index) {
                console.log(`Nth InOrder Node: ${node.value}`);
                return;
            }
            this.nthInOrderUtil(node.right, index, counter);
        }
    }

    public printAllPath(): void {
        const stk: any[] = [];
        console.log("Print All Path : ");
        this.printAllPathUtil(this.root, stk);
    }

    private printAllPathUtil(curr: TreeNode | null, stk: any[]): void {
        if (curr == null)
            return;
        stk.push(curr.value);

        if (curr.left == null && curr.right == null) {
            console.log(stk);
            stk.pop();
            return;
        }

        this.printAllPathUtil(curr.right, stk);
        this.printAllPathUtil(curr.left, stk);
        stk.pop();
    }

    public numNodes(): number {
        return this.numNodesUtil(this.root);
    }

    private numNodesUtil(curr: TreeNode | null): number {
        if (curr == null)
            return 0;
        else
            return 1 + this.numNodesUtil(curr.right) + this.numNodesUtil(curr.left);
    }

    public sumAllBT(): number {
        return this.sumAllBTUtil(this.root);
    }

    private sumAllBTUtil(curr: TreeNode | null): number {
        if (curr == null)
            return 0;
        return curr.value + this.sumAllBTUtil(curr.left) + this.sumAllBTUtil(curr.right);
    }

    public numLeafNodes(): number {
        return this.numLeafNodesUtil(this.root);
    }

    private numLeafNodesUtil(curr: TreeNode | null): number {
        if (curr == null)
            return 0;

        if (curr.left == null && curr.right == null)
            return 1;
        else
            return this.numLeafNodesUtil(curr.right) + this.numLeafNodesUtil(curr.left);
    }


    public numFullNodesBT(): number {
        return this.numFullNodesBTUtil(this.root);
    }

    private numFullNodesBTUtil(curr: TreeNode | null): number {
        let count: number;
        if (curr == null)
            return 0;

        count = this.numFullNodesBTUtil(curr.right) + this.numFullNodesBTUtil(curr.left);
        if (curr.right != null && curr.left != null)
            count++;
        return count;
    }

    public searchBT(value: number): boolean {
        return this.searchBTUtil(this.root, value);
    }

    private searchBTUtil(curr: TreeNode | null, val: number): boolean {
        if (curr == null)
            return false;

        if (curr.value === val || this.searchBTUtil(curr.left, val) || this.searchBTUtil(curr.right, val))
            return true;

        return false;
    }

    public findMaxBT(): number {
        const ans = this.findMaxBTUtil(this.root);
        return ans;
    }

    private findMaxBTUtil(curr: TreeNode | null): number {
        if (curr == null)
            return MIN_INT;

        let max = curr.value;
        const left = this.findMaxBTUtil(curr.left);
        const right = this.findMaxBTUtil(curr.right);

        if (left > max)
            max = left;

        if (right > max)
            max = right;

        return max;
    }

    public treeDepth(): number {
        return this.treeDepthUtil(this.root);
    }

    private treeDepthUtil(curr: TreeNode | null): number {
        if (curr == null)
            return 0;
        else {
            const lDepth = this.treeDepthUtil(curr.left);
            const rDepth = this.treeDepthUtil(curr.right);

            if (lDepth > rDepth)
                return lDepth + 1;
            else
                return rDepth + 1;
        }
    }

    public maxLengthPathBT(): number {
        return this.maxLengthPathBTUtil(this.root);
    }

    private maxLengthPathBTUtil(curr: TreeNode | null): number {
        if (curr == null)
            return 0;

        const leftPath = this.treeDepthUtil(curr.left);
        const rightPath = this.treeDepthUtil(curr.right);
        let max = leftPath + rightPath + 1;

        const leftMax = this.maxLengthPathBTUtil(curr.left);
        const rightMax = this.maxLengthPathBTUtil(curr.right);

        if (leftMax > max)
            max = leftMax;

        if (rightMax > max)
            max = rightMax;

        return max;
    }

    public copyTree(): Tree {
        const tree2 = new Tree();
        tree2.root = this.copyTreeUtil(this.root);
        return tree2;
    }

    private copyTreeUtil(curr: TreeNode | null): TreeNode | null {
        if (curr != null) {
            const temp = new TreeNode(curr.value);
            temp.left = this.copyTreeUtil(curr.left);
            temp.right = this.copyTreeUtil(curr.right);
            return temp;
        } else {
            return null;
        }
    }

    public copyMirrorTree(): Tree {
        const tree2 = new Tree();
        tree2.root = this.copyMirrorTreeUtil(this.root);
        return tree2;
    }

    private copyMirrorTreeUtil(curr: TreeNode | null): TreeNode | null {
        if (curr != null) {
            const temp = new TreeNode(curr.value);
            temp.right = this.copyMirrorTreeUtil(curr.left);
            temp.left = this.copyMirrorTreeUtil(curr.right);
            return temp;
        } else {
            return null;
        }
    }

    public isEqual(tree: Tree): boolean {
        return this.isEqualUtil(this.root, tree.root);
    }

    private isEqualUtil(node1: TreeNode | null, node2: TreeNode | null): boolean {
        if (node1 == null && node2 == null)
            return true;
        else if (node1 == null || node2 == null)
            return false;
        else
            return (
                this.isEqualUtil(node1.left, node2.left) &&
                this.isEqualUtil(node1.right, node2.right) &&
                node1.value === node2.value
            );
    }

    public free(): void {
        this.root = null;
    }

    public isCompleteTree(): boolean {
        const que = new Queue();
        let temp = null;
        let noChild = 0;
        if (this.root != null)
            que.add(this.root);

        while (que.length() !== 0) {
            temp = que.remove();
            if (temp.left != null) {
                if (noChild === 1)
                    return false;
                que.add(temp.left);
            } else
                noChild = 1;

            if (temp.right != null) {
                if (noChild === 1)
                    return false;
                que.add(temp.right);
            } else
                noChild = 1;
        }
        return true;
    }

    private isCompleteTreeUtil(curr: TreeNode | null, index: number, count: number): boolean {
        if (curr == null)
            return true;

        if (index > count)
            return false;

        return (
            this.isCompleteTreeUtil(curr.left, index * 2 + 1, count) &&
            this.isCompleteTreeUtil(curr.right, index * 2 + 2, count)
        );
    }

    public isCompleteTree2(): boolean {
        const count = this.numNodes();
        return this.isCompleteTreeUtil(this.root, 0, count);
    }


    private isHeapUtil(curr: TreeNode | null, parentValue: number): boolean {
        if (curr == null)
            return true;

        if (curr.value < parentValue)
            return false;

        return (
            this.isHeapUtil(curr.left, curr.value) &&
            this.isHeapUtil(curr.right, curr.value)
        );
    }

    public isHeap(): boolean {
        const infi = MIN_INT;
        return this.isCompleteTree() && this.isHeapUtil(this.root, infi);
    }

    private isHeapUtil2(curr: TreeNode | null, index: number, count: number, parentValue: number): boolean {
        if (curr == null)
            return true;

        if (index > count)
            return false;

        if (curr.value < parentValue)
            return false;

        return (
            this.isHeapUtil2(curr.left, index * 2 + 1, count, curr.value) &&
            this.isHeapUtil2(curr.right, index * 2 + 2, count, curr.value)
        );
    }

    public isHeap2(): boolean {
        const count = this.numNodes();
        const parentValue = MIN_INT;
        return this.isHeapUtil2(this.root, 0, count, parentValue);
    }

    public iterativePreOrder(): void {
        const stk: TreeNode[] = [];
        let output: string = "Iterative Pre Order : ";
        let curr: TreeNode | undefined;

        if (this.root != null)
            stk.push(this.root);

        while (stk.length > 0) {
            curr = stk.pop();
            if (curr) {
                output += ` ${curr.value}`;
                if (curr.right != null)
                    stk.push(curr.right);
                if (curr.left != null)
                    stk.push(curr.left);
            }
        }
        console.log(output);
    }

    public iterativePostOrder(): void {
        const stk: TreeNode[] = [];
        const visited: number[] = [];
        let curr: TreeNode | undefined;
        let vtd: number | undefined;

        if (this.root != null) {
            stk.push(this.root);
            visited.push(0);
        }

        let output: string = "Iterative Post Order : ";
        while (stk.length > 0) {
            curr = stk.pop();
            vtd = visited.pop();
            if (vtd === 1) {
                if (curr)
                    output += ` ${curr.value}`;
            } else {
                if (curr) {
                    stk.push(curr);
                    visited.push(1);
                    if (curr.right != null) {
                        stk.push(curr.right);
                        visited.push(0);
                    }
                    if (curr.left != null) {
                        stk.push(curr.left);
                        visited.push(0);
                    }
                }
            }
        }
        console.log(output);
    }

    public iterativeInOrder(): void {
        const stk: TreeNode[] = [];
        const visited: number[] = [];
        let curr: TreeNode | undefined;
        let vtd: number | undefined;

        if (this.root != null) {
            stk.push(this.root);
            visited.push(0);
        }

        let output: string = "Iterative In Order : ";
        while (stk.length > 0) {
            curr = stk.pop();
            vtd = visited.pop();
            if (vtd === 1) {
                if (curr)
                    output += ` ${curr.value}`;
            } else {
                if (curr) {
                    if (curr.right != null) {
                        stk.push(curr.right);
                        visited.push(0);
                    }
                    stk.push(curr);
                    visited.push(1);
                    if (curr.left != null) {
                        stk.push(curr.left);
                        visited.push(0);
                    }
                }
            }
        }
        console.log(output);
    }

    public treeToListRec(): Tree {
        const t2 = this.copyTree();
        const root = this.treeToListRecUtil(t2.root);
        t2.root = root;
        return t2;
    }

    private treeToListRecUtil(curr: TreeNode | null): TreeNode | null {
        let head: TreeNode | null = null;
        let tail: TreeNode | null = null;
        if (curr == null)
            return null;

        if (curr.left == null && curr.right == null) {
            curr.left = curr;
            curr.right = curr;
            return curr;
        }

        if (curr.left != null) {
            head = this.treeToListRecUtil(curr.left);
            tail = head!.left;
            curr.left = tail;
            tail!.right = curr;
        } else
            head = curr;

        if (curr.right != null) {
            const tempHead = this.treeToListRecUtil(curr.right);
            tail = tempHead!.left;
            curr.right = tempHead;
            tempHead!.left = curr;
        } else
            tail = curr;

        head!.left = tail;
        tail!.right = head;
        return head;
    }

    public printDLL(): void {
        if (this.root == null) {
            return;
        }
        let curr = this.root;
        let tail = curr!.left;
        let output: string = `DLL nodes are : `;
        while (curr !== tail) {
            output += `${curr.value} `;
            curr = curr.right!;
        }
        output += `${curr.value}`;
        console.log(output);
    }

    public createBinarySearchTree(arr: number[]): void {
        this.root = this.createBinarySearchTreeUtil(arr, 0, arr.length - 1);
    }

    private createBinarySearchTreeUtil(arr: number[], start: number, end: number): TreeNode | null {
        if (start > end)
            return null;

        const mid = Math.floor((start + end) / 2);
        const curr = new TreeNode(arr[mid]);
        curr.left = this.createBinarySearchTreeUtil(arr, start, mid - 1);
        curr.right = this.createBinarySearchTreeUtil(arr, mid + 1, end);
        return curr;
    }

    public insertNode(value: number): void {
        this.root = this.insertNodeUtil(this.root, value);
    }

    private insertNodeUtil(node: TreeNode | null, value: number): TreeNode {
        if (node == null) {
            node = new TreeNode(value, null, null);
        } else {
            if (node.value > value) {
                node.left = this.insertNodeUtil(node.left, value);
            } else {
                node.right = this.insertNodeUtil(node.right, value);
            }
        }
        return node;
    }

    public find(value: number): boolean {
        let curr = this.root;
        while (curr != null) {
            if (curr.value === value) {
                return true;
            } else if (curr.value > value) {
                curr = curr.left;
            } else {
                curr = curr.right;
            }
        }
        return false;
    }

    public find2(value: number): boolean {
        let curr = this.root;
        while (curr != null && curr.value !== value) {
            curr = (curr.value > value) ? curr.left : curr.right;
        }
        return curr != null;
    }

    public findMin(): number {
        let node = this.root;
        if (node == null) {
            return Number.MAX_VALUE;
        }
        while (node.left != null) {
            node = node.left;
        }
        return node.value;
    }

    public findMinNode(curr: TreeNode | null): TreeNode | null {
        let node = curr;
        if (node == null) {
            return null;
        }

        while (node.left != null) {
            node = node.left;
        }

        return node;
    }

    public findMax(): number {
        let node = this.root;
        if (node == null) {
            return Number.MIN_VALUE;
        }
        while (node.right != null) {
            node = node.right;
        }
        return node.value;
    }

    public findMaxNode(curr: TreeNode | null): TreeNode | null {
        let node = curr;
        if (node == null) {
            return null;
        }

        while (node.right != null) {
            node = node.right;
        }

        return node;
    }

    public isBST3(): boolean {
        return this.isBST3Util(this.root);
    }

    private isBST3Util(root: TreeNode | null): boolean {
        if (root == null)
            return true;

        if (root.left != null && this.findMaxNode(root.left)!.value > root.value)
            return false;

        if (root.right != null && this.findMinNode(root.right)!.value <= root.value)
            return false;

        return (this.isBST3Util(root.left) && this.isBST3Util(root.right));
    }

    public isBST(): boolean {
        return this.isBSTUtil(this.root, Number.MIN_VALUE, Number.MAX_VALUE);
    }

    private isBSTUtil(curr: TreeNode | null, min: number, max: number): boolean {
        if (curr == null)
            return true;

        if (curr.value < min || curr.value > max)
            return false;

        return this.isBSTUtil(curr.left, min, curr.value) && this.isBSTUtil(curr.right, curr.value, max);
    }

    public isBST2(): boolean {
        const count: number[] = [Number.MIN_VALUE];
        return this.isBST2Util(this.root, count);
    }

    private isBST2Util(root: TreeNode | null, count: number[]): boolean {
        let ret;
        if (root != null) {
            ret = this.isBST2Util(root.left, count);
            if (!ret)
                return false;

            if (count[0] > root.value)
                return false;

            count[0] = root.value;
            ret = this.isBST2Util(root.right, count);
            if (!ret)
                return false;
        }
        return true;
    }

    public deleteNode(value: number): void {
        this.root = this.deleteNodeUtil(this.root, value);
    }

    private deleteNodeUtil(node: TreeNode | null, value: number): TreeNode | null {
        let temp: TreeNode | null = null;
        if (node != null) {
            if (node.value === value) {
                if (node.left == null && node.right == null) {
                    return null;
                } else {
                    if (node.left == null) {
                        temp = node.right;
                        return temp;
                    }
                    if (node.right == null) {
                        temp = node.left;
                        return temp;
                    }
                    const minNode = this.findMinNode(node.right);
                    const minValue = minNode!.value;
                    node.value = minValue;
                    node.right = this.deleteNodeUtil(node.right, minValue);
                }
            } else {
                if (node.value > value) {
                    node.left = this.deleteNodeUtil(node.left, value);
                } else {
                    node.right = this.deleteNodeUtil(node.right, value);
                }
            }
        }
        return node;
    }

    public lcaBST(first: number, second: number): number {
        let result: number;
        if (first > second)
            result = this.lcaBSTUtil(this.root, second, first);
        else
            result = this.lcaBSTUtil(this.root, first, second);

        return result;
    }

    private lcaBSTUtil(curr: TreeNode | null, first: number, second: number): number {
        if (curr == null) {
            return Number.MAX_VALUE;
        }

        if (curr.value > second) {
            return this.lcaBSTUtil(curr.left, first, second);
        }

        if (curr.value < first) {
            return this.lcaBSTUtil(curr.right, first, second);
        }

        if (this.find(first) && this.find(second))
            return curr.value;

        return Number.MAX_VALUE;
    }

    public printInRange(min: number, max: number): void {
        let output: string = "Print In Range : ";
        output += this.printInRangeUtil(this.root, min, max);
        console.log(output);
    }

    private printInRangeUtil(curr: TreeNode | null, min: number, max: number): string {
        if (curr == null)
            return "";
        let output: string = "";
        output += this.printInRangeUtil(curr.left, min, max);
        if (curr.value >= min && curr.value <= max)
            output += `${curr.value} `;
        output += this.printInRangeUtil(curr.right, min, max);
        return output;
    }

    public trimOutsideRange(min: number, max: number): void {
        this.root = this.trimOutsideRangeUtil(this.root, min, max);
    }

    private trimOutsideRangeUtil(curr: TreeNode | null, min: number, max: number): TreeNode | null {
        if (curr == null)
            return null;

        curr.left = this.trimOutsideRangeUtil(curr.left, min, max);
        curr.right = this.trimOutsideRangeUtil(curr.right, min, max);

        if (curr.value < min) {
            return curr.right;
        }

        if (curr.value > max) {
            return curr.left;
        }

        return curr;
    }

    public ceilBST(val: number): number {
        let curr = this.root;
        let ceil = Number.MIN_VALUE;
        while (curr != null) {
            if (curr.value === val) {
                ceil = curr.value;
                break;
            } else if (curr.value > val) {
                ceil = curr.value;
                curr = curr.left;
            } else {
                curr = curr.right;
            }
        }
        return ceil;
    }

    public floorBST(val: number): number {
        let curr = this.root;
        let floor = Number.MAX_VALUE;
        while (curr != null) {
            if (curr.value === val) {
                floor = curr.value;
                break;
            } else if (curr.value > val) {
                curr = curr.left;
            } else {
                floor = curr.value;
                curr = curr.right;
            }
        }
        return floor;
    }

    public ancestor(first: number, second: number): TreeNode | null {
        if (first > second) {
            const temp = first;
            first = second;
            second = temp;
        }
        return this.ancestorUtil(this.root, first, second);
    }

    private ancestorUtil(curr: TreeNode | null, first: number, second: number): TreeNode | null {
        if (curr == null) {
            return null;
        }
        if (curr.value > first && curr.value > second) {
            return this.ancestorUtil(curr.left, first, second);
        }
        if (curr.value < first && curr.value < second) {
            return this.ancestorUtil(curr.right, first, second);
        }
        return curr;
    }

    public LCA(first: number, second: number): number {
        const ans = this.LCAUtil(this.root, first, second);
        if (ans != null)
            return ans.value;
        else
            return Number.MIN_VALUE;
    }

    private LCAUtil(curr: TreeNode | null, first: number, second: number): TreeNode | null {
        let left: TreeNode | null;
        let right: TreeNode | null;

        if (curr == null)
            return null;
        if (curr.value === first || curr.value === second)
            return curr;

        left = this.LCAUtil(curr.left, first, second);
        right = this.LCAUtil(curr.right, first, second);

        if (left != null && right != null)
            return curr;
        else if (left != null)
            return left;
        else
            return right;
    }
    }

function isBSTArray(preorder: number[], size: number): boolean {
        const stk: number[] = [];
        let value: number;
        let root: number = Number.MIN_VALUE;
    
        for (let i = 0; i < size; i++) {
            value = preorder[i];
            // If value of the right child is less than root.
            if (value < root)
                return false;
            // First left child values will be popped
            // Last popped value will be the root.
            while (stk.length > 0 && stk[stk.length - 1] < value) {
                root = stk.pop()!;
            }
            // add current value to the stack.
            stk.push(value);
        }
        return true;
    }


function main1() {
    let t = new Tree();
    let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    t.createCompleteBinaryTree(arr);
    t.printPreOrder();
    //Pre Order: 1 2 4 8 9 5 10 3 6 7 

    t.printPostOrder();
    // Post Order: 8 9 4 10 5 2 6 7 3 1 

    t.printInOrder();
    // In Order: 8 4 9 2 10 5 1 6 3 7 

    t.iterativePreOrder();
    // Iterative Pre Order :  1 2 4 8 9 5 10 3 6 7 

    t.iterativePostOrder();
    //Iterative Post Order :  8 9 4 10 5 2 6 7 3 1

    t.iterativeInOrder();
    // Iterative In Order :  8 4 9 2 10 5 1 6 3 7

    t.printBreadthFirst();
    // Breadth First: 1 2 3 4 5 6 7 8 9 10  

    t.printDepthFirst();
    // Depth First: 1 2 4 8 9 5 10 3 6 7 

    t.printLevelOrderLineByLine();
    /*
    1 
    2 3 
    4 5 6 7 
    8 9 10 
    */

    t.printLevelOrderLineByLine2();
    /*
    1 
    2 3 
    4 5 6 7 
    8 9 10 
    */

    t.printSpiralTree();
    // Spiral Tree: 1 2 3 7 6 5 4 8 9 10


    t.nthInOrder(2);
    t.nthPostOrder(2);
    t.nthPreOrder(2);

    /*
    Nth InOrder Node: 4
    Nth PostOrder Node: 9
    Nth Preorder Node: 2
    */

    t.printAllPath();

    /*
    [1, 3, 7]
    [1, 3, 6]
    [1, 2, 5, 10]
    [1, 2, 4, 9]
    [1, 2, 4, 8]
    */
}

function main2() {
    let t = new Tree();
    let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    t.createCompleteBinaryTree(arr);

    console.log("numNodes:", t.numNodes());
    // numNodes: 10

    console.log("sumAllBT:", t.sumAllBT());
    // sumAllBT: 55

    console.log("numLeafNodes:", t.numLeafNodes());
    // numLeafNodes: 5

    console.log("numFullNodesBT:", t.numFullNodesBT());
    // numFullNodesBT: 4

    console.log("searchBT:", t.searchBT(9));
    // searchBT: true

    console.log("findMaxBT:", t.findMaxBT());
    // findMaxBT: 10

    console.log("treeDepth:", t.treeDepth());
    // treeDepth: 4

    console.log("maxLengthPathBT:", t.maxLengthPathBT());
    // maxLengthPathBT: 6
}

function main3() {
    let t = new Tree();
    let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    t.createCompleteBinaryTree(arr);

    let t2 = t.copyTree();
    t2.printInOrder();
    /*
    In Order: 8 4 9 2 10 5 1 6 3 7 
    */
    let t3 = t.copyMirrorTree();
    t3.printInOrder();
    /*
    In Order: 7 3 6 1 5 10 2 9 4 8 
    */
    console.log("isEqual:", t.isEqual(t2));
    /*
    isEqual: true
    */
    console.log("isHeap:", t.isHeap());
    console.log("isHeap:", t.isHeap2());
    console.log("isCompleteTree:", t.isCompleteTree());
    console.log("isCompleteTree:", t.isCompleteTree2());
    /*
    isHeap: true
    isHeap: true
    isCompleteTree: true
    isCompleteTree: true
    */
}

function main4() {
    let t = new Tree();
    t.insertNode(6);
    t.insertNode(4);
    t.insertNode(2);
    t.insertNode(5);
    t.insertNode(1);
    t.insertNode(3);
    t.insertNode(8);
    t.insertNode(7);
    t.insertNode(9);
    t.insertNode(10);
    t.printInOrder();

    /*
    In Order: 1 2 3 4 5 6 7 8 9 10 
    */
    console.log(t.find(3));
    console.log(t.find(16));
    /*
    true
    false
    */
    console.log("isBST:", t.isBST());
    console.log("isBST:", t.isBST2());
    console.log("isBST:", t.isBST3());
    /*
    isBST: true
    isBST: true
    isBST: true
    */
}


function main5() {
    let t = new Tree();
    let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    t.createBinarySearchTree(arr);
    console.log("findMin:", t.findMin());
    console.log("findMax:", t.findMax());
    console.log("LCA:", t.lcaBST(3, 4));
    console.log("LCA:", t.lcaBST(1, 4));
    console.log("LCA:", t.lcaBST(10, 4));
}

    /*
    findMin: 1
    findMax: 10
    LCA: 3
    LCA: 2
    LCA: 5
    */

function main6() {
    let t = new Tree();
    let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    t.createBinarySearchTree(arr);
    t.printInOrder();
    t.printInRange(4, 7);
    t.trimOutsideRange(4, 7);
    t.printInOrder();
}

    /*
    In Order: 1 2 3 4 5 6 7 8 9 10 
    Print In Range : 4 5 6 7 
    In Order: 4 5 6 7
    */

function main7() {
    let t = new Tree();
    let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    t.createBinarySearchTree(arr);
    console.log("ancestor:", t.ancestor(1, 10).value);
    // ancestor: 5

    console.log("ceilBST:", t.ceilBST(5.5));
    // ceilBST: 6

    console.log("floorBST:", t.floorBST(5.5));
    // floorBST: 5

    let arr1 = [5, 2, 4, 6, 9, 10];
    let arr2 = [5, 2, 6, 4, 7, 9, 10];
    console.log("isBSTArray:", isBSTArray(arr1, 6));
    console.log("isBSTArray:", isBSTArray(arr2, 7));
    /*
    isBSTArray: true
    isBSTArray: false
    */
}

function main8() {
    let t = new Tree();
    t.insertNode(2);
    t.insertNode(1);
    t.insertNode(3);
    t.insertNode(4);

    console.log("Before delete operation.");
    t.printInOrder();
    t.deleteNode(2);
    console.log("After delete operation.");
    t.printInOrder();
}
/*
Before delete operation.
1 2 3 4 
After delete operation.
1 3 4 
*/

main1();
main2();
main3();
main4();
main5();
main6();
main7();
main8()
