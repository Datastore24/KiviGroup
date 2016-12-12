import Foundation
//Tuples - картеж

let simpleTuple = (1, "Hello", true, 2.4)

let (number, greatings, check, decimal) = simpleTuple

number
greatings
check
decimal

let (_,_,check2,_) = simpleTuple
check2

simpleTuple.0
simpleTuple.1
simpleTuple.2
simpleTuple.3


var tuple = (index:1, phrase:"Hello", registered:true, latency:2.4)
tuple.index
tuple.phrase
tuple.registered
tuple.latency

//Изменение картежа
tuple.index = 2

let (redColor, greenColor, blueColor) = ("red","green","blue")

redColor
greenColor
blueColor

let totalNumber = 5
let merchantName = "QIWI"
print((totalNumber,merchantName));
print(simpleTuple)

///////

//Опциональные значения
var apples : Int? = 5

//apples = nil

if apples == nil {
    print("nil apples");
}else{
    let a = apples! + 2
    
}

//Optional Biding 

if var number = apples {
    number = number + 2
}else{
    print("nil apples");
}


let age = "22sdfs"

let ageInt: Int? = Int(age)


if let ageNumber = ageInt {
    ageNumber
    if ageNumber > 20 {
        print("Very cool")
    }
}


//Int
//Int?
//Int!

var apples2 : Int! = nil

apples2 = 2


apples2 = apples2 + 5

////// Базовые операторы

var small: UInt8 = 0xff
//
small = 0b1111_1111
small = small &+ 5

//Строки
//var str = String()
var str = "c"

str = str + "a"
str += "b"

var a = 5
var b = a

a += 1
b


var str1 = "a"
var str2 = str1


str1 = "b"
str2

str1.isEmpty

let char : Character = "x"

for c in "Hello World!".characters{
 print(c)
}

str + String(char)
str.append(char)

(str as NSString).length
NSString(string: str).length

str.unicodeScalars

//Юникод
let heart = "\u{1F496}"



let eAcute: Character = "\u{E9}"

let combinedEAcute: Character = "\u{E65}\u{301}"

let fun: Character = "ъ\u{301}\u{20dd}"

let string = "what is this? -> \(fun)"

string.characters.count


if(fun is String){
    print("YES")
}else{
    print("NO")
}

string

Int16.max































