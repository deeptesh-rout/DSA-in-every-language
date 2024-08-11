class Deque<T> {
    private arr: T[];

    constructor() {
        this.arr = [];
    }

    size(): number {
        return this.arr.length;
    }

    add(val: T): void {
        this.arr.push(val);
    }

    remove(): T {
        return this.arr.shift();
    }

    front(): T {
        return this.arr[0];
    }

    back(): T {
        return this.arr[this.arr.length - 1];
    }

    removeLast(): T {
        return this.arr.pop();
    }
}

class Queue<T> {
    private arr: T[];

    constructor() {
        this.arr = [];
    }

    add(value: T): void {
        this.arr.push(value);
    }

    remove(): T {
        const value = this.arr[0];
        this.arr.shift();
        return value;
    }

    front(): T {
        return this.arr[0];
    }

    back(): T {
        return this.arr[this.arr.length - 1];
    }

    isEmpty(): boolean {
        return this.arr.length === 0;
    }

    size(): number {
        return this.arr.length;
    }
}


function function2() {
    console.log("fun2 line 1");
}

function function1() {
    console.log("fun1 line 1");
    function2();
    console.log("fun1 line 2");
}

// Testing code.
function test1() {
    console.log("test line 1");
    function1();
    console.log("test line 2");
}

//test1();

/*
test line 1
fun1 line 1
fun2 line 1
fun1 line 2
test line 2
*/

function sortedInsert(stk: Array<number>, element: number) {
    let temp: number;
    if ((stk.length == 0) || element > stk[stk.length - 1])
        stk.push(element);
    else {
        temp = stk.pop();
        sortedInsert(stk, element);
        stk.push(temp);
    }
}

// Testing code.
function test2() {
    const stk = [];
    stk.push(1);
    stk.push(2);
    stk.push(4);
    stk.push(5);
    sortedInsert(stk, 3)
    console.log(stk);
}

test2()

// [ 1, 2, 3, 4, 5 ]

function sortStack(stk: Array<number>) {
    let temp: number;
    if (stk.length != 0) {
        temp = stk.pop();
        sortStack(stk);
        sortedInsert(stk, temp);
    }
}

function sortStack2(stk: Array<number>) {
    let temp: number;
    let stk2: Array<number> = new Array<number>();
    while (stk.length != 0) {
        temp = stk.pop();
        while ((stk.length != 0) &&
            (stk2[stk2.length - 1] < temp)) {
            stk.push(stk2.pop())
        }
        stk2.push(temp);
    }
    while (stk2.length !== 0) {
        stk.push(stk2.pop())
    }
}

// Testing code.
function test3() {
    const stk = [];
    stk.push(1);
    stk.push(3);
    stk.push(2);
    stk.push(4);
    console.log(stk);
    sortStack2(stk)
    console.log(stk);
}

test3()

// [ 1, 2, 3, 4, 5 ]

function bottomInsert(stk: Array<number>, element: number) {
    let temp: number;
    if (stk.length == 0)
        stk.push(element);
    else {
        temp = stk.pop();
        bottomInsert(stk, element);
        stk.push(temp);
    }
}

// Testing code.
function test4() {
    const stk = [];
    stk.push(1);
    stk.push(2);
    stk.push(3);
    bottomInsert(stk, 4)
    console.log(stk);
}

//test4()

// [ 4, 1, 2, 3 ]

function reverseStack(stk: any[]): void {
    if (stk.length == 0) {
        return;
    } else {
        const value = stk.pop();
        reverseStack(stk);
        bottomInsert(stk, value);
    }
}

function reverseStack2(stk: any[]): void {
    let que: Queue<number> = new Queue<number>();

    while (stk.length > 0) {
        que.add(stk.pop());
    }

    while (que.isEmpty() === false) {
        stk.push(que.remove());
    }
}

function reverseStack3(stk: any[]): void {
    if (stk.length == 0) {
        return;
    } else {
        let lower = 0;
        let upper = stk.length - 1;
        let temp: any;
        while (lower < upper) {
            temp = stk[lower];
            stk[lower] = stk[upper];
            stk[upper] = temp;
            lower++;
            upper--;
        }
    }
}

// Testing code.
function test5(): void {
    const stk: any[] = [];
    stk.push(1);
    stk.push(2);
    stk.push(3);
    console.log("Stack before reversal", stk);
    reverseStack(stk);
    console.log("Stack after reversal", stk);
    reverseStack2(stk);
    console.log("Stack after reversal", stk);
    reverseStack3(stk);
    console.log("Stack after reversal", stk);

}

