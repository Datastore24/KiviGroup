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
            
            
            if(paramsArray.count>0){
             [profMutableArray addObjectsFromArray:paramsArray];   
            }
            
            
            
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



-(NSArray *) getHeight{
    NSMutableArray * rost = [NSMutableArray new];
    for(int i = 100; i<241; i++){
        NSString * intNumb = [NSString stringWithFormat:@"%d",i];
        NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                               intNumb,@"id",
                               intNumb,@"name", nil];
        [rost addObject:dict];
    }
    NSArray * resultArray = [NSArray arrayWithArray:rost];
    return resultArray;
}

//Для сервера

- (NSArray *) loadParamsFromServerProfArray: (NSArray *) profArray {
    
    if(profArray.count >0){
        NSMutableArray * profMutableArray = [NSMutableArray new];
        for(int i=0; i<profArray.count; i++){
            NSDictionary * profDict = [profArray objectAtIndex:i];
            
            NSInteger profID = [[profDict objectForKey:@"profession_id"] integerValue];
            NSArray * paramsArray = [self getParamsDict:profID];
            
            
            if(paramsArray.count>0){
                [profMutableArray addObjectsFromArray:paramsArray];
            }
            
            
            
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

-(NSDictionary *) getInformationDictionary: (NSString *) infID andProfArray: (NSArray *) profArray{
    
    NSArray *filtered = [profArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(id == %@)", infID]];
    NSDictionary *item;
    if(filtered.count>0){
        item = [filtered objectAtIndex:0];
    }else{
        item = @{};
    }
    
    
    return item;
    
}


-(NSDictionary *) getIDDictionary: (NSString *) infName andArray: (NSArray *) array{
    
    NSArray *filtered = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(name like %@)", infName]];
    NSDictionary *item;
    if(filtered.count>0){
        item = [filtered objectAtIndex:0];
    }else{
        item = @{};
    }
    
    
    return item;
    
}

-(NSDictionary *) getNameByDictionary: (NSArray *) array andFindID: (NSString *) infID {
    
    NSArray *filtered = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(id == %@)", infID]];
    if(filtered.count>0){
        NSDictionary *item = [filtered objectAtIndex:0];
         return item;
    }else{
        return  @{};
    }
    
    
}

//


-(NSArray *) getParamsDict: (NSInteger) profID {
    NSArray * rost = [self getHeight];
   
    NSArray * profArray;
    if(profID == 1){
        
        profArray = @[
                                @{
                                    @"title": @"Рост",
                                    @"placeholder": @"",
                                    @"id": @"ex_height",
                                    @"type": @"Picker",
                                    @"defValueIndex": @"170",
                                    @"array" : rost
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
                                              }
                                            ]
                                    },
                                @{
                                    @"title": @"Языки",
                                    @"placeholder": @"",
                                    @"id": @"ex_languages",
                                    @"type": @"MultiList",
                                    @"array" : @[
                                            [@{@"id":@"1",
                                               @"name":@"китайский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               } mutableCopy],
                                            [@{@"id":@"2",
                                               @"name":@"испанский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               } mutableCopy],
                                            [@{@"id":@"3",
                                               @"name":@"английский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"4",
                                               @"name":@"хинди",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               } mutableCopy],
                                            [@{@"id":@"5",
                                               @"name":@"арабский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               } mutableCopy],
                                            [@{@"id":@"6",
                                               @"name":@"португальский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               } mutableCopy],
                                            [@{@"id":@"7",
                                               @"name":@"бенгальский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               } mutableCopy],
                                            [@{@"id":@"8",
                                               @"name":@"русский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               } mutableCopy],
                                            [@{@"id":@"9",
                                               @"name":@"японский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"10",
                                               @"name":@"немецкий",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"11",
                                               @"name":@"корейский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"12",
                                               @"name":@"французский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"13",
                                               @"name":@"турецкий",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"14",
                                               @"name":@"тамильский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"15",
                                               @"name":@"урду",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"16",
                                               @"name":@"итальянский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"17",
                                               @"name":@"малайский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"18",
                                               @"name":@"персидский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"19",
                                               @"name":@"польский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"20",
                                               @"name":@"нидерландский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"21",
                                               @"name":@"греческий",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"22",
                                               @"name":@"украинский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"23",
                                               @"name":@"армянский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"24",
                                               @"name":@"грузинский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"25",
                                               @"name":@"казахский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy],
                                            [@{@"id":@"26",
                                               @"name":@"белорусский",
                                               @"choose":[NSNumber numberWithBool:NO],
                                               }mutableCopy]
                                            ]
                                    }
                                
                                ];
    }
    
    if(profID == 2){
        
        profArray = @[
                      @{
                          @"title": @"Рост",
                          @"placeholder": @"",
                          @"id": @"ex_height",
                          @"type": @"Picker",
                          @"defValueIndex": @"170",
                          @"array" : rost
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
                                    }
                                  ]
                          },
                      @{
                          @"title": @"Языки",
                          @"placeholder": @"",
                          @"id": @"ex_languages",
                          @"type": @"MultiList",
                          @"array" : @[
                                  [@{@"id":@"1",
                                     @"name":@"китайский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"2",
                                     @"name":@"испанский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"3",
                                     @"name":@"английский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"4",
                                     @"name":@"хинди",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"5",
                                     @"name":@"арабский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"6",
                                     @"name":@"португальский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"7",
                                     @"name":@"бенгальский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"8",
                                     @"name":@"русский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"9",
                                     @"name":@"японский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"10",
                                     @"name":@"немецкий",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"11",
                                     @"name":@"корейский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"12",
                                     @"name":@"французский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"13",
                                     @"name":@"турецкий",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"14",
                                     @"name":@"тамильский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"15",
                                     @"name":@"урду",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"16",
                                     @"name":@"итальянский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"17",
                                     @"name":@"малайский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"18",
                                     @"name":@"персидский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"19",
                                     @"name":@"польский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"20",
                                     @"name":@"нидерландский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"21",
                                     @"name":@"греческий",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"22",
                                     @"name":@"украинский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"23",
                                     @"name":@"армянский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"24",
                                     @"name":@"грузинский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"25",
                                     @"name":@"казахский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"26",
                                     @"name":@"белорусский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy]
                                  ]
                          }
                      
                      ];
    }
    
    if(profID == 3){
        
        profArray = @[
                      @{
                          @"title": @"Рост",
                          @"placeholder": @"",
                          @"id": @"ex_height",
                          @"type": @"Picker",
                          @"defValueIndex": @"170",
                          @"array" : rost
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
                                    }
                                  ]
                          },
                      @{
                          @"title": @"Языки",
                          @"placeholder": @"",
                          @"id": @"ex_languages",
                          @"type": @"MultiList",
                          @"array" : @[
                                  [@{@"id":@"1",
                                     @"name":@"китайский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"2",
                                     @"name":@"испанский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"3",
                                     @"name":@"английский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"4",
                                     @"name":@"хинди",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"5",
                                     @"name":@"арабский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"6",
                                     @"name":@"португальский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"7",
                                     @"name":@"бенгальский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"8",
                                     @"name":@"русский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"9",
                                     @"name":@"японский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"10",
                                     @"name":@"немецкий",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"11",
                                     @"name":@"корейский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"12",
                                     @"name":@"французский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"13",
                                     @"name":@"турецкий",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"14",
                                     @"name":@"тамильский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"15",
                                     @"name":@"урду",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"16",
                                     @"name":@"итальянский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"17",
                                     @"name":@"малайский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"18",
                                     @"name":@"персидский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"19",
                                     @"name":@"польский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"20",
                                     @"name":@"нидерландский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"21",
                                     @"name":@"греческий",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"22",
                                     @"name":@"украинский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"23",
                                     @"name":@"армянский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"24",
                                     @"name":@"грузинский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"25",
                                     @"name":@"казахский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"26",
                                     @"name":@"белорусский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy]
                                  ]
                          }
                      
                      ];
    }
    
 
    
    if(profID == 4){
        
        profArray = @[
                      @{
                          @"title": @"Рост",
                          @"placeholder": @"",
                          @"id": @"ex_height",
                          @"type": @"Picker",
                          @"defValueIndex": @"170",
                          @"array" : rost
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
                                    }
                                  ]
                          },
                      @{
                          @"title": @"Языки",
                          @"placeholder": @"",
                          @"id": @"ex_languages",
                          @"type": @"MultiList",
                          @"array" : @[
                                  [@{@"id":@"1",
                                     @"name":@"китайский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"2",
                                     @"name":@"испанский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"3",
                                     @"name":@"английский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"4",
                                     @"name":@"хинди",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"5",
                                     @"name":@"арабский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"6",
                                     @"name":@"португальский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"7",
                                     @"name":@"бенгальский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"8",
                                     @"name":@"русский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     } mutableCopy],
                                  [@{@"id":@"9",
                                     @"name":@"японский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"10",
                                     @"name":@"немецкий",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"11",
                                     @"name":@"корейский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"12",
                                     @"name":@"французский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"13",
                                     @"name":@"турецкий",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"14",
                                     @"name":@"тамильский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"15",
                                     @"name":@"урду",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"16",
                                     @"name":@"итальянский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"17",
                                     @"name":@"малайский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"18",
                                     @"name":@"персидский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"19",
                                     @"name":@"польский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"20",
                                     @"name":@"нидерландский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"21",
                                     @"name":@"греческий",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"22",
                                     @"name":@"украинский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"23",
                                     @"name":@"армянский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"24",
                                     @"name":@"грузинский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"25",
                                     @"name":@"казахский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy],
                                  [@{@"id":@"26",
                                     @"name":@"белорусский",
                                     @"choose":[NSNumber numberWithBool:NO],
                                     }mutableCopy]
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
    
    if(profID > 4){
        
        profArray = @[];
    }
    
    
    
    return profArray;
    
}

-(NSArray *)getTypeCustings {
    
    NSArray * resultArray = @[@{@"id":@"1",
                                @"name":@"Художественный фильм"
                                },
                              @{@"id":@"2",
                                @"name":@"Телепередача"
                                },
                              @{@"id":@"3",
                                @"name":@"Музыкальный видеоклип"
                                },
                              @{@"id":@"4",
                                @"name":@"Короткометражный фильм"
                                },
                              @{@"id":@"5",
                                @"name":@"Реклама"
                                },
                              @{@"id":@"6",
                                @"name":@"Озвучивание и дубляж"
                                },
                              @{@"id":@"7",
                                @"name":@"Телесериал"
                                },
                              @{@"id":@"8",
                                @"name":@"Реалити шоу"
                                },
                              @{@"id":@"9",
                                @"name":@"Документальный фильм"
                                },
                              @{@"id":@"10",
                                @"name":@"Массовка и зрители"
                                },];
    return resultArray;
    
}

@end
