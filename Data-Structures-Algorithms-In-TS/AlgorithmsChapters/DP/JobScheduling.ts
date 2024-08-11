class Job {
	start: number;
	stop: number;
	value: number;

	constructor(s: number, f: number, v: number) {
		this.start = s;
		this.stop = f;
		this.value = v;
	}

	compareTo(j2: Job): number {
		return this.stop - j2.stop;
	}
}

function maxValueJobUtil(arr: Job[], n: number): number {
	// Base case
	if (n === 1)
		return arr[0].value;

	// Find Value when current job is included
	let incl = arr[n - 1].value;
	for (let j = n - 1; j >= 0; j--) {
		if (arr[j].stop <= arr[n - 1].start) {
			incl += maxValueJobUtil(arr, j + 1);
			break;
		}
	}

	// Find Value when current job is excluded
	const excl = maxValueJobUtil(arr, n - 1);

	return Math.max(incl, excl);
}

function maxValueJobs(start: number[], finish: number[], value: number[], n: number): number {
	const act: Job[] = [];
	for (let i = 0; i < n; i++)
		act[i] = new Job(start[i], finish[i], value[i]);

	act.sort((j1, j2) => j1.compareTo(j2)); // sort according to finish time.

	return maxValueJobUtil(act, n);
}

function maxValueJobUtilTD(dp: number[], arr: Job[], n: number): number {
	// Base case
	if (n === 0)
		return 0;

	if (dp[n - 1] !== 0) {
		return dp[n - 1];
	}

	// Find Value when current job is included
	let incl = arr[n - 1].value;
	for (let j = n - 2; j >= 0; j--) {
		if (arr[j].stop <= arr[n - 1].start) {
			incl += maxValueJobUtilTD(dp, arr, j + 1);
			break;
		}
	}

	// Find Value when current job is excluded
	const excl = maxValueJobUtilTD(dp, arr, n - 1);
	dp[n - 1] = Math.max(incl, excl);

	return dp[n - 1];
}

function maxValueJobsTD(start: number[], finish: number[], value: number[], n: number): number {
	const act: Job[] = [];
	for (let i = 0; i < n; i++)
		act[i] = new Job(start[i], finish[i], value[i]);

	act.sort((j1, j2) => j1.compareTo(j2)); // sort according to finish time.

	const dp: number[] = new Array(n).fill(0);
	return maxValueJobUtilTD(dp, act, n);
}

function maxValueJobsBU(start: number[], finish: number[], value: number[], n: number): number {
	const act: Job[] = [];
	for (let i = 0; i < n; i++)
		act[i] = new Job(start[i], finish[i], value[i]);

	act.sort((j1, j2) => j1.compareTo(j2)); // sort according to finish time.

	const dp: number[] = new Array(n).fill(0);
	dp[0] = act[0].value;

	for (let i = 1; i < n; i++) {
		let incl = act[i].value;
		for (let j = i - 1; j >= 0; j--) {
			if (act[j].stop <= act[i].start) {
				incl += dp[j];
				break;
			}
		}
		dp[i] = Math.max(incl, dp[i - 1]);
	}

	return dp[n - 1];
}

const start = [1, 5, 0, 3, 5, 6, 8];
const finish = [2, 6, 5, 4, 9, 7, 9];
const value = [2, 2, 4, 3, 10, 2, 8];
const n = start.length;

console.log(maxValueJobs(start, finish, value, n)); // 17
console.log(maxValueJobsTD(start, finish, value, n)); // 17
console.log(maxValueJobsBU(start, finish, value, n)); // 17

/*
17
17
17
*/
