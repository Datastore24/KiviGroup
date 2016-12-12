//
//  ManagerData.swift
//  WeatherFull
//
//  Created by Кирилл Ковыршин on 09.12.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class ManagerData {
    
    let realm = try! Realm() //Реализуем Realm
    
    func loadJSON() {
        let onlineWeather: WeatherData = WeatherData()
        
        
        
        let url = "http://api.openweathermap.org/data/2.5/forecast?q=Moscow,ru&appid=ec6d3c857bf95c4ce1a3f5f47010b873&lang=ru&units=metric"
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                onlineWeather.cityName = json["city"]["name"].stringValue
                for (_,subJson) in json["list"]{
                    let tmp: TempData = TempData()
                    
                    //Приведение к правильной дате, русский формат
                    let dateString = subJson["dt_txt"].stringValue
                    let dateNewFormat = DateToFormat.dateToFormat(date: dateString, inFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd.MM.yyyy HH:mm")
                    //
                    
                    
                    tmp.date = dateNewFormat
                    tmp.icon = subJson["weather"][0]["icon"].stringValue
                    tmp.temperatur = subJson["main"]["temp"].doubleValue
                    onlineWeather.tempList.append(tmp)
                    
                }
//                print(onlineWeather)

                try! self.realm.write {
                    
                    self.realm.delete(self.realm.objects(TempData.self))
                    
                    self.realm.add(onlineWeather, update: true)
                }
                
                let notificationName = Notification.Name("LOAD_FROM_SERVER")
                NotificationCenter.default.post(name: notificationName, object: nil)
                
                
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
}
