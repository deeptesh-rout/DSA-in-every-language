class TNode {
	n: number;
	keys: number[];
	arr: TNode[];
	leaf: boolean;

	constructor(leaf: boolean, maxDeg: number) {
		this.n = 0;
		this.keys = Array(maxDeg).fill(0);
		this.arr = Array(maxDeg + 1).fill(null);
		this.leaf = leaf;
	}
}

class BTree {
	root: TNode;
	max: number;
	min: number;

	constructor(dg: number) {
		this.root = null;
		this.max = dg;
		this.min = Math.floor(dg / 2);
	}

	printTree(): void {
		this.printTreeUtil(this.root, "");
		console.log();
	}

	private printTreeUtil(node: TNode, indent: string): void {
		if (node == null) {
			return;
		}
		let i = 0;
		for (i = 0; i < node.n; i++) {
			this.printTreeUtil(node.arr[i], indent + "    ");
			console.log(indent + "key[" + i + "]:" + node.keys[i]);
		}
		this.printTreeUtil(node.arr[i], indent + "    ");
	}

	printInOrder(node: TNode): void {
		let i = 0;
		for (i = 0; i < node.n; i++) {
			if (!node.leaf) {
				this.printInOrder(node.arr[i]);
			}
			console.log(node.keys[i] + " ");
		}
		if (!node.leaf) {
			this.printInOrder(node.arr[i]);
		}
	}

	search(key: number): TNode {
		if (this.root == null) {
			return null;
		}
		return this.searchUtil(this.root, key);
	}

	private searchUtil(node: TNode, key: number): TNode {
		let i = 0;
		while (i < node.n && node.keys[i] < key) {
			i++;
		}
		// If the found key is equal to key, return this node
		if (node.keys[i] == key) {
			return node;
		}
		// If the key is not found and this is a leaf node
		if (node.leaf == true) {
			return null;
		}
		// Search in the appropriate child
		return this.searchUtil(node.arr[i], key);
	}

	insert(key: number): void {
		// If tree is empty

		if (this.root == null) {
			this.root = new TNode(true, this.max);
			this.root.keys[0] = key;
			this.root.n = 1;
			return;
		}
		if (this.root.leaf) {
			let i = this.root.n - 1;
			while (i >= 0 && this.root.keys[i] > key) {
				this.root.keys[i + 1] = this.root.keys[i];
				i--;
			}
			// Insert the new key at found location
			this.root.keys[i + 1] = key;
			this.root.n = this.root.n + 1;
		} else {
			let i = 0;
			while (i < this.root.n && this.root.keys[i] < key) {
				i++;
			}
			this.insertUtil(this.root, this.root.arr[i], i, key);
		}
		if (this.root.n == this.max) {
			let rt = new TNode(false, this.max);
			rt.arr[0] = this.root;
			this.split(rt, this.root, 0);
			this.root = rt;
		}
	}

	// Insert a new key in this node
	// Arguments are parent, child, index of child and key.
	private insertUtil(parent: TNode, child: TNode, index: number, key: number): void {
		if (child.leaf) {
			// Finds the location where new key will be inserted 
			// by moving all keys greater than key to one place forward.
			let i = child.n - 1;
			while (i >= 0 && child.keys[i] > key) {
				child.keys[i + 1] = child.keys[i];
				i--;
			}
			// Insert the new key at found location
			child.keys[i + 1] = key;
			child.n = child.n + 1;
		} else {
			let i = 0;
			// insert the node to the proper child.	
			while (i < child.n && child.keys[i] < key) {
				i++;
			}
			this.insertUtil(child, child.arr[i], i, key);
		}
		if (child.n == this.max) {
			// More nodes than allowed.
			// divide the child into two and then add the median to the parent.
			this.split(parent, child, index);
		}
	}

