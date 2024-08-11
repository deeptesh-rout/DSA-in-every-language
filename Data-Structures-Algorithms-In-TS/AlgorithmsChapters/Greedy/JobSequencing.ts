class Job {
	id: string;
	deadline: number;
	profit: number;

	constructor(id: string, deadline: number, profit: number) {
		this.id = id;
		this.deadline = deadline;
		this.profit = profit;
	}
}

class JobSequencing {
	jobs: Job[];
	n: number;
	maxDL: number;

	constructor(ids: string[], deadlines: number[], profits: number[], n: number) {
		this.jobs = new Array<Job>(n);
		this.n = n;
		this.maxDL = Math.max(...deadlines);

		for (let i = 0; i < n; i++) {
			this.jobs[i] = new Job(ids[i], deadlines[i], profits[i]);
		}
	}

	print(): void {
		this.jobs.sort((a, b) => b.profit - a.profit);
		const result: boolean[] = new Array<boolean>(this.maxDL).fill(false);
		const job: string[] = new Array<string>(this.maxDL);
		let profit = 0;

		for (let i = 0; i < this.n; i++) {
			for (let j = this.jobs[i].deadline - 1; j >= 0; j--) {
				if (!result[j]) {
					result[j] = true;
					job[j] = this.jobs[i].id;
					profit += this.jobs[i].profit;
					break;
				}
			}
		}

		console.log("Profit is:", profit);
		let output = "Jobs selected are:";
		for (let i = 0; i < this.maxDL; i++) {
			if (job[i] !== undefined) {
				output += " " + job[i];
			}
		}
		console.log(output);
	}
}

const ids: string[] = ['a', 'b', 'c', 'd', 'e'];
const deadlines: number[] = [3, 1, 2, 4, 4];
const profits: number[] = [50, 40, 27, 31, 30];
const jobSequencing: JobSequencing = new JobSequencing(ids, deadlines, profits, 5);
jobSequencing.print();

/*
Profit is: 151
Jobs selected are: b e a d
*/
