//
//  WeatherData.swift
//  WeatherFull
//
//  Created by Кирилл Ковыршин on 09.12.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherData: Object {
    dynamic var cityName: String = ""
    var tempList = List<TempData>()
    
    //Для перезаписи, создаем ключевое поле
    override static func primaryKey() -> String?{
        return "cityName"
    }
}
