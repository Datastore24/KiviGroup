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




- (NSArray *) loadParams: (NSArray *) profArray {
    
    if(profArray.count >0){
        NSMutableArray * profMutableArray = [NSMutableArray new];
        for(int i=0; i<profArray.count; i++){
            NSDictionary * profDict = [profArray objectAtIndex:i];
            
            NSInteger profID = [[profDict objectForKey:@"professionID"] integerValue];
            NSArray * paramsArray = [self getParamsDict:profID];
            [profMutableArray addObjectsFromArray:paramsArray];
            
            
        }
        
        NSMutableArray * unique = [NSMutableArray array];
        NSMutableSet * processed = [NSMutableSet set];
        for (NSDictionary * dict in profMutableArray) {
            if ([processed containsObject:dict] == NO) {
                [unique addObject:dict];
                [processed addObject:dict];
            }
        }

        return unique;
    }
    return @[];
}

-(NSArray *) getParamsDict: (NSInteger) profID {
    
    
    NSArray * profArray;
    if(profID == 1){
        
        profArray = @[
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
                                              @"name":@"японский"
                                              },
                                            @{@"id":@"10",
                                              @"name":@"немецкий"
                                              },
                                            @{@"id":@"11",
                                              @"name":@"корейский"
                                              },
                                            @{@"id":@"12",
                                              @"name":@"французский"
                                              },
                                            @{@"id":@"13",
                                              @"name":@"турецкий"
                                              },
                                            @{@"id":@"14",
                                              @"name":@"тамильский"
                                              },
                                            @{@"id":@"15",
                                              @"name":@"урду"
                                              },
                                            @{@"id":@"16",
                                              @"name":@"итальянский"
                                              },
                                            @{@"id":@"17",
                                              @"name":@"малайский"
                                              },
                                            @{@"id":@"18",
                                              @"name":@"персидский"
                                              },
                                            @{@"id":@"19",
                                              @"name":@"польский"
                                              },
                                            @{@"id":@"20",
                                              @"name":@"нидерландский"
                                              },
                                            @{@"id":@"21",
                                              @"name":@"греческий"
                                              },
                                            @{@"id":@"22",
                                              @"name":@"украинский"
                                              },
                                            @{@"id":@"23",
                                              @"name":@"армянский"
                                              },
                                            @{@"id":@"24",
                                              @"name":@"грузинский"
                                              },
                                            @{@"id":@"25",
                                              @"name":@"казахский"
                                              },
                                            @{@"id":@"26",
                                              @"name":@"белорусский"
                                              }
                                            ]
                                    },
                                
                                ];
    }
    
    if(profID == 2){
        
        profArray = @[];
    }
    
    if(profID == 3){
        
        profArray = @[];
    }
    
    if(profID == 4){
        
        profArray = @[];
    }
    
    if(profID == 5){
        
        profArray = @[];
    }
    
    if(profID == 6){
        
        profArray = @[
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
                                              @"name":@"японский"
                                              },
                                            @{@"id":@"10",
                                              @"name":@"немецкий"
                                              },
                                            @{@"id":@"11",
                                              @"name":@"корейский"
                                              },
                                            @{@"id":@"12",
                                              @"name":@"французский"
                                              },
                                            @{@"id":@"13",
                                              @"name":@"турецкий"
                                              },
                                            @{@"id":@"14",
                                              @"name":@"тамильский"
                                              },
                                            @{@"id":@"15",
                                              @"name":@"урду"
                                              },
                                            @{@"id":@"16",
                                              @"name":@"итальянский"
                                              },
                                            @{@"id":@"17",
                                              @"name":@"малайский"
                                              },
                                            @{@"id":@"18",
                                              @"name":@"персидский"
                                              },
                                            @{@"id":@"19",
                                              @"name":@"польский"
                                              },
                                            @{@"id":@"20",
                                              @"name":@"нидерландский"
                                              },
                                            @{@"id":@"21",
                                              @"name":@"греческий"
                                              },
                                            @{@"id":@"22",
                                              @"name":@"украинский"
                                              },
                                            @{@"id":@"23",
                                              @"name":@"армянский"
                                              },
                                            @{@"id":@"24",
                                              @"name":@"грузинский"
                                              },
                                            @{@"id":@"25",
                                              @"name":@"казахский"
                                              },
                                            @{@"id":@"26",
                                              @"name":@"белорусский"
                                              }
                                            ]
                                    },
                                
                                ];
    }
    
    if(profID == 7){
        
        profArray = @[
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
                                              @"name":@"японский"
                                              },
                                            @{@"id":@"10",
                                              @"name":@"немецкий"
                                              },
                                            @{@"id":@"11",
                                              @"name":@"корейский"
                                              },
                                            @{@"id":@"12",
                                              @"name":@"французский"
                                              },
                                            @{@"id":@"13",
                                              @"name":@"турецкий"
                                              },
                                            @{@"id":@"14",
                                              @"name":@"тамильский"
                                              },
                                            @{@"id":@"15",
                                              @"name":@"урду"
                                              },
                                            @{@"id":@"16",
                                              @"name":@"итальянский"
                                              },
                                            @{@"id":@"17",
                                              @"name":@"малайский"
                                              },
                                            @{@"id":@"18",
                                              @"name":@"персидский"
                                              },
                                            @{@"id":@"19",
                                              @"name":@"польский"
                                              },
                                            @{@"id":@"20",
                                              @"name":@"нидерландский"
                                              },
                                            @{@"id":@"21",
                                              @"name":@"греческий"
                                              },
                                            @{@"id":@"22",
                                              @"name":@"украинский"
                                              },
                                            @{@"id":@"23",
                                              @"name":@"армянский"
                                              },
                                            @{@"id":@"24",
                                              @"name":@"грузинский"
                                              },
                                            @{@"id":@"25",
                                              @"name":@"казахский"
                                              },
                                            @{@"id":@"26",
                                              @"name":@"белорусский"
                                              }
                                            ]
                                    },
                                
                                ];
    }
    
    if(profID == 8){
        
        profArray = @[];
    }
    
    if(profID == 9){
        
        profArray = @[];
    }
    
    if(profID == 10){
        
        profArray = @[];
    }
    
    if(profID == 11){
        
        profArray = @[];
    }
    
    if(profID == 12){
        
        profArray = @[];
    }
    
    if(profID == 13){
        
        profArray = @[];
    }
    
    if(profID == 14){
        
        profArray = @[];
    }
    
    if(profID == 15){
        
        profArray = @[];
    }
    
    if(profID == 16){
        
        profArray = @[
                                @{
                                    @"title": @"Рост",
                                    @"placeholder": @"Введите Ваш рост",
                                    @"id": @"ex_height",
                                    @"type": @"String",
                                    @"array" : @[]
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
                                    @"title": @"Фехтование",
                                    @"placeholder": @"",
                                    @"id": @"ex_fencing",
                                    @"type": @"Switch",
                                    @"array" : @[]
                                    },
                                @{
                                    @"title": @"Боевые трюки",
                                    @"placeholder": @"",
                                    @"id": @"ex_martial_stunt",
                                    @"type": @"Switch",
                                    @"array" : @[]
                                    },
                                @{
                                    @"title": @"Акробатика (паркур)",
                                    @"placeholder": @"",
                                    @"id": @"ex_acrobatics",
                                    @"type": @"Switch",
                                    @"array" : @[]
                                    },
                                @{
                                    @"title": @"Авто трюки",
                                    @"placeholder": @"",
                                    @"id": @"ex_car_stunt",
                                    @"type": @"Switch",
                                    @"array" : @[]
                                    },
                                @{
                                    @"title": @"Мото трюки",
                                    @"placeholder": @"",
                                    @"id": @"ex_moto_stunt",
                                    @"type": @"Switch",
                                    @"array" : @[]
                                    },
                                @{
                                    @"title": @"Трюки с огнем",
                                    @"placeholder": @"",
                                    @"id": @"ex_fiery_stunt",
                                    @"type": @"Switch",
                                    @"array" : @[]
                                    },
                                @{
                                    @"title": @"Постановщик трюков",
                                    @"placeholder": @"",
                                    @"id": @"ex_stunt_coordinator",
                                    @"type": @"Switch",
                                    @"array" : @[]
                                    },
                                @{
                                    @"title": @"Постановщик боев",
                                    @"placeholder": @"",
                                    @"id": @"ex_fights_director",
                                    @"type": @"Switch",
                                    @"array" : @[]
                                    },
                                
                                ];
    }
    
    if(profID == 17){
        
        profArray = @[];
    }
    
    if(profID == 18){
        
        profArray = @[];
    }
    
    if(profID == 19){
        
        profArray = @[];
    }
    
    if(profID == 20){
        
        profArray = @[];
    }
    
    if(profID == 21){
        
        profArray = @[];
    }
    
    if(profID == 22){
        
        profArray = @[];
    }
    
    if(profID == 23){
        
        profArray = @[];
    }
    
    if(profID == 24){
        
        profArray = @[];
    }
    
    if(profID == 25){
        
        profArray = @[];
    }
    
    if(profID == 26){
        
        profArray = @[];
    }
    
    if(profID == 27){
        
        profArray = @[];
    }
    
    if(profID == 28){
        
        profArray = @[];
    }
    
    return profArray;
    
}

@end