//test5()

/*
Stack before reversal [ 1, 2, 3 ]
Stack after reversal [ 3, 2, 1 ]
*/

function reverseKElementInStack(stk: Array<number>, k: number) {
    let que: Queue<number> = new Queue<number>();
    let i: number = 0;
    while (stk.length != 0 && i < k) {
        que.add(stk.pop());
        i++;
    }
    while (!que.isEmpty()) {
        stk.push(que.remove())
    }
}


// Testing code.
function test6() {
    const stk = [];
    stk.push(1);
    stk.push(2);
    stk.push(3);
    stk.push(4);
    reverseKElementInStack(stk, 2)
    console.log(stk);
}

//test6()

/*
[ 1, 2, 4, 3 ]
*/


function reverseQueue<T>(que: Queue<T>): void {
    const stk: T[] = [];
    while (!que.isEmpty()) {
        stk.push(que.remove());
    }
    while (stk.length > 0) {
        que.add(stk.pop()!);
    }
}


// Testing code.
function test7() {
    let que: Queue<number> = new Queue<number>();
    que.add(1);
    que.add(2);
    que.add(3);
    console.log(que)
    reverseQueue(que)
    console.log(que);
}

//test7()

/*
Deque { arr: [ 1, 2, 3 ] }
Deque { arr: [ 3, 2, 1 ] }
*/


function reverseKElementInQueue(que: Queue<number>, k: number) {
    let stk: Array<number> = new Array<number>();
    let i: number = 0;
    let diff: number;
    let temp: number;
    while (!que.isEmpty() && i < k) {
        stk.push(que.remove());
        i++;
    }
    while (stk.length != 0) {
        que.add(stk.pop());
    }
    diff = que.size() - k;
    while (diff > 0) {
        temp = que.remove();
        que.add(temp);
        diff -= 1;
    }
}


// Testing code.
function test8() {
    let que: Queue<number> = new Queue<number>();
    que.add(1);
    que.add(2);
    que.add(3);
    que.add(4);
    console.log(que)
    reverseKElementInQueue(que, 2)
    console.log(que);
}

test8()

/*
Deque { arr: [ 1, 2, 3, 4 ] }
Deque { arr: [ 2, 1, 3, 4 ] }
*/

function isBalancedParenthesis(expn: string): boolean {
    const stk: string[] = [];
    for (let index = 0; index < expn.length; index++) {
        const ch: string = expn[index];
        switch (ch) {
            case '{':
            case '[':
            case '(':
                stk.push(ch);
                break;
            case '}':
                if (stk.pop() !== '{') {
                    return false;
                }
                break;
            case ']':
                if (stk.pop() !== '[') {
                    return false;
                }
                break;
            case ')':
                if (stk.pop() !== '(') {
                    return false;
                }
                break;
        }
    }
    return stk.length === 0;
}

// Testing code.
function test9() {
    const expn = "{()}[]";
    const value = isBalancedParenthesis(expn);
    console.log(`Given Expn:${expn}`);
    console.log(`Is Balanced Parenthesis : ${value}`);
}

test9()

/*
Given Expn:{()}[]
Is Balanced Parenthesis : true
*/


function maxDepthParenthesis(expn: string, size: number): number {
    let stk: Array<string> = new Array<string>();
    let maxDepth: number = 0;
    let depth: number = 0;
    let ch: string;
    for (let i: number = 0; i < size; i++) {
        ch = expn.charAt(i);
        if (ch == '(') {
            stk.push(ch);
            depth += 1;
        } else if (ch == ')') {
            stk.pop();
            depth -= 1;
        }
        if (depth > maxDepth) maxDepth = depth;
    }
    return maxDepth;
}

function maxDepthParenthesis2(expn: string, size: number): number {
    let maxDepth: number = 0;
    let depth: number = 0;
    let ch: string;
    for (let i: number = 0; i < size; i++) {
        ch = expn.charAt(i);
        if (ch == '(')
            depth += 1;
        else if (ch == ')')
            depth -= 1;
        if (depth > maxDepth)
            maxDepth = depth;
    }
    return maxDepth;
}

// Testing code.
function test10() {
    const expn = "((((A)))((((BBB()))))()()()())";
    const size = expn.length;
    const value = maxDepthParenthesis(expn, size);
    const value2 = maxDepthParenthesis2(expn, size);
    console.log(`Given expn ${expn}`);
    console.log(`Max depth parenthesis is ${value}`);
    console.log(`Max depth parenthesis is ${value2}`);
}

