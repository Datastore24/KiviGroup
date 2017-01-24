//
//  AddParamsModel.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 20.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "AddParamsModel.h"

@implementation AddParamsModel
@synthesize delegate;

+ (NSArray *) setTestArray {
    
    NSArray * arrayDrive = [NSArray arrayWithObjects:
                            @"Категория А", @"Категория B", @"Категория C",
                            @"Категория D", @"Категория E", @"Не вожу",nil];
    
    return arrayDrive;
    
}

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
    
    NSArray * arrayVocals = [NSArray arrayWithObjects:@"Хорошо пою", @"Не умею петь", nil];
    
    [mArray addObject:arrayHeight];
    [mArray addObject:arrayDrive];
    [mArray addObject:arrayEyeColor];
    [mArray addObject:arrayHairColor];
    [mArray addObject:clothesSize];
    [mArray addObject:arrayVocals];
    
    NSArray * arrayResult = [NSArray arrayWithArray:mArray];
    
    return arrayResult;
}

+ (NSArray*) setArrayTitl {    
    NSArray * arrayTitls = [NSArray arrayWithObjects:
                            @"\n Выберите ваш рост", @"\n Выберите вашу категорию", @"\n Выберите ваш цвет глаз",
                            @"\n Выберите ваш цвет волос", @"\n Выберите ваш размер\nодежды", @"\n Выберите навык вокала",
                            nil];
    return arrayTitls;
}

+ (NSArray*) setArrayData {
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    NSArray * arrayNames = [NSArray arrayWithObjects:@"Русский", @"Английский", @"Немецкий",  @"Французский",
                                                     @"Испанский", @"Китайский", @"Итальянский", @"Японский", nil];
    

    NSArray * arrayChoose = [NSArray arrayWithObjects:[NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO],
                             [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO],
                             [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO],  nil];
    
    
    for (int i = 0; i < arrayNames.count; i++) {
        
        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[arrayNames objectAtIndex:i], @"name",
                                      [arrayChoose objectAtIndex:i], @"choose", nil];
        [array addObject:dict];
    }
    
    NSArray * resultArray = [NSArray arrayWithArray:array];
    return resultArray;
}

- (void) loadParams {
    
    NSArray * profArray = [self.delegate profArray];
    if(profArray.count >0){
        NSMutableArray * profMutableArray = [NSMutableArray new];
        for(int i=0; i<profArray.count; i++){
            NSDictionary * profDict = [profArray objectAtIndex:i];
            
            
            
            NSInteger profID = [[profDict objectForKey:@"professionID"] integerValue];
            
            
            
        }
    }
    
}

