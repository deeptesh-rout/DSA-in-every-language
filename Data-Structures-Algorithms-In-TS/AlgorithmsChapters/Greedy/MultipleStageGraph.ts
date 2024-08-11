const INF: number = Number.MAX_VALUE;

function shortestDist(graph: number[][], n: number): number {
  const dist: number[] = new Array(n).fill(INF);
  const path: number[] = new Array(n);
  let value: number;

  dist[0] = 0;
  path[0] = -1;

  for (let i = 0; i < n; i++) {
    for (let j = i; j < n; j++) {
      if (graph[i][j] === INF) continue;

      value = graph[i][j] + dist[i];
      if (dist[j] > value) {
        dist[j] = value;
        path[j] = i;
      }
    }
  }

  value = n - 1;
  let output = "";
  while (value !== -1) {
    output += `${value} `;
    value = path[value];
  }
  console.log(output);
  return dist[n - 1];
}

const graph: number[][] = [
  [INF, 1, 2, 5, INF, INF, INF, INF],
  [INF, INF, INF, INF, 4, 11, INF, INF],
  [INF, INF, INF, INF, 9, 5, 16, INF],
  [INF, INF, INF, INF, INF, INF, 2, INF],
  [INF, INF, INF, INF, INF, INF, INF, 18],
  [INF, INF, INF, INF, INF, INF, INF, 13],
  [INF, INF, INF, INF, INF, INF, INF, 2],
  [INF, INF, INF, INF, INF, INF, INF, INF],
];
console.log("Shortest distance:", shortestDist(graph, 8));

/*
7 6 3 0 
Shortest distance: 9
*/