let str1: string = "hello";
let str2: string = "hello";
let str3: string = "Hello";
console.log("str1 equals str2 :" + /* equals */(<any>((o1: any, o2: any) => { if (o1 && o1.equals) { return o1.equals(o2); } else { return o1 === o2; } })(str1, str2)));
console.log("str1 equals str3 :" + /* equals */(<any>((o1: any, o2: any) => { if (o1 && o1.equals) { return o1.equals(o2); } else { return o1 === o2; } })(str1, str3)));