-(void) getParamsDict: (NSInteger) profID {
    
    NSMutableArray * paramsMutableArray = [NSMutableArray new];
    NSArray * arrayType = [NSArray arrayWithObjects:@"String", @"Picker", @"Switch", @"Picker", @"Switch", @"Switch", @"Switch",nil];
    if(profID == 1){
        
        NSArray * profArray = @[
                                @{
                                    @"title": @"Рост",
                                    @"placeholder": @"Введите Ваш рост",
                                    @"id": @"ex_height",
                                    @"type": @"String",
                                    @"array" : @[]
                                    },
                                @{
                                    @"title": @"Цвет волос",
                                    @"placeholder": @"",
                                    @"id": @"ex_hair_color",
                                    @"type": @"Picker",
                                    @"array" : @[
                                                @{@"id":@"1",
                                                  @"name":@"Темные"
                                                    },
                                                @{@"id":@"2",
                                                  @"name":@"Русые"
                                                  },
                                                @{@"id":@"3",
                                                  @"name":@"Каштановые"
                                                  },
                                                @{@"id":@"4",
                                                  @"name":@"Рыжие"
                                                  },
                                                @{@"id":@"5",
                                                  @"name":@"Блонд"
                                                  },
                                                @{@"id":@"6",
                                                  @"name":@"Седые"
                                                  },
                                                @{@"id":@"7",
                                                  @"name":@"Темно-русые"
                                                  },
                                                @{@"id":@"8",
                                                  @"name":@"Темно-каштановые"
                                                  }
                                                ]
                                    },
                                @{
                                    @"title": @"Цвет глаз",
                                    @"placeholder": @"",
                                    @"id": @"ex_eyes_color",
                                    @"type": @"Picker",
                                    @"array" : @[
                                            @{@"id":@"1",
                                              @"name":@"Зеленые"
                                              },
                                            @{@"id":@"2",
                                              @"name":@"Серые"
                                              },
                                            @{@"id":@"3",
                                              @"name":@"Голубые"
                                              },
                                            @{@"id":@"4",
                                              @"name":@"Карие"
                                              },
                                            @{@"id":@"5",
                                              @"name":@"Синие"
                                              },
                                            @{@"id":@"6",
                                              @"name":@"Темно-зеленые"
                                              },
                                            @{@"id":@"7",
                                              @"name":@"Темно-серые"
                                              },
                                            @{@"id":@"8",
                                              @"name":@"Серо-голубые"
                                              }
                                            ]
                                    },
                                @{
                                    @"title": @"Размер одежды",
                                    @"placeholder": @"",
                                    @"id": @"ex_clothing_size",
                                    @"type": @"Picker",
                                    @"array" : @[
                                            @{@"id":@"1",
                                              @"name":@"30 - 32"
                                              },
                                            @{@"id":@"2",
                                              @"name":@"32 - 34"
                                              },
                                            @{@"id":@"3",
                                              @"name":@"34 - 36"
                                              },
                                            @{@"id":@"4",
                                              @"name":@"36 - 38"
                                              },
                                            @{@"id":@"5",
                                              @"name":@"38 - 40"
                                              },
                                            @{@"id":@"6",
                                              @"name":@"40 - 42"
                                              },
                                            @{@"id":@"7",
                                              @"name":@"42 - 44"
                                              },
                                            @{@"id":@"8",
                                              @"name":@"44 - 46"
                                              },
                                            @{@"id":@"9",
                                              @"name":@"46 - 48"
                                              },
                                            @{@"id":@"10",
                                              @"name":@"48 - 50"
                                              },
                                            @{@"id":@"11",
                                              @"name":@"50 - 52"
                                              },
                                            @{@"id":@"12",
                                              @"name":@"52 - 54"
                                              },
                                            @{@"id":@"13",
                                              @"name":@"54 - 56"
                                              },
                                            @{@"id":@"14",
                                              @"name":@"56 - 58"
                                              },
                                            @{@"id":@"15",
                                              @"name":@"58 - 60"
                                              },
                                            @{@"id":@"16",
                                              @"name":@"60 - 62"
                                              },
                                            @{@"id":@"17",
                                              @"name":@"62 - 64"
                                              }
                                            ]
                                    },
                                @{
                                    @"title": @"Вождение",
                                    @"placeholder": @"",
                                    @"id": @"ex_driving",
                                    @"type": @"Picker",
                                    @"array" : @[
                                            @{@"id":@"1",
                                              @"name":@"Не вожу"
                                              },
                                            @{@"id":@"2",
                                              @"name":@"Категория A"
                                              },
                                            @{@"id":@"3",
                                              @"name":@"Категория B"
                                              },
                                            @{@"id":@"4",
                                              @"name":@"Категория C"
                                              },
                                            @{@"id":@"5",
                                              @"name":@"Категория D"
                                              },
                                            @{@"id":@"6",
                                              @"name":@"Категория A-B"
                                              },
                                            @{@"id":@"7",
                                              @"name":@"Категория B-C"
                                              },
                                            @{@"id":@"8",
                                              @"name":@"Категория A-B-C"
                                              },
                                            @{@"id":@"9",
                                              @"name":@"Категория A-B-C-D"
                                              },
                                            @{@"id":@"10",
                                              @"name":@"Категория B-C-D"
                                              },
                                            @{@"id":@"11",
                                              @"name":@"Вожу без прав"
                                              }
                                            ]
                                    },
                                @{
                                    @"title": @"Вокал",
                                    @"placeholder": @"",
                                    @"id": @"ex_vocals",
                                    @"type": @"Picker",
                                    @"array" : @[
                                            @{@"id":@"1",
                                              @"name":@"Не пою"
                                              },
                                            @{@"id":@"2",
                                              @"name":@"Пою хорошо"
                                              },
                                            @{@"id":@"3",
                                              @"name":@"Проф. уровень"
                                              },
                                            @{@"id":@"4",
                                              @"name":@"Проф. с большим опытом"
                                              }                                            ]
                                    },
                                @{
                                    @"title": @"Языки",
                                    @"placeholder": @"",
                                    @"id": @"ex_languages",
                                    @"type": @"MultiList",
                                    @"array" : @[
                                            @{@"id":@"1",
                                              @"name":@"китайский"
                                              },
                                            @{@"id":@"2",
                                              @"name":@"испанский"
                                              },
                                            @{@"id":@"3",
                                              @"name":@"английский"
                                              },
                                            @{@"id":@"4",
                                              @"name":@"хинди"
                                              },
                                            @{@"id":@"5",
                                              @"name":@"арабский"
                                              },
                                            @{@"id":@"6",
                                              @"name":@"португальский"
                                              },
                                            @{@"id":@"7",
                                              @"name":@"бенгальский"
                                              },
                                            @{@"id":@"8",
                                              @"name":@"русский"
                                              },
                                            @{@"id":@"9",
                                              @"name":@"46 - 48"
                                              },
                                            @{@"id":@"10",
                                              @"name":@"48 - 50"
                                              },
                                            @{@"id":@"11",
                                              @"name":@"50 - 52"
                                              },
                                            @{@"id":@"12",
                                              @"name":@"52 - 54"
                                              },
                                            @{@"id":@"13",
                                              @"name":@"54 - 56"
                                              },
                                            @{@"id":@"14",
                                              @"name":@"56 - 58"
                                              },
                                            @{@"id":@"15",
                                              @"name":@"58 - 60"
                                              },
                                            @{@"id":@"16",
                                              @"name":@"60 - 62"
                                              },
                                            @{@"id":@"17",
                                              @"name":@"62 - 64"
                                              }
                                            ]
                                    },
                                
                                ];
    }
    
}

@end
