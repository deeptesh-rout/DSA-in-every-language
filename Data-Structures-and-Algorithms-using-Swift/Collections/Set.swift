// Create a hash set.
var hs : Set<String> = Set<String>()

// Add elements to the hash set.
hs.insert("Banana")
hs.insert("Apple")
hs.insert("Mango")
print(hs)

print("Grapes present : " + String(hs.contains("Grapes")))
print("Apple present : " + String(hs.contains("Apple")))

hs.remove("Apple")
print(hs)
print("Apple present : " + String(hs.contains("Apple")))

/* 
["Banana", "Apple", "Mango"]
Grapes present : false
Apple present : true
["Banana", "Mango"]
Apple present : false
 */