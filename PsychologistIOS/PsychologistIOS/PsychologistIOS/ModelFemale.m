//
//  ModelFemale.m
//  PsychologistIOS
//
//  Created by Viktor on 16.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "ModelFemale.h"

@implementation ModelFemale

+ (NSMutableArray *) setArrayNotification
{
    NSMutableArray * arrayNotification = [[NSMutableArray alloc] init];
    
    NSArray * arrayName = [NSArray arrayWithObjects:
                           @"Название вебинара 1", @"Название вебинара 2", @"Название вебинара 3",  nil];
    
    NSArray * arraySubName = [NSArray arrayWithObjects:
                             @"Краткое, полезное описание", @"Краткое, полезное описание",
                             @"Краткое, полезное описание",  nil];
    

    
    
    
    
    
    for (int i = 0; i < 3; i++) {
        
        NSDictionary * dictNotification = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [arrayName objectAtIndex:i], @"Name",
                                           [arraySubName objectAtIndex:i], @"SubName", nil];
        
        [arrayNotification addObject:dictNotification];
    }
    
    return arrayNotification;
}

@end
