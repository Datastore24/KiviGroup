//
//  JsonClass.swift
//  Weather
//
//  Created by Кирилл Ковыршин on 06.12.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

protocol JsonClassDelegate{
    func updateServerDate()
}

class JsonClass{
    
    var jsonResult = Array<Any>()
    var delegate: JsonClassDelegate!
    
    func loadFromUrl(){
        let url = "http://ios.floweronline.ru/api.php?api_key=R6tYkBhREgYp6ioXDx7gAkzHfCZnGyxnsRbEhjlMr05lii9MF6&action=get_categories"
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
               
                let json = JSON(value)
                
                let jsonArray = json.arrayValue
                
                    for result in jsonArray{
                        //Do something you want
                        let name = result["name"].stringValue
                        let description = result["description"].stringValue
                        let img = result["img"].stringValue
                        let obj = ["name": name, "description": description, "img": img]
                        self.jsonResult.append(obj)
                    }
                
                DispatchQueue.global().async {
                    
                    self.delegate.updateServerDate()
                    // qos' default value is ´DispatchQoS.QoSClass.default`
                }
            
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
        
       
    }
    
    
}

