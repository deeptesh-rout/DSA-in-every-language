// Create a hash map.
var hm :  [String:Int] =  [String:Int]()

// Put elements into the map
hm["Apple"] = 40
hm["Banana"] = 10
hm["Mango"] = 20
print("Size :: " + String(hm.count))
print(hm)

for key in Array(hm.keys){
	print(key + " cost : " + String(hm[key]!))
}

print("Grapes present :: " + String(hm.keys.contains("Grapes")))
print("Apple present :: " + String(hm.keys.contains("Apple")))

hm["Apple"] = nil
print("Apple present :: " + String(hm.keys.contains("Apple")))
print(hm)

/*
Size :: 3
Banana cost : 10
Mango cost : 20
Apple cost : 40
Grapes present :: false
Apple present :: true
["Banana": 10, "Mango": 20, "Apple": 40]
Apple present :: false
["Mango": 20, "Banana": 10]
*/