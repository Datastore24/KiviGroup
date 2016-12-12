
import UIKit

class Product {
    let productId: String
    var name: String
    var price: Double
    
    init(productId: String, name: String, price: Double) {
        self.productId = productId
        self.name = name
        self.price = price
    }
}

class Storage {
    static let instance = Storage() // singleton
    private var products = [Product]()
    
    func addProduct(product: Product) {
        products.append(product)
    }
    
    func removeProduct(productId: String, countProduct: Int) {
        for _ in 0 ..< countProduct {
            for i in 0 ..< products.count {
                if products[i].productId == productId {
                    products.remove(at: i)
                    break
                }
            }
        }
        
    }
    
    class func productById(productId: String) -> Product? {
        for product in instance.products {
            if product.productId == productId {
                return product
            }
        }
        return nil
    }
    
    class func checkCount(productId: String) -> Int {
        var countProduct: Int = 0
        for product in instance.products{
            if product.productId == productId {
                countProduct += 1
            }
        }
        return countProduct
    }
    
    class func productReturns(product: Product){
       instance.products.append(product)
    }
}

class Cashbox {
    
    class func trySell(productId: String, countProduct: Int, wallet: inout Double) -> (Bool, String?) {
        
        let product: Product? = Storage.productById(productId: productId)
        // check for existence
        if product == nil {
            return (false, "Нет такого товара. Вы можете оформить предзаказ")
        }else{
            // check price
            let checkCount = Storage.checkCount(productId: productId)
            
            if countProduct > checkCount {
                return (false, "Такого количества нет на складе. Вы можете оформить предзаказ.\n Сейчас на складе: \(checkCount) шт.")
            }else{
                let priceWithCount = product!.price * Double(countProduct)
                if priceWithCount <= wallet {
                    wallet -= priceWithCount
                    Storage.instance.removeProduct(productId: product!.productId, countProduct: countProduct)
                    
                    return (true, nil)
                }else{
                    return (false, "Нет достаточно денег.")
                }
            }
            
            
            
        }
        
       
    }
}

class checkDateProductReturns{
    
    func checkDate(datePurchase: Date)-> (Bool, String?){
        
        let daysForReturns: Double = 7 * 86400 //Кол-во дней переводим в секунды
    
        let daysForReturnsInterval = Date(timeIntervalSinceNow: -daysForReturns) // Контрольная дата покупки, с котором можно осуществить возврат
        datePurchase //Дата покупки
        
        if(daysForReturnsInterval <= datePurchase){
            return (true, "Вы можете вернуть товар")
        }else{
           return (false,"Товар вернуть нельзя, прошло более 7 дней")
        }
        
        
    }
    
}



//let dateFormatter = DateFormatter()



// application code

let productToy = Product(productId: "PRODUCTID_TOY", name: "SuperToy", price: 50.0)
let productGame = Product(productId: "PRODUCTID_GAME", name: "GameBoy", price: 10.0)

for _ in 1...2 {
Storage.instance.addProduct(product: productToy)

Storage.instance.addProduct(product: productGame)
}

Storage.checkCount(productId: "PRODUCTID_TOY")
Storage.checkCount(productId: "PRODUCTID_GAME")
//Storage.instance.addProduct(productGame)

// customer
var wallet = 1600.0
Cashbox.trySell(productId: "PRODUCTID_TOY", countProduct:2, wallet: &wallet)
wallet
Storage.checkCount(productId: "PRODUCTID_TOY")
Cashbox.trySell(productId: "PRODUCTID_TOY", countProduct:1, wallet: &wallet)
Cashbox.trySell(productId: "PRODUCTID_GAME", countProduct:3, wallet: &wallet)
wallet

let result: (Result: Bool, Error: String?) = Cashbox.trySell(productId: "PRODUCTID_TOY", countProduct: 10, wallet: &wallet)

if result.Error != nil {
    print(result.Error!)
}

//Денег у клиента до возврата
wallet

//Возврат товара
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
let date = dateFormatter.date(from: "01.12.2016 18:25") //Дата совершения покупки


//Создаем экземпляр класса
let information: checkDateProductReturns = checkDateProductReturns()
//Проверяем дату

let checkDate:(Returns: Bool, Message:String?) = information.checkDate(datePurchase: date!)

//Товар на возврат
let productToReturns = Product(productId: "PRODUCTID_TOY", name: "SuperToy", price: 50.0)

if(checkDate.Returns){
    wallet += 50.0 //Возвращаем деньги
    Storage.productReturns(product: productToReturns)
    
}



print("Остаток денег: \(wallet)")

//Очередь на кассе
let cassaArrayOne = [5, 10, 1, 2, 6, 0, 7, 8]

let minCustomers = cassaArrayOne.min() //Минимальное количество человек
let minCustomersIndex = cassaArrayOne.index(of: minCustomers!) // Номер кассы по индексу

print("В кассе номер #\(minCustomersIndex! + 1) - \(minCustomers!) человек")