test10()

/*
Max depth parenthesis is 6
Max depth parenthesis is 6
*/

function longestContBalParen(str: string, size: number): number {
    let stk: Array<number> = new Array<number>();
    stk.push(-1);
    let length: number = 0;
    for (let i: number = 0; i < size; i++) {
        if (str[i] == '(')
            stk.push(i);
        else {
            stk.pop();
            if (stk.length !== 0)
                length = Math.max(length, i - stk[stk.length - 1]);
            else
                stk.push(i);
        }
    }
    return length;
}

// Testing code.
function test11() {
    const expn = "())((()))(())()(()";
    const size = expn.length;
    const value = longestContBalParen(expn, size);
    console.log(`longestContBalParen : ${value}`);
}

test11()

//longestContBalParen : 12


function reverseParenthesis(expn: string, size: number): number {
    let stk: Array<string> = new Array<string>();
    let openCount: number = 0;
    let closeCount: number = 0;
    let ch: string;
    if (size % 2 === 1) {
        console.log("Invalid odd length " + size);
        return -1;
    }
    for (let i: number = 0; i < size; i++) {
        ch = expn.charAt(i);
        if (ch == '(')
            stk.push(ch);
        else if (ch == ')')
            if (stk.length !== 0 && stk[stk.length - 1] == '(')
                stk.pop();
            else
                stk.push(')');
    }
    while (stk.length !== 0) {
        if (stk.pop() == '(')
            openCount += 1;
        else
            closeCount += 1;
    }
    let reversal: number = Math.ceil(openCount / 2.0) +
        Math.ceil(closeCount / 2.0);
    return reversal;
}

// Testing code.
function test12() {
    const expn = ")(())(((";
    const size = expn.length;
    const value = reverseParenthesis(expn, size);
    console.log(`Reverse Parenthesis is: ${value}`);
}

test12()

// Reverse Parenthesis is: 3


function findDuplicateParenthesis(expn: string, size: number): boolean {
    let stk: Array<string> = new Array<string>();
    let ch: string;
    let count: number;
    for (let i: number = 0; i < size; i++) {
        ch = expn[i];
        if (ch == ')') {
            count = 0;
            while (stk.length !== 0 && stk[stk.length - 1] != '(') {
                stk.pop();
                count += 1;
            }
            if (count <= 1)
                return true;
        }
        else
            stk.push(ch);
    }
    return false;
}

// Testing code.
function test13() {
    const expn = "(((a+b))+c)";
    const size = expn.length;
    const value = findDuplicateParenthesis(expn, size);
    console.log(`Duplicate Found: ${value}`);
}

test13()

//Duplicate Found: true

function printParenthesisNumber(expn: string, size: number) {
    let ch: string;
    let stk: Array<number> = new Array<number>();
    let output: string = "";
    let count: number = 1;
    for (let i: number = 0; i < size; i++) {
        ch = expn[i];
        if (ch == '(') {
            stk.push(count);
            output += count;
            count += 1;
        }
        else if (ch == ')')
            output += stk.pop();
    }
    console.log("Parenthesis Count ", output);
}

// Testing code.
function test14() {
    const expn1 = "(((a+(b))+(c+d)))";
    const expn2 = "(((a+b))+c)(((";
    let size = expn1.length;
    console.log(`Given expn ${expn1}`);
    printParenthesisNumber(expn1, size);
    size = expn2.length;
    console.log(`Given expn ${expn2}`);
    printParenthesisNumber(expn2, size);
}

test14()

/*
Given expn (((a+(b))+(c+d)))
Parenthesis Count :  1234435521
Given expn (((a+b))+c)(((
Parenthesis Count :  123321456
*/

function precedence(x: number): number {
    if (x == '('.charCodeAt(0)) {
        return (0);
    }
    if (x == '+'.charCodeAt(0) || x == '-'.charCodeAt(0)) {
        return (1);
    }
    if (x == '*'.charCodeAt(0) || x == '/'.charCodeAt(0) || x == '%'.charCodeAt(0)) {
        return (2);
    }
    if (x == '^'.charCodeAt(0)) {
        return (3);
    }
    return (4);
}

