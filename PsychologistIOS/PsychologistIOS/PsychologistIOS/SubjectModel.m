//
//  SubjectModel.m
//  PsychologistIOS
//
//  Created by Viktor on 05.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "SubjectModel.h"

@implementation SubjectModel

+ (NSMutableArray *) setArraySubject
{
    NSMutableArray * arrayJury = [[NSMutableArray alloc] init];
    
    NSArray * arrayTitle = [NSArray arrayWithObjects:
                            @"Тема 1", @"Тема 2", @"Тема 3",
                            @"Тема 4", @"Тема 5", nil];
    
    NSArray * arraySubTitle = [NSArray arrayWithObjects:
                               @"Краткое, полезное описание", @"Краткое, полезное описание",
                               @"Краткое, полезное описание", @"Краткое, полезное описание", @"Краткое, полезное описание", nil];
    
    NSArray * textJuriArray = [NSArray arrayWithObjects: [NSNumber numberWithBool:YES],
                               [NSNumber numberWithBool:NO], [NSNumber numberWithBool:YES],
                               [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO],
                               nil];
    
    NSArray * imageJuri = [NSArray arrayWithObjects:@"image3.png", @"image5.png",
                           @"image1.png", @"image1.png", @"image4.png", nil];
    
    NSArray * arrayType = [NSArray arrayWithObjects:@"1", @"3", @"2", @"1", @"3", nil];
    
    
    for (int i = 0; i < 5; i++) {
        
        NSDictionary * dictJury = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [arrayTitle objectAtIndex:i], @"title",
                                   [arraySubTitle objectAtIndex:i], @"subTitle",
                                   [textJuriArray objectAtIndex:i], @"money",
                                   [imageJuri objectAtIndex:i], @"image",
                                   [arrayType objectAtIndex:i], @"typeCell", nil];
        
        [arrayJury addObject:dictJury];
    }
    
    return arrayJury;
}

@end
