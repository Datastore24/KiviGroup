//
//  LoadScreenDesign.swift
//  WeatherFull
//
//  Created by Кирилл Ковыршин on 09.12.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Alamofire
import AlamofireImage


class LoadScreenDesign {
    func loadDesign(view: UIScrollView, lists : Results<WeatherData>!) -> Void{
        print("LOAD DESIGN")
        if(lists.count > 0){
            let list = lists[0]
           
            let label = UILabel(frame: CGRect(x: 10, y: 70, width: 200, height: 21))
            //        label.textAlignment = .center
            label.text = "Город: \(list.cityName)"
            view.addSubview(label)
            print(list.tempList)
            //Цикл температур
            for i in 0..<list.tempList.count{
                let listInfo = list.tempList[i]
                
                let labelData = UILabel(frame: CGRect(x: 10, y: 90+i*50, width: 200, height: 50))
                labelData.text = listInfo["date"] as? String
                
                let labelTemp = UILabel(frame: CGRect(x: 160, y: 90+i*50, width: 90, height: 50))
                let tempDouble = listInfo["temperatur"]! as? Double
                let tempRound = round(tempDouble! * Double(100))/Double(100)
                labelTemp.text = "\(tempRound) \u{00B0}C"
                
                            Alamofire.request("http://openweathermap.org/img/w/\(listInfo["icon"]!).png").responseImage { response in
                
                                if let image = response.result.value {
                                    var bgImage: UIImageView = UIImageView()
                                    bgImage = UIImageView(image: image)
                                    bgImage.frame = CGRect(x: 260, y: 90+i*50, width: 50, height: 50)
                                    view.addSubview(bgImage)
                                }
                            }
                
                
                
                view.addSubview(labelTemp)
                view.addSubview(labelData)
                
            }
            
            
            
            

        
        }
    }

}
