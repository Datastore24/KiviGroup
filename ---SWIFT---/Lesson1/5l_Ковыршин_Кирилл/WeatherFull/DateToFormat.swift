//
//  DateToFormat.swift
//  WeatherFull
//
//  Created by Кирилл Ковыршин on 09.12.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

import Foundation

class DateToFormat {
    class func dateToFormat(date: String, inFormat: String, toFormat: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = inFormat
        let date = formatter.date(from: date)
        formatter.dateFormat = toFormat
        let newDate = formatter.string(from: date!)
        return newDate
        
    }
}



