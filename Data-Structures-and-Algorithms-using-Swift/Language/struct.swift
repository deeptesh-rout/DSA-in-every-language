struct student {
	var rollNo : Int = 0
	var name : String = ""
}

func main() {
	let stud = student(rollNo : 1, name : "johny") 
	print(stud) 
	print("Student name ::",stud.name) // Accessing inner fields.

	print(student(rollNo : 2, name : "Ann")) // Named initialization.
	print(student()) // Default initialization
}

main()

/*
student(rollNo: 1, name: "johny")
Student name :: johny
student(rollNo: 2, name: "Ann")
student(rollNo: 0, name: "")
*/