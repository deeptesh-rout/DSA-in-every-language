// Check if the whole graph is coloured properly.
function isSafe2(graph: boolean[][], colour: number[], V: number): boolean {
    for (let i = 0; i < V; i++) {
        for (let j = i + 1; j < V; j++) {
            if (graph[i][j] && colour[j] === colour[i]) {
                return false;
            }
        }
    }
    return true;
}

function graphColouring2Util(graph: boolean[][], V: number, m: number, colour: number[], i: number): boolean {
    if (i === V) {
        if (isSafe2(graph, colour, V)) {
            console.log("Assigned colours are: " + colour.join(", "));
            return true;
        }
        return false;
    }

    for (let j = 1; j <= m; j++) {
        colour[i] = j;
        if (graphColouring2Util(graph, V, m, colour, i + 1)) {
            return true;
        }
    }
    return false;
}

function graphColouring2(graph: boolean[][], V: number, m: number): boolean {
    const colour: number[] = new Array(V).fill(0);
    if (graphColouring2Util(graph, V, m, colour, 0)) {
        return true;
    }
    return false;
}

// Is it safe to colour vth vertice with c colour.
function isSafe(graph: boolean[][], V: number, colour: number[], v: number, c: number): boolean {
    for (let i = 0; i < V; i++) {
        if (graph[v][i] && c === colour[i]) {
            return false;
        }
    }
    return true;
}

function graphColouringUtil(graph: boolean[][], V: number, m: number, colour: number[], i: number): boolean {
    if (i === V) {
        console.log("Assigned colours are: " + colour.join(", "));
        return true;
    }

    for (let j = 1; j <= m; j++) {
        if (isSafe(graph, V, colour, i, j)) {
            colour[i] = j;
            if (graphColouringUtil(graph, V, m, colour, i + 1)) {
                return true;
            }
        }
    }
    return false;
}

function graphColouring(graph: boolean[][], V: number, m: number): boolean {
    const colour: number[] = new Array(V).fill(0);
    if (graphColouringUtil(graph, V, m, colour, 0)) {
        return true;
    }
    return false;
}

const graph: boolean[][] = [
    [false, true, false, false, true],
    [true, false, true, false, true],
    [false, true, false, true, true],
    [false, false, true, false, true],
    [true, true, true, true, false]
];

const V: number = 5; // Number of vertices
const m: number = 4; // Number of colours

if (!graphColouring2(graph, V, m)) {
    console.log("Solution does not exist.");
}

if (!graphColouring(graph, V, m)) {
    console.log("Solution does not exist.");
}

/*
Assigned colours are: 1, 2, 1, 2, 3
Assigned colours are: 1, 2, 1, 2, 3
*/