	private split(parent: TNode, child: TNode, index: number): void {
		// Getting index of median.
		let median = this.min;
		// Reduce the number of keys in child
		child.n = median;
		let node = new TNode(child.leaf, this.max);
		// Copy the second half keys of child to node
		let j = 0;
		while (median + 1 + j < this.max) {
			node.keys[j] = child.keys[median + 1 + j];
			j++;
		}
		node.n = j;
		// Copy the second half children of child to node
		j = 0;
		while (child.leaf == false && median + j <= this.max - 1) {
			node.arr[j] = child.arr[median + 1 + j];
			j++;
		}
		// parent is going to have a new child,
		// create space of new child
		for (j = parent.n; j >= index + 1; j--) {
			parent.arr[j + 1] = parent.arr[j];
		}
		// Link the new child to the parent node
		parent.arr[index + 1] = node;
		// A key of child will move to the parent node. 
		// Find the location of new key by moving
		// all greater keys one space forward.
		for (j = parent.n - 1; j >= index; j--) {
			parent.keys[j + 1] = parent.keys[j];
		}
		// Copy the middle key of child to the parent
		parent.keys[index] = child.keys[median];
		// Increment count of keys in this parent
		parent.n += 1;
	}


	remove(key: number): void {
		this.removeUtil(this.root, key);
		if (this.root.n === 0) {
			// Shrinking: If root is pointing to empty node.
			// If that node is a leaf node then root will become null.
			// Else root will point to the first child of the node.
			if (this.root.leaf) {
				this.root = null;
			} else {
				this.root = this.root.arr[0];
			}
		}
	}

	private removeUtil(node: TNode, key: number): void {
		let index = this.findKey(node, key);
		if (node.leaf) {
			if (index < node.n && node.keys[index] === key) {
				this.removeFromLeaf(node, index);
			} else {
				console.log("The key " + key + " not found.");
				return;
			}
		} else {
			if (index < node.n && node.keys[index] === key) {
				this.removeFromNonLeaf(node, index);
			} else {
				this.removeUtil(node.arr[index], key);
			}
			// All the property violation in index subtree only.
			// which include remove from leaf case too.
			if (node.arr[index].n < this.min) {
				this.fixBTree(node, index);
			}
		}
	}

	// Returns the index of the first key which is greater than or equal to key.
	findKey(node: TNode, key: number): number {
		let index = 0;
		while (index < node.n && node.keys[index] < key) {
			index++;
		}
		return index;
	}

	// Remove the index key from the leaf node.
	private removeFromLeaf(node: TNode, index: number): void {
		// Move all the keys after the index position one step left.
		for (let i = index + 1; i < node.n; ++i) {
			node.keys[i - 1] = node.keys[i];
		}
		// Reduce the key count.
		node.n--;
		return;
	}

	// Remove the index key from a non-leaf node.
	private removeFromNonLeaf(node: TNode, index: number): void {
		let key = node.keys[index];
		// If the child that precedes key has at least min keys,
		// Find the predecessor 'pred' of key in the subtree rooted at index.
		// Replace key by pred and recursively delete pred in arr[index]
		if (node.arr[index].n > this.min) {
			let pred = this.getPred(node, index);
			node.keys[index] = pred;
			this.removeUtil(node.arr[index], pred);
		} else if (node.arr[index + 1].n > this.min) {
			let succ = this.getSucc(node, index);
			node.keys[index] = succ;
			this.removeUtil(node.arr[index + 1], succ);
		} else {
			this.merge(node, index);
			this.removeUtil(node.arr[index], key);
		}
		return;
	}

	// To get the predecessor of keys[index]
	private getPred(node: TNode, index: number): number {
		// Keep moving to the rightmost node of the left subtree until we reach a leaf.
		let cur = node.arr[index];
		while (!cur.leaf) {
			cur = cur.arr[cur.n];
		}
		// Return the last key of the leaf
		return cur.keys[cur.n - 1];
	}

	// To get the successor of keys[index]
	private getSucc(node: TNode, index: number): number {
		// Keep moving to the leftmost node of the right subtree until we reach a leaf
		let cur = node.arr[index + 1];
		while (!cur.leaf) {
			cur = cur.arr[0];
		}
		// Return the first key of the leaf
		return cur.keys[0];
	}

	// Make sure that the node has at least the min number of keys
	private fixBTree(node: TNode, index: number): void {
		// If the left sibling has more than min keys.
		if (index !== 0 && node.arr[index - 1].n > this.min) {
			this.borrowFromLeft(node, index);
		} else if (index !== node.n && node.arr[index + 1].n > this.min) {
			this.borrowFromRight(node, index);
		} else {
			if (index !== node.n) {
				this.merge(node, index);
			} else {
				this.merge(node, index - 1);
			}
		}
	}

