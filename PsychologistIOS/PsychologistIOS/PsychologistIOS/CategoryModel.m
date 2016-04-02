//
//  CategoryModel.m
//  PsychologistIOS
//
//  Created by Viktor on 01.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

+ (NSMutableArray *) setArrayJuri
{
    NSMutableArray * arrayJury = [[NSMutableArray alloc] init];
    
    NSArray * arrayTitle = [NSArray arrayWithObjects:
                            @"О самом интимном", @"В гармонии с телом", @"Красота",
                            @"Мир отношений", @"Кладовая женских знаний", nil];
    
    NSArray * arraySubTitle = [NSArray arrayWithObjects:
                               @"Краткое, полезное описание", @"Краткое, полезное описание",
                               @"Краткое, полезное описание", @"Краткое, полезное описание", @"Краткое, полезное описание", nil];
    
    NSArray * textJuriArray = [NSArray arrayWithObjects: [NSNumber numberWithBool:NO],
                               [NSNumber numberWithBool:NO], [NSNumber numberWithBool:YES],
                               [NSNumber numberWithBool:NO], [NSNumber numberWithBool:YES],
                               nil];
    
    NSArray * imageJuri = [NSArray arrayWithObjects:@"image1.png", @"image2.png",
                           @"image3.png", @"image4.png", @"image5.png", nil];
    
    
    for (int i = 0; i < 5; i++) {
        
        NSDictionary * dictJury = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [arrayTitle objectAtIndex:i], @"title",
                                   [arraySubTitle objectAtIndex:i], @"subTitle",
                                   [textJuriArray objectAtIndex:i], @"money",
                                   [imageJuri objectAtIndex:i], @"image", nil];
        
        [arrayJury addObject:dictJury];
    }
    
    return arrayJury;
}

@end
