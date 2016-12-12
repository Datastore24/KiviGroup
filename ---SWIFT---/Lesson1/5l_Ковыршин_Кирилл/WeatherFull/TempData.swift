//
//  TempData.swift
//  WeatherFull
//
//  Created by Кирилл Ковыршин on 09.12.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

import Foundation
import RealmSwift

class TempData: Object {
    dynamic var temperatur: Double = 0
    dynamic var icon: String = ""
    dynamic var date: String = ""
}
