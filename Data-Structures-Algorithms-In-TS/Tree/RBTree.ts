class TNode<T> {
	data: T;
	left: TNode<T>;
	right: TNode<T>;
	colour: boolean; // true for red, false for black. New nodes are red in colour.
	parent: TNode<T>;

	constructor(data: T, nullNode: TNode<T>) {
		this.data = data;
		this.left = nullNode;
		this.right = nullNode;
		this.colour = true;
		this.parent = nullNode;
	}
}

class RBTree<T> {
	NullNode: TNode<T>;
	root: TNode<T>;

	constructor() {
		this.NullNode = new TNode<T>(null, null);
		this.NullNode.colour = false;
		this.root = this.NullNode;
	}

	// To check whether a node is red or not.
	private isRed(node: TNode<T> | null): boolean {
		return node !== null && node.colour === true;
	}

	printTree(): void {
		this.printTreeUtil(this.root, "", false);
		console.log();
	}

	private printTreeUtil(node: TNode<T>, indent: string, isLeft: boolean): void {
		if (node === this.NullNode) {
			return;
		}
		let output = "";
		if (isLeft) {
			output += indent + "L:";
			indent += "|  ";
		} else {
			output += indent + "R:";
			indent += "   ";
		}
		console.log(output + node.data + "(" + node.colour + ")");
		this.printTreeUtil(node.left, indent, true);
		this.printTreeUtil(node.right, indent, false);
	}

	private uncle(node: TNode<T>): TNode<T> | null {
		// If no parent or grandparent, then no uncle
		if (
			node.parent === this.NullNode ||
			node.parent.parent === this.NullNode
		) {
			return null;
		}
		if (node.parent === node.parent.parent.left) {
			// uncle on the right
			return node.parent.parent.right;
		} else {
			// uncle on the left
			return node.parent.parent.left;
		}
	}

	// Function to right rotate subtree rooted with x
	private rightRotate(x: TNode<T>): TNode<T> {
		const y = x.left;
		const T = y.right;
		// Rotation
		y.parent = x.parent;
		y.right = x;
		x.parent = y;
		x.left = T;
		if (T !== this.NullNode) {
			T.parent = x;
		}
		if (x === this.root) {
			this.root = y;
			return y;
		}
		if (y.parent.left === x) {
			y.parent.left = y;
		} else {
			y.parent.right = y;
		}
		// Return new root
		return y;
	}

	// Function to left rotate subtree rooted with x
	private leftRotate(x: TNode<T>): TNode<T> {
		const y = x.right;
		const T = y.left;
		// Rotation
		y.parent = x.parent;
		y.left = x;
		x.parent = y;
		x.right = T;
		if (T !== this.NullNode) {
			T.parent = x;
		}
		if (x === this.root) {
			this.root = y;
			return y;
		}
		if (y.parent.left === x) {
			y.parent.left = y;
		} else {
			y.parent.right = y;
		}
		// Return new root
		return y;
	}

	private rightLeftRotate(node: TNode<T>): TNode<T> {
		node.right = this.rightRotate(node.right);
		return this.leftRotate(node);
	}

	private leftRightRotate(node: TNode<T>): TNode<T> {
		node.left = this.leftRotate(node.left);
		return this.rightRotate(node);
	}

	find(data: T): TNode<T> | null {
		let curr = this.root;
		while (curr !== this.NullNode) {
			if (curr.data === data) {
				return curr;
			} else if (curr.data > data) {
				curr = curr.left;
			} else {
				curr = curr.right;
			}
		}
		return null;
	}

	insert(data: T): void {
		this.root = this.insertUtil(this.root, data);
		let temp = this.find(data);
		this.fixRedRed(temp);
	}

	private insertUtil(node: TNode<T>, data: T): TNode<T> {
		if (node === this.NullNode) {
			node = new TNode<T>(data, this.NullNode);
		} else if (node.data > data) {
			node.left = this.insertUtil(node.left, data);
			node.left.parent = node;
		} else if (node.data < data) {
			node.right = this.insertUtil(node.right, data);
			node.right.parent = node;
		}
		return node;
	}

	private fixRedRed(x: TNode<T>): void {
		if (x === this.root) {
			x.colour = false;
			return;
		}
		if (x.parent === this.NullNode || x.parent.parent === this.NullNode) {
			return;
		}
		let parent = x.parent;
		let grandparent = parent.parent;
		let uncle = this.uncle(x);
		let mid = null;
		if (parent.colour === false) {
			return;
		}
		if (uncle !== this.NullNode && uncle.colour === true) {
			parent.colour = false;
			uncle.colour = false;
			grandparent.colour = true;
			this.fixRedRed(grandparent);
			return;
		}
		if (parent === grandparent.left && x === parent.left) {
			mid = this.rightRotate(grandparent);
		} else if (parent === grandparent.left && x === parent.right) {
			mid = this.leftRightRotate(grandparent);
		} else if (parent === grandparent.right && x === parent.left) {
			mid = this.rightLeftRotate(grandparent);
		} else if (parent === grandparent.right && x === parent.right) {
			mid = this.leftRotate(grandparent);
		}
		mid.colour = false;
		mid.left.colour = true;
		mid.right.colour = true;
	}

