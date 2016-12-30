//
//  DateToTimestamp.h
//  Hookah Manager
//
//  Created by Кирилл Ковыршин on 29.12.16.
//  Copyright © 2016 Viktor Mishustin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateToTimestamp : NSObject
    + (NSNumber *) dateToTimestamp: (NSDate *) date;
@end
