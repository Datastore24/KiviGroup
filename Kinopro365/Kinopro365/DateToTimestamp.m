//
//  DateToTimestamp.m
//  Hookah Manager
//
//  Created by Кирилл Ковыршин on 29.12.16.
//  Copyright © 2016 Viktor Mishustin. All rights reserved.
//

#import "DateToTimestamp.h"

@implementation DateToTimestamp

+ (NSNumber *) dateToTimestamp: (NSDate *) date{
    
    NSTimeInterval timeStamp = [date timeIntervalSince1970];
    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
    return timeStampObj;
}
@end
