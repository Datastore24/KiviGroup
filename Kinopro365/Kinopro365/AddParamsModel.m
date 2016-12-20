//
//  AddParamsModel.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 20.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "AddParamsModel.h"

@implementation AddParamsModel

+ (NSArray*) setArrayHeight {
    
    NSMutableArray * mArray = [NSMutableArray array];
    
    NSArray * arrayHeight = [NSArray arrayWithObjects:
                             @"140 см", @"141 см",@"142 см",@"143 см",@"144 см",@"145 см",@"146 см",
                             @"147 см", @"148 см",@"149 см",@"150 см",@"151 см",@"152 см",@"153 см",
                             @"154 см", @"155 см",@"156 см",@"157 см",@"158 см",@"159 см",@"160 см", nil];
    
    NSArray * arrayDrive = [NSArray arrayWithObjects:
                            @"Категория А", @"Категория B", @"Категория C",
                            @"Категория D", @"Категория E", @"Не вожу",nil];
    
    NSArray * arrayEyeColor = [NSArray arrayWithObjects:
                            @"Карие", @"Голубые", @"Заленые", @"Бежевые", @"Синие", nil];
    
    NSArray * arrayHairColor = [NSArray arrayWithObjects:
                            @"Блонд", @"Седые", @"Рыжие", @"Черные", @"Коричневые", @"Светлые", nil];
    
    NSArray * clothesSize = [NSArray arrayWithObjects:
                            @"46 мм", @"47 мм", @"48 мм", @"49 мм", @"50 мм", @"51 мм", @"52 мм", @"53 мм", @"54 мм", nil];
    
    [mArray addObject:arrayHeight];
    [mArray addObject:arrayDrive];
    [mArray addObject:arrayEyeColor];
    [mArray addObject:arrayHairColor];
    [mArray addObject:clothesSize];
    
    NSArray * arrayResult = [NSArray arrayWithArray:mArray];
    
    return arrayResult;
}

+ (NSArray*) setArrayTitl {    
    NSArray * arrayTitls = [NSArray arrayWithObjects:
                            @"\n Выберите ваш рост", @"\n Выберите вашу категорию", @"\n Выберите ваш цвет глаз",
                            @"\n Выберите ваш цвет волос", @"\n Выберите ваш размер\nодежды", nil];
    return arrayTitls;
}

@end