	// Move a key from the parent to the right and left to the parent.
	private borrowFromLeft(node: TNode, index: number): void {
		let child = node.arr[index];
		let sibling = node.arr[index - 1];
		// Moving all keys in the child one step forward.
		for (let i = child.n - 1; i >= 0; i--) {
			child.keys[i + 1] = child.keys[i];
		}
		// Move all its child pointers one step forward.
		for (let i = child.n; !child.leaf && i >= 0; i--) {
			child.arr[i + 1] = child.arr[i];
		}
		// Setting child's first key equal to the current node.
		child.keys[0] = node.keys[index - 1];
		// Moving sibling's last child as the child's first child.
		if (!child.leaf) {
			child.arr[0] = sibling.arr[sibling.n];
		}
		// Moving the key from the sibling to the parent
		node.keys[index - 1] = sibling.keys[sibling.n - 1];
		// Increase child key count and decrease sibling key count.
		child.n += 1;
		sibling.n -= 1;
		return;
	}

	// Move a key from the parent to the left and right to the parent.
	private borrowFromRight(node: TNode, index: number): void {
		let child = node.arr[index];
		let sibling = node.arr[index + 1];
		// node key is inserted as the last key in the child.
		child.keys[child.n] = node.keys[index];
		// Sibling's first child is inserted as the last child of the child.
		if (!child.leaf) {
			child.arr[child.n + 1] = sibling.arr[0];
		}
		// First key from sibling is inserted into the node.
		node.keys[index] = sibling.keys[0];
		// Moving all keys in sibling one step left
		for (let i = 1; i < sibling.n; ++i) {
			sibling.keys[i - 1] = sibling.keys[i];
		}
		// Moving the child pointers one step behind
		for (let i = 1; !sibling.leaf && i <= sibling.n; ++i) {
			sibling.arr[i - 1] = sibling.arr[i];
		}
		// Increase child key count and decrease sibling key count.
		child.n += 1;
		sibling.n -= 1;
		return;
	}

	// Merge node's children at index and index+1.
	private merge(node: TNode, index: number): void {
		let left = node.arr[index];
		let right = node.arr[index + 1];
		let start = left.n;
		// Adding a key from the node to the left child.
		left.keys[start] = node.keys[index];
		// Copying the keys from the right to the left.
		for (let i = 0; i < right.n; ++i) {
			left.keys[start + 1 + i] = right.keys[i];
		}
		// Copying the child pointers from the right to the left.
		for (let i = 0; !left.leaf && i <= right.n; ++i) {
			left.arr[start + 1 + i] = right.arr[i];
		}
		// Moving all keys after the index in the current node one step forward.
		for (let i = index + 1; i < node.n; ++i) {
			node.keys[i - 1] = node.keys[i];
		}
		// Moving the child pointers after (index+1) in the current node one step forward.
		for (let i = index + 2; i <= node.n; ++i) {
			node.arr[i - 1] = node.arr[i];
		}
		// Updating the key count of child and the current node
		left.n += right.n + 1;
		node.n--;
		return;
	}
}

// Testing code.
let t = new BTree(3); // A B-Tree with max key 3
t.insert(1);
t.insert(2);
t.insert(3);
t.insert(4);
t.insert(5);
t.insert(6);
t.insert(7);
t.insert(8);
t.insert(9);
t.insert(10);
t.printTree();
console.log("6 : " + ((t.search(6) != null) ? "Present" : "Not Present"));
console.log("11 : " + ((t.search(11) != null) ? "Present" : "Not Present"));
t.remove(6);
t.remove(3);
t.remove(7);
t.printTree();

/*
		key[0]:1
	key[0]:2
		key[0]:3
key[0]:4
		key[0]:5
	key[0]:6
		key[0]:7
	key[1]:8
		key[0]:9
		key[1]:10

6 : Present
11 : Not Present

	key[0]:1
	key[1]:2
key[0]:4
	key[0]:5
key[1]:8
	key[0]:9
	key[1]:10
*/