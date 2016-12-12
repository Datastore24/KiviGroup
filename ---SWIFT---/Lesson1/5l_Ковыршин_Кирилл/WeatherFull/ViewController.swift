//
//  ViewController.swift
//  WeatherFull
//
//  Created by Кирилл Ковыршин on 09.12.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController {

    @IBOutlet var mainView: UIView!


    let  managerData:ManagerData = ManagerData()
    let loadScreenDesign = LoadScreenDesign()
    var lists : Results<WeatherData>!
    let mainScroll: UIScrollView = UIScrollView()
    
    //Создание экземпляра класса managerData
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Файл базы данных
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
        // Define identifier
        let notificationName = Notification.Name("LOAD_FROM_SERVER")
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(loadComplete), name: notificationName, object: nil)
        
        mainScroll.frame = CGRect(x: 0, y: -64, width: view.bounds.size.width, height: view.bounds.size.height+64)
        mainScroll.isScrollEnabled = true
        mainScroll.contentSize = CGSize(width: view.bounds.size.width, height: 2000)
        view.addSubview(mainScroll)
        
        //Проверка на интернет
        let isInternetAvailable = CheckInternetConnection.isInternetAvailable()
        
        if isInternetAvailable {
            print("Internet Available")
            managerData.loadJSON()
        }else{
            print("Load From DB")
            loadComplete()
        }
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadComplete(){
        print("NOTIFICATION")
        lists = realm.objects(WeatherData.self)
        if lists.count > 0{
            self.loadScreenDesign.loadDesign(view: mainScroll, lists: lists)
        }else{
            print("EMPTY")
            let alert = UIAlertController(title: "Внимание", message: "У Вас отсутствует доступ к Интернет.\nБаза данных погоды пуста, дождитесь появление Интернета", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ок", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }


}