function infixToPostfix(expn: string): string {
    let stk: Array<string> = new Array<string>();
    let output: string = "";
    let out: string;
    for (let index = 0; index < expn.length; index++) {
        let ch = expn[index];
        if (ch <= '9' && ch >= '0') {
            output = output + ch;
        } else {
            switch (ch) {
                case '+':
                case '-':
                case '*':
                case '/':
                case '%':
                case '^':
                    while (stk.length != 0 &&
                        precedence(ch.charCodeAt(0)) <= precedence(stk[stk.length - 1].charCodeAt(0))) {
                        out = stk.pop();
                        output = output + " " + out;
                    }
                    stk.push(ch);
                    output = output + " ";
                    break;
                case '(':
                    stk.push(ch);
                    break;
                case ')':
                    while (stk.length != 0 && (out = stk.pop()) !== '(') {
                        output = output + " " + out + " ";
                    }
                    break;
            }
        }
    }
    while (stk.length != 0) {
        out = stk.pop();
        output = output + out + " ";
    }
    return output;
}

// Testing code.
function test15() {
    const expn = "10+((3))*5/(16-4)";
    const value = infixToPostfix(expn);
    console.log(`Infix Expn: ${expn}`);
    console.log(`Postfix Expn: ${value}`);
}

test15()

/*
Infix Expn: 10+((3))*5/(16-4)
Postfix Expn: 10 3 5 * 16 4 -  / +
*/

function infixToPrefix(expn: string): string {
    let arr: string[] = (expn).split('');
    reverseString(arr);
    replaceParanthesis(arr);
    let str = infixToPostfix(arr.join(''));
    arr = str.split('');
    reverseString(arr);
    expn = arr.join('');
    return expn;
}

function replaceParanthesis(expn: string[]) {
    let lower: number = 0;
    let upper: number = expn.length - 1;
    while (lower <= upper) {
        if (expn[lower].charCodeAt(0) == '('.charCodeAt(0)) {
            expn[lower] = ')';
        } else if (expn[lower].charCodeAt(0) == ')'.charCodeAt(0)) {
            expn[lower] = '(';
        }
        lower++;
    }
}

function reverseString(expn: string[]) {
    let lower: number = 0;
    let upper: number = expn.length - 1;
    let tempChar: string;
    while (lower < upper) {
        tempChar = expn[lower];
        expn[lower] = expn[upper];
        expn[upper] = tempChar;
        lower++;
        upper--;
    }
}

// Testing code.
function test16() {
    const expn = "10+((3))*5/(16-4)";
    const value = infixToPrefix(expn);
    console.log(`Infix Expn: ${expn}`);
    console.log(`Prefix Expn: ${value}`);
}

test16()

/*
Infix Expn: 10+((3))*5/(16-4)
Prefix Expn: + 10 * 3 / 5  - 16 4
*/

function postfixEvaluate(expn: string): number {
    const stk: number[] = [];
    let temp: number;
    const tokens: string[] = expn.split(" ");
    for (const tok of tokens) {
        temp = parseInt(tok);
        if (!isNaN(temp)) {
            stk.push(temp);
        } else {
            const num1 = stk.pop();
            const num2 = stk.pop();
            const op = tok;
            switch (op) {
                case '+':
                    stk.push(num1 + num2);
                    break;
                case '-':
                    stk.push(num2 - num1);
                    break;
                case '*':
                    stk.push(num1 * num2);
                    break;
                case '/':
                    stk.push(num2 / num1);
                    break;
            }
        }
    }
    return stk.pop();
}

// Testing code.
function test17(): void {
    const expn = "6 5 2 3 + 8 * + 3 + *";
    const value = postfixEvaluate(expn);
    console.log(`Given Postfix Expn: ${expn}`);
    console.log(`Result after Evaluation: ${value}`);
}

test17();

/*
Given Postfix Expn: 6 5 2 3 + 8 * + 3 + *
Result after Evaluation: 288
*/

function StockSpanRange(arr: Array<number>): Array<number> {
    let SR: Array<number> = new Array<number>(arr.length);
    SR[0] = 1;
    for (let i: number = 1; i < arr.length; i++) {
        SR[i] = 1;
        for (let j: number = i - 1; (j >= 0) && (arr[i] >= arr[j]); j--) {
            SR[i]++;
        }
    }
    return SR;
}

function StockSpanRange2(arr: Array<number>): Array<number> {
    let stk: Array<number> = new Array<number>();
    let SR: Array<number> = new Array<number>(arr.length);
    stk.push(0);
    SR[0] = 1;
    for (let i: number = 1; i < arr.length; i++) {
        while ((stk.length != 0) && arr[stk[stk.length - 1]] <= arr[i]) {
            stk.pop();
        }
        SR[i] = (stk.length == 0) ? (i + 1) : (i - stk[stk.length - 1]);
        stk.push(i);
    }
    return SR;
}

