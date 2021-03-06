//
//  DateTimeMethod.m
//  Hookah Manager
//
//  Created by Кирилл Ковыршин on 19.01.17.
//  Copyright © 2017 Viktor Mishustin. All rights reserved.
//

#import "DateTimeMethod.h"

@implementation DateTimeMethod


+ (NSString *) dateToTimestamp: (NSDate *) date{
    
    NSTimeInterval timeStamp = [date timeIntervalSince1970];
    NSInteger timeStampObj = timeStamp;
    NSString * timeString = [NSString stringWithFormat:@"%ld",(long)timeStampObj];
    return timeString;
}

+(NSDate *) timestampToDate: (NSString *) timestamp {
    // Set up an NSDateFormatter for UTC time zone
    NSString* format = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    NSDateFormatter* formatterUtc = [[NSDateFormatter alloc] init];
    [formatterUtc setDateFormat:format];
    [formatterUtc setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    // Cast the input string to NSDate
    NSDate* utcDate = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    
    // Set up an NSDateFormatter for the device's local time zone
    NSDateFormatter* formatterLocal = [[NSDateFormatter alloc] init];
    [formatterLocal setDateFormat:format];
    [formatterLocal setTimeZone:[NSTimeZone localTimeZone]];
    
    // Create local NSDate with time zone difference
    NSDate* localDate = [formatterUtc dateFromString:[formatterLocal stringFromDate:utcDate]];
    return localDate;
}



+ (NSString *)timeFormattedHHMM:(int)totalSeconds
{
    
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d",hours, minutes];
}

+(NSString *)convertDateStringToFormat:(NSString *) dateString startFormat:(NSString *) startFormat endFormat:(NSString *) endFormat{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:startFormat];
    NSDate *date = [format dateFromString:dateString];
    [format setDateFormat:endFormat];
    NSString* finalDateString = [format stringFromDate:date];
    return  finalDateString;
}

+(NSDate *) convertStringToNSDate: (NSString *) stringDate withFormatDate:(NSString *) dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:stringDate];
    
    return dateFromString;
}

+(NSDate *) getLocalDateInFormat: (NSString *) format {
    //NSString* format = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    // Set up an NSDateFormatter for UTC time zone
    NSDateFormatter* formatterUtc = [[NSDateFormatter alloc] init];
    [formatterUtc setDateFormat:format];
    [formatterUtc setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    // Cast the input string to NSDate
    NSDate* utcDate = [NSDate date];
    
    // Set up an NSDateFormatter for the device's local time zone
    NSDateFormatter* formatterLocal = [[NSDateFormatter alloc] init];
    [formatterLocal setDateFormat:format];
    [formatterLocal setTimeZone:[NSTimeZone localTimeZone]];
    
    // Create local NSDate with time zone difference
    NSDate* localDate = [formatterUtc dateFromString:[formatterLocal stringFromDate:utcDate]];
    
    return localDate;
}

@end
