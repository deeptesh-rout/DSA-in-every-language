const INVALID_VALUE = Infinity;
//General Top-Down function to solve Min and Max problems:
function TopDownFunctionUtil(dp_array: number[], ways: number[], target: number): number {
  // Base Case
  if (target === 0) {
    return 0;
  }

  if (dp_array[target] !== INVALID_VALUE) {
    return dp_array[target];
  }

  // Recursion
  for (let i = 0; i < ways.length; i++) {
    dp_array[target] = Math.min(dp_array[target],
      TopDownFunctionUtil(dp_array, ways, target - ways[i]) + cost);
  }

  return dp_array[target];
}

function TopDownFunction(ways: number[], target: number): number {
  const dp_array: number[] = new Array(target + 1).fill(INVALID_VALUE);
  return TopDownFunctionUtil(dp_array, ways, target);
}

//General Bottom-Up function to solve Min-Max problems:
function BottomUpFunction(ways: number[], target: number): number {
  const dp_array: number[] = new Array(target + 1).fill(INVALID_VALUE);
  dp_array[0] = 0; // Base value.

  for (let i = 1; i <= target; i++) {
    for (let j = 0; j < ways.length; j++) {
      // For all fusible ways.
      dp_array[i] = Math.min(dp_array[i], dp_array[i - ways[j]] + cost);
    }
  }

  return dp_array[target];
}


//////////////////////////////////

//General Top-Down function to solve Distinct-Way problems:
function TopDownFunctionUtil(dp_array: number[], ways: number[], target: number): number {
  // Base Case
  if (target === 0) {
    return 0;
  }

  if (dp_array[target] !== 0) {
    return dp_array[target];
  }

  // Recursion
  for (let i = 0; i < ways.length && ways[i] <= i; i++) {
    // For all fusible ways.
    dp_array[target] += TopDownFunctionUtil(dp_array, ways, target - ways[i]);
  }

  return dp_array[target];
}

function TopDownFunction(ways: number[], target: number): number {
  const dp_array: number[] = new Array(target).fill(0);
  return TopDownFunctionUtil(dp_array, ways, target);
}

// General Bottom-Up function to solve Distinct-Way problems:
function BottomUpFunction(ways: number[], target: number): number {
  const dp_array: number[] = new Array(target).fill(0);

  for (let i = 1; i <= target; i++) {
    for (let j = 0; j < ways.length && ways[j] <= i; j++) {
      // For all fusible ways.
      dp_array[i] += dp_array[i - ways[j]];
    }
  }

  return dp_array[target];
}



////////////////////////////////////////3

function TopDownFunction(costs: number[]): number {
  const n = costs.length;

  // dp_array is a two-dimensional array n*n
  const dp_array: number[][] = Array.from({ length: n }, () => new Array(n).fill(INVALID_VALUE));

  return topDownFunctionUtil(dp_array, costs, 0, n - 1);
}

function topDownFunctionUtil(dp_array: number[][], costs: number[], i: number, j: number): number {
  // Base Case
  if (i === j) {
    return 0;
  }

  if (dp_array[i][j] !== INVALID_VALUE) {
    return dp_array[i][j];
  }

  // Recursion
  for (let k = i; k < j; k++) {
    dp_array[i][j] = Math.min(dp_array[i][j],
      topDownFunctionUtil(dp_array, costs, i, k) + costs[k] + topDownFunction(dp_array, costs, k + 1, j));
  }

  return dp_array[i][j];
}

//General Bottom-Up function to solve Merging-Interval problems:
function BottomUpFunction(costs: number[]): number {
  const n = costs.length;

  // dp_array is a two-dimensional array n*n
  const dp_array: number[][] = Array.from({ length: n }, () => new Array(n).fill(INVALID_VALUE));

  for (let l = 1; l < n; l++) { // l is the length of the range.
    for (let i = 1, j = i + l; j < n; i++, j++) {
      for (let k = i; k < j; k++) {
        dp_array[i][j] = Math.min(dp_array[i][j], dp_array[i][k] + costs[k] + dp_array[k + 1][j]);
      }
    }
  }

  return dp_array[1][n - 1];
}


///////////////////////////////////////

//Type1 : Increasing or decreasing subsequence or substring in a given string.
for (let i = 0; i < n; i++) {
  for (let j = 0; j < i; j++) {
    // incremental found pattern of sub-problem.
  }
}

//Type2 : Largest substring or subsequence in a given string.
for (let l = 1; l < n; l++) {  // Range.
  for (let i = 0, j = i + l; j < n; i++, j++) {
    // incremental calculation of sub-problem 
    // with increasing range.
  }
}

//Type3 : Comparison of two different strings.
for (let i = 1; i <= m; i++) { // First string index.
  for (let j = 1; j <= n; j++) { // Second string index.
    // Comparison of two strings.    
  }
}

/////////////////////////////////

function BottomUpFunction(costs: number[]): number {
  const n = costs.length;

  // dp_array is a two-dimensional array n*2
  const dp_array: number[][] = Array.from({ length: n }, () => new Array(2).fill(INVALID_VALUE));

  /* Initialization of 0th state of various types. */
  dp_array[0][1] = /* Initialization value */;
  dp_array[0][0] = /* Initialization value */;

  for (let i = 1; i < n; i++) {
    dp_array[i][1] = /* Max values based on previous states. */;
    dp_array[i][0] = /* Max values based on previous states. */;
  }

  return Math.max(dp_array[n - 1][1], dp_array[n - 1][0]);
}
