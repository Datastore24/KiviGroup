//
//  CheckTypeClass.swift
//  Weather
//
//  Created by Кирилл Ковыршин on 06.12.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

import Foundation

class CheckTypeClass {
    
    class func chekTypeObject(object: Any) -> String {
        
        switch object {
        case is String:
            return "String"
        case is Double:
            return "Double"
        case is Int:
            return "Int"
        case is Float:
            return "Float"
        case is Array<Any>:
            return "Array"
        case is Dictionary<AnyHashable, Any>:
            return "Collection"
        default:
            return "Uknow Type"
        }
      
        
    }
    
    
    
}