	delete(data: T): void {
		this.deleteUtil(this.root, data);
	}

	private deleteUtil(node: TNode<T>, key: T): void {
		let z = this.NullNode;
		let x = null;
		let y = null;
		while (node !== this.NullNode) {
			if (node.data === key) {
				z = node;
				break;
			} else if (node.data <= key) {
				node = node.right;
			} else {
				node = node.left;
			}
		}
		if (z === this.NullNode) {
			console.log("Couldn't find key in the tree");
			return;
		}
		y = z;
		let yColour = y.colour;
		if (z.left === this.NullNode) {
			x = z.right;
			this.joinParentChild(z, z.right);
		} else if (z.right === this.NullNode) {
			x = z.left;
			this.joinParentChild(z, z.left);
		} else {
			y = this.minimum(z.right);
			yColour = y.colour;
			z.data = y.data;
			this.joinParentChild(y, y.right);
			x = y.right;
		}
		if (yColour === false) {
			if (x.colour === true) {
				x.colour = false;
				return;
			} else {
				this.fixDoubleBlack(x);
			}
		}
	}

	private fixDoubleBlack(x: TNode<T>): void {
		if (x === this.root) {
			return;
		}
		let sib = this.sibling(x);
		let parent = x.parent;
		if (sib === this.NullNode) {
			this.fixDoubleBlack(parent);
		} else {
			if (sib.colour === true) {
				parent.colour = true;
				sib.colour = false;
				if (sib.parent.left === sib) {
					this.rightRotate(parent);
				} else {
					this.leftRotate(parent);
				}
				this.fixDoubleBlack(x);
			} else {
				if (sib.left.colour === true || sib.right.colour === true) {
					if (sib.parent.left === sib) {
						if (sib.left !== this.NullNode && sib.left.colour === true) {
							sib.left.colour = sib.colour;
							sib.colour = parent.colour;
							this.rightRotate(parent);
						} else {
							sib.right.colour = parent.colour;
							this.leftRotate(sib);
							this.rightRotate(parent);
						}
					} else {
						if (sib.left !== this.NullNode && sib.left.colour === true) {
							sib.left.colour = parent.colour;
							this.rightRotate(sib);
							this.leftRotate(parent);
						} else {
							sib.right.colour = sib.colour;
							sib.colour = parent.colour;
							this.leftRotate(parent);
						}
					}
					parent.colour = false;
				} else {
					sib.colour = true;
					if (parent.colour === false) {
						this.fixDoubleBlack(parent);
					} else {
						parent.colour = false;
					}
				}
			}
		}
	}


	private sibling(node: TNode<T>): TNode<T> {
		if (node.parent === this.NullNode) {
			return null;
		}
		if (node.parent.left === node) {
			return node.parent.right;
		}
		return node.parent.left;
	}

	private joinParentChild(u: TNode<T>, v: TNode<T>): void {
		if (u.parent === this.NullNode) {
			this.root = v;
		} else if (u === u.parent.left) {
			u.parent.left = v;
		} else {
			u.parent.right = v;
		}
		v.parent = u.parent;
	}

	private minimum(node: TNode<T>): TNode<T> {
		while (node.left !== this.NullNode) {
			node = node.left;
		}
		return node;
	}
}

// Testing code.
let tree = new RBTree();
tree.insert(1);
tree.insert(2);
tree.insert(3);
tree.insert(4);
tree.insert(5);
tree.insert(7);
tree.insert(6);
tree.insert(8);
tree.insert(9);
tree.printTree();
tree.delete(4);
tree.printTree();
tree.delete(7);
tree.printTree();


/*
R:4(false)
   L:2(true)
   |  L:1(false)
   |  R:3(false)
   R:6(true)
	  L:5(false)
	  R:8(false)
		 L:7(true)
		 R:9(true)

R:5(false)
   L:2(true)
   |  L:1(false)
   |  R:3(false)
   R:7(true)
	  L:6(false)
	  R:8(false)
		 R:9(true)

R:5(false)
   L:2(true)
   |  L:1(false)
   |  R:3(false)
   R:8(true)
	  L:6(false)
	  R:9(false)
*/