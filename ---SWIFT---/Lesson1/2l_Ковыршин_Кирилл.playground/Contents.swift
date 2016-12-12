import Foundation
import UIKit

//Задание 1

//Функция проверки четное-не четное
func isEven(number: Int?) -> Bool{
    
    if let tmpNumber = number {
        tmpNumber
        if number! % 2 == 0 {
            return true
        } else {
            return false
        }
    }
   return false
}

//Функция проверки деления на 3
func checkDividingByThree(number: Int?) -> Bool{
    
    if let tmpNumber = number {
        tmpNumber
        if number! % 3 == 0 {
            return true
        } else {
            return false
        }
    }
    return false
}

print("------")

// Создаем возрастающий массив из 100 чисел
var ourArray = Array(0..<101)

//
// Проверяем на четность, не четность
//

//Вспомогательные массивы
var evenArray = [Int]()
var notEvenArray = [Int]()

//Разберем основной массив на два массива четных и не четных чисел
for i in ourArray{
    
    //Нечетные
    if isEven(number: i){
        evenArray.append(ourArray.index(of: i)!)
    }else{
        notEvenArray.append(ourArray.index(of: i)!)
    }
}
print("Нечетные числа:\n\(notEvenArray)")
print("------")
print("Четные числа:\n\(evenArray)")


//
// Проверяем на деление на 3
//

//Вспомогательные массивы
var dividingArray = [Int]()
var notDividingArray = [Int]()

//Разберем основной массив на два массива, числа которые делятся на 3 и не делятся

for i in ourArray{
    
    if checkDividingByThree(number: i){
        dividingArray.append(ourArray.index(of: i)!)
    }else{
        notDividingArray.append(ourArray.index(of: i)!)
    }
    
}

print("\n\nЧисла, которые делятся на 3:\n\(dividingArray)")
print("------")
print("Числа, которые на не делятся на 3:\n\(notDividingArray)")



//Удаляем все четные числа и которые не делятся на 3

for i in ourArray{
    
    if isEven(number: i) || !checkDividingByThree(number: i){
        ourArray.remove(at: ourArray.index(of: i)!)
    }
}
print("------")
print("Новый массив с четными числами, которые делятся на 3:\n\(ourArray)")
print("------")


//Задание 2
var limit = 545



func SieveofEratosthenes(size: Int) -> [Bool]
{
    //генерируем массив от 2 до limit, и вспомогательный массив со значениям true/false
    // первые два это заведомо false 0 и 1
    var resultBool = [false, false] + [Bool](repeating: true, count: size - 1)
    
    //Проходимся по массиву, и вычеркиваем(помечаем как false не нужные числа
    for p in 2 ... size {
        if resultBool[p] {
            
/*
 Функция stride в Swift задает последовательность значений какого-либо «шагового» (strideable) типа. Шаговые (strideable) типы – это одномерные значения, которые можно задать для указания интервала. Допустим, вы хотите получить последовательность чисел с плавающей запятой в диапазоне от 0,0 до 8Π – для этого в Swift достаточно двух функций: stride для создания последовательности и map для применения функции.
 */
            for f in stride(from: p * p, through: size, by: p) {
                resultBool[f] = false
            }
        }
    }
    return resultBool
}
//Получаем наши числа
let result: [Int] = SieveofEratosthenes(size: limit).enumerated().reduce([Int]()) {
    index, value in let (offset, element) = value
    if element {
        return index + [offset]
    }else{
        return index
    }  
}
print("Количество простых чисел от 2 до \(limit): \(result.count)")
print("Простые числа:\n\(result)")
print("------")







