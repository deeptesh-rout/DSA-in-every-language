const hs = new Set<string>();
hs.add("Banana");
hs.add("Apple");
hs.add("Mango");

console.log(hs);
console.log(`Set size : ${hs.size}`);
console.log(`Apple present: ${hs.has("Apple")}`);
console.log(`Grapes present: ${hs.has("Grapes")}`);

hs.delete("Apple");
console.log(hs);
console.log(`Apple present: ${hs.has("Apple")}`);

/*
Set { 'Banana', 'Apple', 'Mango' }
Set size : 3
Apple present: true
Grapes present: false
Set { 'Banana', 'Mango' }
Apple present: false
*/