// Testing code.
function test18() {
    let arr = [6, 5, 4, 3, 2, 4, 5, 7, 9];
    let value = StockSpanRange(arr);
    console.log("StockSpanRange:", value);

    arr = [6, 5, 4, 3, 2, 4, 5, 7, 9];
    value = StockSpanRange2(arr);
    console.log("StockSpanRange:", value);
}

test18()

/*
StockSpanRange: [ 1, 1, 1, 1, 1, 4, 6, 8, 9 ]
StockSpanRange: [ 1, 1, 1, 1, 1, 4, 6, 8, 9 ]
*/

function GetMaxArea(arr: Array<number>): number {
    let size: number = arr.length;
    let maxArea: number = -1;
    let currArea: number;
    let minHeight: number = 0;
    for (let i: number = 1; i < size; i++) {
        minHeight = arr[i];
        for (let j: number = i - 1; j >= 0; j--) {
            if (minHeight > arr[j]) {
                minHeight = arr[j];
            }
            currArea = minHeight * (i - j + 1);
            if (maxArea < currArea) {
                maxArea = currArea;
            }
        }
    }
    return maxArea;
}

function GetMaxArea2(arr: Array<number>): number {
    let size: number = arr.length;
    let stk: Array<number> = new Array<number>();
    let maxArea: number = 0;
    let top: number;
    let topArea: number;
    let i: number = 0;
    while (i < size) {
        while ((i < size) && ((stk.length == 0)
            || arr[stk[stk.length - 1]] <= arr[i])) {
            stk.push(i);
            i++;
        }
        while ((stk.length != 0) &&
            (i === size || arr[stk[stk.length - 1]] > arr[i])) {
            top = stk[stk.length - 1];
            stk.pop();
            topArea = arr[top] *
                ((stk.length == 0) ? i : i - stk[stk.length - 1] - 1);
            if (maxArea < topArea) {
                maxArea = topArea;
            }
        }
    }
    return maxArea;
}

// Testing code.
function test19() {
    const arr = [7, 6, 5, 4, 4, 1, 6, 3, 1];
    const size = arr.length;
    let value = GetMaxArea(arr);
    console.log(`GetMaxArea: ${value}`);

    value = GetMaxArea2(arr);
    console.log(`GetMaxArea: ${value}`);
}

test19()

/*
GetMaxArea: 20
GetMaxArea: 20
*/

function stockAnalystAdd(stk: number[], value: number): void {
    while (stk.length > 0 && stk[stk.length - 1] <= value)
        stk.pop();
    stk.push(value);
}

function test19a(): void {
    let arr: number[] = [20, 19, 10, 21, 40, 35, 39, 50, 45, 42];
    let stk: number[] = [];
    for (let i = arr.length - 1; i >= 0; i--)
        stockAnalystAdd(stk, arr[i]);
    console.log(stk);
}

test19a();
// [50, 40, 21, 20]

function nextLargerElement(arr: number[], size: number): void {
    const output: number[] = new Array(size);
    let outIndex = 0;
    let next: number;
    for (let i = 0; i < size; i++) {
        next = -1;
        for (let j = i + 1; j < size; j++) {
            if (arr[i] < arr[j]) {
                next = arr[j];
                break;
            }
        }
        output[outIndex++] = next;
    }

    console.log(output);
}

function nextLargerElement2(arr: number[], size: number): void {
    const stk: number[] = [];
    const output: number[] = new Array(size);
    let index = 0;
    let curr: number;
    for (let i = 0; i < size; i++) {
        curr = arr[i];
        while (stk.length > 0 && arr[stk[stk.length - 1]] <= curr) {
            index = stk.pop();
            output[index] = curr;
        }
        stk.push(i);
    }

    while (stk.length > 0) {
        index = stk.pop();
        output[index] = -1;
    }
    console.log(output);
}

function nextSmallerElement(arr: number[], size: number): void {
    const output: number[] = new Array(size);
    output.fill(-1);
    for (let i = 0; i < size; i++) {
        for (let j = i + 1; j < size; j++) {
            if (arr[j] < arr[i]) {
                output[i] = arr[j];
                break;
            }
        }
    }
    console.log(output);
}

