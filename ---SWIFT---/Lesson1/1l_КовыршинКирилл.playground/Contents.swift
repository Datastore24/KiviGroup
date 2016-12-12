//: Playground - noun: a place where people can play

import UIKit

//Решим квадратное уравнение ax2 + bx + c = 0

let a: Double = 1 //Первый коэффициент
let b: Double = 3 //Второй коэффициент
let c: Double = -4 //Третий коэффициент
var discriminant: Double //Дискриминант
var x1: Double
var x2: Double

//Формула для решения квадратного уровнения x1,2 = (-b +- sqrt(b*b - 4*a*c))/2a
print("Решим квадратное уравнение \(Int(a))x2 + \(Int(b))x + \(Int(c)) = 0")
discriminant = b*b - 4*a*c

if discriminant >= 0 {
    x1 = (-b + sqrt(discriminant))/2*a
    print("x1 =",x1)
    
    x2 = (-b - sqrt(discriminant))/2*a
    print("x2 =",x2)
} else {
    print("Дискрименант меньше 0ля, корни отсутствуют")
}


print ("----------\n")

///////////////////////////
// Дано:
// Прямоугольный треугольник
// Катеты tA,tB
// Гипотинуза tC
// Найти:
// 1. Площадь
// 2. Периметр
// 3. Гипотенузу

let tA: Double = 9 //Длинный катет
let tB: Double = 12 //Короткий катет
var tC: Double //Неизвестная гипотинуза
var tP: Double //Периметр
var tS: Double //Площадь

//Найдем гипотенузу по теореме Пифагора a2 + b2 = c2

tC = sqrt(tA*tA + tB*tB) //Найдена гипотенуза
print("Гипотинуза равна ", tC)

//Найдем периметр P = a+b+c
tP = tA + tB + tC //Найден периметр
print("Периметр равен ", tP)

//Найдем площадь S = (1/2)*a*b
tS = (1/2) * tA * tB
print("Площадь равна ",tS)
print ("----------\n")

///////////////////////////
// Расчет суммы вклада, и полученной прибыли через 5 лет
// Дано:
// Сумма вклада bankSum
// Годавая процентная ставка bankYearProcent
// Срок вклада bankYear

let bankSum: Double = 100
let bankYearProcent: Double = 16
let bankYear:Double = 5

//Разберем две ситуации с капитализацией и без капитализации вклада
//капитализация вклада производится раз в год и процент каждый последующий год берется на остаток суммы
//без капитализации вклада процент берется на весь период, в данном случае на 5 лет



//БЕЗ КАПИТАЛИЗАЦИИ ВКЛАДА
print("БЕЗ КАПИТАЛИЗАЦИЕЙ ВКЛАДА")

// Прибыль за год
var yearProfit:Double = bankSum * (bankYearProcent/100)

//Сумма за год
var bankSumYear:Double = bankSum + yearProfit

//Прибыль за 5 лет
var allYearProfit:Double = yearProfit * bankYear

//Сумма за 5 лет
var bankSumAllYear:Double = bankSum + allYearProfit

print ("Прибыль за год: \(yearProfit).\nСумма за год: \(bankSumYear)\nПрибыль за 5 лет: \(allYearProfit)\nСумма за 5 лет: \(bankSumAllYear)")
print ("----------\n")
///////////////////////////

//С КАПИТАЛИЗАЦИЕЙ ВКЛАДА
print("С КАПИТАЛИЗАЦИЕЙ ВКЛАДА")

var capitalizationProfit:Double = 0
var bankSumYearCap:Double = bankSum


for index in 1...5 {
    
    //Вычисления прибыли с текущей суммы
    capitalizationProfit = bankSumYearCap * (bankYearProcent/100)
    
    //Округление до двух знаков после запятой
    capitalizationProfit = round(capitalizationProfit * 100)/100
    
    print ("Прибыль с суммы", bankSumYearCap,"за прошедший год", capitalizationProfit)
    
    //Вычесления конечной суммы
    bankSumYearCap = bankSumYearCap + capitalizationProfit
    
    //Округление до двух знаков после запятой
    bankSumYearCap = round(bankSumYearCap * 100)/100
    
    print ("Сумма по окончанию года",bankSumYearCap)
    print ("----------")
    
    
    
}














