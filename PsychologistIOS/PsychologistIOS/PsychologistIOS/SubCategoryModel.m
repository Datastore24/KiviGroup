//
//  SubCategoryModel.m
//  PsychologistIOS
//
//  Created by Viktor on 05.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "SubCategoryModel.h"

@implementation SubCategoryModel

+ (NSMutableArray *) setArraySubCategory
{
    NSMutableArray * arrayJury = [[NSMutableArray alloc] init];
    
    NSArray * arrayTitle = [NSArray arrayWithObjects:
                            @"Подкатегория 1", @"Подкатегория 2", @"Подкатегория 3",
                            @"Подкатегория 4", @"Подкатегория 5", nil];
    
    NSArray * arraySubTitle = [NSArray arrayWithObjects:
                               @"Краткое, полезное описание", @"Краткое, полезное описание",
                               @"Краткое, полезное описание", @"Краткое, полезное описание", @"Краткое, полезное описание", nil];
    
    NSArray * textJuriArray = [NSArray arrayWithObjects: [NSNumber numberWithBool:NO],
                               [NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO],
                               [NSNumber numberWithBool:YES], [NSNumber numberWithBool:YES],
                               nil];
    
    NSArray * imageJuri = [NSArray arrayWithObjects:@"image5.png", @"image3.png",
                           @"image4.png", @"image1.png", @"image2.png", nil];
    
    
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
