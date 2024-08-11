let CharCount: number = 26;

class TrieNode {
    child: TrieNode[];
    isLastChar: boolean;
    ch: string;

    constructor(c: string) {
        this.child = new Array(CharCount).fill(null);
        this.isLastChar = false;
        this.ch = c;
    }
}

class Trie {
    root: TrieNode;

    constructor() {
        this.root = new TrieNode(' ');
    }

    insert(str: string): void {
        if (str == null) {
            return;
        }
        const temp = str.toString().toLowerCase();
        this.insertUtil(this.root, temp, 0);
    }

    private insertUtil(curr: TrieNode, str: string, index: number): TrieNode {
        if (curr == null) {
            curr = new TrieNode(str[index - 1]);
        }

        if (str.length === index) {
            curr.isLastChar = true;
        } else {
            curr.child[str.charCodeAt(index) - 'a'.charCodeAt(0)] =
                this.insertUtil(
                    curr.child[str.charCodeAt(index) - 'a'.charCodeAt(0)],
                    str, index + 1);
        }
        return curr;
    }

    remove(str: string): void {
        if (str == null) {
            return;
        }
        str = str.toLowerCase();
        this.removeUtil(this.root, str, 0);
    }

    private removeUtil(curr: TrieNode, str: string, index: number): void {
        if (curr == null) {
            return;
        }

        if (str.length === index) {
            if (curr.isLastChar) {
                curr.isLastChar = false;
            }
            return;
        }
        this.removeUtil(
            curr.child[str.charCodeAt(index) - 'a'.charCodeAt(0)],
            str,
            index + 1
        );
    }

    find(str: string): boolean {
        if (str == null) {
            return false;
        }
        str = str.toLowerCase();
        return this.findUtil(this.root, str, 0);
    }

    private findUtil(curr: TrieNode, str: string, index: number): boolean {
        if (curr == null) {
            return false;
        }
        if (str.length === index) {
            return curr.isLastChar;
        }
        return this.findUtil(
            curr.child[str.charCodeAt(index) - 'a'.charCodeAt(0)],
            str, index + 1);
    }
}

// Testing code.
const tt = new Trie();
tt.insert("banana");
tt.insert("apple");
tt.insert("mango");
console.log("Apple Found:", tt.find("apple"));
console.log("Grapes Found:", tt.find("grapes"));
console.log("Banana Found:", tt.find("banana"));

/*
Apple Found: true
Grapes Found: false
Banana Found: true
*/
