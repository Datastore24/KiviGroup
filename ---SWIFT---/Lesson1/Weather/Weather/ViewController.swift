//
//  ViewController.swift
//  Weather
//
//  Created by Кирилл Ковыршин on 05.12.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON



class ViewController: UIViewController, JsonClassDelegate {

    var jsonClass = JsonClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Проверка типов
        let arrayOfType: [Any] = ["abc",10,10.1,Float(10.1),[1,2,3,4,5],["key1":10 , "key2": "test"]]
        
        
        for object in arrayOfType {
           let infromation = CheckTypeClass.chekTypeObject(object: object)
           print("Объект: \(object)\nТип объекта: \(infromation)")
           print("---------------\n")
            
        }
        
        
        
        self.jsonClass.delegate = self
        self.jsonClass.loadFromUrl()
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: JsonClassDelegate
    func updateServerDate() {
        
        
        for i in 0..<jsonClass.jsonResult.count {
            
            
            let information = jsonClass.jsonResult[i]
            let dict = information as! Dictionary<String, String>
            print ("Название товара: \(dict["name"]!)")
            print ("Описание товара: \(dict["description"]!)")
            print ("URL Изображения: \(dict["img"]!)")
            print ("-------------\n")
            
            let label = UILabel(frame: CGRect(x: 10, y: 64+i*50, width: 300, height: 21))
            label.textAlignment = .center
            label.text = "Название товара: \(dict["name"]!)"
            self.view.addSubview(label)

        }

    }


}

