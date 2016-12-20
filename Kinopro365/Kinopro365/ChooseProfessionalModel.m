//
//  ChooseProfessionalModel.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 16.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "ChooseProfessionalModel.h"

@implementation ChooseProfessionalModel

+ (NSArray*) setArrayData {
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    NSArray * arrayNames = [NSArray arrayWithObjects:@"Актёры", @"Геймеры", @"Операторы", @"Дизайнеры",
                            @"Костюмеры", @"Актёры массовых сцен", @"Хореографы", @"Оператор-постановщик", nil];
    
    NSArray * arrayImages = [NSArray arrayWithObjects:@"actorsImage.png", @"gamersImage.png", @"operatorsImage.png",
                                                      @"designersImage.png", @"dressersImage.png", @"massActorsImage.png",
                                                      @"choreographersImage.png", @"productionOperatorImage.png", nil];
    NSArray * arrayChoose = [NSArray arrayWithObjects:[NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO],
                                  [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO],
                                  [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO],  nil];
    
    
    for (int i = 0; i < arrayNames.count; i++) {
        
        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[arrayNames objectAtIndex:i], @"name",
                               [arrayImages objectAtIndex:i], @"image", [arrayChoose objectAtIndex:i], @"choose", nil];
        [array addObject:dict];
    }
    
    NSArray * resultArray = [NSArray arrayWithArray:array];
    return resultArray;
}

@end