function nextSmallerElement2(arr: number[], size: number): void {
    const stk: number[] = [];
    const output: number[] = new Array(size);
    let curr: number;
    let index: number;
    for (let i = 0; i < size; i++) {
        curr = arr[i];
        while (stk.length > 0 && arr[stk[stk.length - 1]] > curr) {
            index = stk.pop();
            output[index] = curr;
        }
        stk.push(i);
    }

    while (stk.length > 0) {
        index = stk.pop();
        output[index] = -1;
    }

    console.log(output);
}

// Testing code.
function test20(): void {
    const arr: number[] = [13, 21, 3, 6, 20, 3];
    const size: number = arr.length;
    nextLargerElement(arr, size);
    nextLargerElement2(arr, size);
    nextSmallerElement(arr, size);
    nextSmallerElement2(arr, size);
}

test20();

/*
[ 21, -1, 6, 20, -1, -1 ]
[ 21, -1, 6, 20, -1, -1 ]
[ 3, 3, -1, 3, 3, -1 ]
[ 3, 3, -1, 3, 3, -1 ]
*/


function nextLargerElementCircular(arr: number[], size: number): void {
    const output: number[] = new Array(size);
    output.fill(-1);
    for (let i = 0; i < size; i++) {
        for (let j = 1; j < size; j++) {
            if (arr[i] < arr[(i + j) % size]) {
                output[i] = arr[(i + j) % size];
                break;
            }
        }
    }
    console.log(output);
}

function nextLargerElementCircular2(arr: number[], size: number): void {
    const stk: number[] = [];
    let curr: number;
    let index: number;
    const output: number[] = new Array(size);
    for (let i = 0; i < 2 * size - 1; i++) {
        curr = arr[i % size];
        while (stk.length > 0 && arr[stk[stk.length - 1]] <= curr) {
            index = stk.pop();
            output[index] = curr;
        }
        stk.push(i % size);
    }

    while (stk.length > 0) {
        index = stk.pop();
        output[index] = -1;
    }
    console.log(output);
}

// Testing code.
function test21(): void {
    const arr: number[] = [6, 3, 9, 8, 10, 2, 1, 15, 7];
    const size: number = arr.length;
    nextLargerElementCircular(arr, size);
    nextLargerElementCircular2(arr, size);
}

test21();

/*
[ 9, 9, 10, 10, 15, 15, 15, -1, 9 ]
*/

function isKnown(relation: number[][], a: number, b: number): boolean {
    if (relation[a][b] === 1)
        return true;
    return false;
}

function findCelebrity(relation: number[][], count: number): number {
    let cel: boolean = true;
    for (let i = 0; i < count; i++) {
        cel = true;
        for (let j = 0; j < count; j++) {
            if (i !== j && (!isKnown(relation, j, i) || isKnown(relation, i, j))) {
                cel = false;
                break;
            }
        }
        if (cel === true)
            return i;
    }
    return -1;
}

function findCelebrity2(relation: number[][], count: number): number {
    const stk: number[] = [];
    let first: number = 0, second: number = 0;
    for (let i = 0; i < count; i++) {
        stk.push(i);
    }
    first = stk.pop();

    while (stk.length !== 0) {
        second = stk.pop();
        if (isKnown(relation, first, second))
            first = second;
    }

    for (let i = 0; i < count; i++) {
        if (first !== i && isKnown(relation, first, i))
            return -1;
        if (first !== i && isKnown(relation, i, first) === false)
            return -1;
    }
    return first;
}

function findCelebrity3(relation: number[][], count: number): number {
    let first: number = 0;
    let second: number = 1;

    for (let i = 0; i < count - 1; i++) {
        if (isKnown(relation, first, second))
            first = second;
        second = second + 1;
    }

    for (let i = 0; i < count; i++) {
        if (first !== i && isKnown(relation, first, i))
            return -1;
        if (first !== i && isKnown(relation, i, first) === false)
            return -1;
    }
    return first;
}

// Testing code.
function test26(): void {
    const arr: number[][] = [
        [1, 0, 1, 1, 0],
        [1, 0, 0, 1, 0],
        [0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0],
        [1, 1, 0, 1, 1]
    ];

    console.log(`Celebrity : ${findCelebrity(arr, 5)}`);
    console.log(`Celebrity : ${findCelebrity2(arr, 5)}`);
    console.log(`Celebrity : ${findCelebrity3(arr, 5)}`);
}

test26();

/*
Celebrity : 3
Celebrity : 3
*/
