//
//  ChooseProfessionalModel.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 16.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "ChooseProfessionalModel.h"
#import "SingleTone.h"
#import "APIManger.h"
#import "ProfessionsTable.h"

@implementation ChooseProfessionalModel

@synthesize delegate;



- (void) getProfessionalArrayToTableView{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    NSArray * arrayNames = [NSArray arrayWithObjects:
                            @"Актёр", @"Актер без образования", @"Актер массовых сцен",@"Каскадер",
                            @"Режиссер", @"Второй режиссер", @"Второй режиссер планирование",
                            @"Режиссер CG",@"Оператор постановщик",@"Оператор",@"Оператор Стедикам",
                            @"1-й Ассистент – Механик",@"2-й Ассистент оператора (Хлопушка)",
                            @"Долли",@"Фокус пулер",@"Плейбек",@"Сценарист",@"Редактор",
                            @"Скрипт супервайзер",@"Креативный продюсер",
                            @"Администратор",@"Директор",@"Исполнительный продюсер",@"Линейный продюсер",
                            @"Кастинг директор",@"Режиссер монтажа",@"Монтажер",@"Композитор",@"Художник по костюмам",
                            @"Костюмер",@"Художник по гриму",@"Гример",@"Ассистент  по актерам",@"Ассистент  по массовке",
                            @"Водитель",@"Буфет",@"Художник постановщик",@"Декоратор",@"Гафер",
                            @"Осветитель",@"Рабочий постановочного цеха",@"Звукорежиссер",@"Звукооператор",
                            @"Микрофонщик (Boom)",@"Режиссёр звуковых эффектов",@"Звукооформитель",@"Реквизитор",
                            @"Супервайзер по спецэффектам",@"Постановщик трюков",
                            @"Хореограф",@"Менеджер по локациям",@"Фотограф (портфолио)",@"Showreel (Портфолио)",nil];

        for (int i = 0; i < arrayNames.count; i++) {
            NSString * profID = [NSString stringWithFormat:@"%d",i+1];
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"professionID = %@",
                                 profID];
            RLMResults *profTableDataArray = [ProfessionsTable objectsWithPredicate:pred];
            NSNumber * isChoose;
            if(profTableDataArray.count>0){
                isChoose = [NSNumber numberWithBool:YES];
                [self.delegate creationStringWithString:[arrayNames objectAtIndex:i] andChooseParams:YES andString:[self.delegate professianString]];
            }else{
                isChoose = [NSNumber numberWithBool:NO];
            }
            
            
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          [arrayNames objectAtIndex:i], @"name",
                                          profID,@"profID",
                                          @"actorsImage.png", @"image",
                                          isChoose, @"choose", nil];
            
            [array addObject:dict];
            
        }
        [self.delegate setMainArrayData:array];
        [self.delegate reloadTable];
}







- (void) getArrayToTableView {
    NSMutableArray * array = [[NSMutableArray alloc] init];
    NSArray * arrayImages = [NSArray arrayWithObjects:
                             @"actorsImage.png", @"gamersImage.png", @"operatorsImage.png",
                             @"designersImage.png", @"dressersImage.png", @"massActorsImage.png",
                             @"choreographersImage.png", @"productionOperatorImage.png", @"actorsImage.png",
                             @"gamersImage.png", @"operatorsImage.png", @"designersImage.png",
                             @"dressersImage.png", @"massActorsImage.png", @"choreographersImage.png",
                             @"productionOperatorImage.png", @"actorsImage.png", @"gamersImage.png",
                             @"operatorsImage.png", @"designersImage.png", @"dressersImage.png",
                             @"massActorsImage.png", @"choreographersImage.png", @"productionOperatorImage.png",
                             @"dressersImage.png", @"actorsImage.png", @"actorsImage.png",@"actorsImage.png", @"gamersImage.png", @"operatorsImage.png",
                             @"designersImage.png", @"dressersImage.png",
                             @"actorsImage.png", @"gamersImage.png", @"operatorsImage.png",
                             @"designersImage.png", @"dressersImage.png", @"massActorsImage.png",
                             @"choreographersImage.png", @"productionOperatorImage.png", @"actorsImage.png",
                             @"gamersImage.png", @"operatorsImage.png", @"designersImage.png",
                             @"dressersImage.png", @"massActorsImage.png", @"choreographersImage.png",
                             @"productionOperatorImage.png", @"actorsImage.png", @"gamersImage.png",
                             @"operatorsImage.png", @"designersImage.png", @"dressersImage.png",
                             @"massActorsImage.png", @"choreographersImage.png", @"productionOperatorImage.png",
                             @"dressersImage.png", @"actorsImage.png", @"actorsImage.png",@"actorsImage.png", @"gamersImage.png", @"operatorsImage.png",
                             @"designersImage.png", @"dressersImage.png",
                             @"actorsImage.png", @"gamersImage.png", @"operatorsImage.png",
                             @"designersImage.png", @"dressersImage.png", @"massActorsImage.png",
                             @"choreographersImage.png", @"productionOperatorImage.png", @"actorsImage.png",
                             @"gamersImage.png", @"operatorsImage.png", @"designersImage.png",
                             @"dressersImage.png", @"massActorsImage.png", @"choreographersImage.png",
                             @"productionOperatorImage.png", @"actorsImage.png", @"gamersImage.png",
                             @"operatorsImage.png", @"designersImage.png", @"dressersImage.png",
                             @"massActorsImage.png", @"choreographersImage.png", @"productionOperatorImage.png",
                             @"dressersImage.png", @"actorsImage.png", @"actorsImage.png",@"actorsImage.png", @"gamersImage.png", @"operatorsImage.png",
                             @"designersImage.png", @"dressersImage.png",
                             @"actorsImage.png", @"gamersImage.png", @"operatorsImage.png",
                             @"designersImage.png", @"dressersImage.png", @"massActorsImage.png",
                             @"choreographersImage.png", @"productionOperatorImage.png", @"actorsImage.png",
                             @"gamersImage.png", @"operatorsImage.png", @"designersImage.png",
                             @"dressersImage.png", @"massActorsImage.png", @"choreographersImage.png",
                             @"productionOperatorImage.png", @"actorsImage.png", @"gamersImage.png",
                             @"operatorsImage.png", @"designersImage.png", @"dressersImage.png",
                             @"massActorsImage.png", @"choreographersImage.png", @"productionOperatorImage.png",
                             @"dressersImage.png", @"actorsImage.png", @"actorsImage.png",@"actorsImage.png", @"gamersImage.png", @"operatorsImage.png",
                             @"designersImage.png", @"dressersImage.png",
                             @"actorsImage.png", @"gamersImage.png", @"operatorsImage.png",
                             @"designersImage.png", @"dressersImage.png", @"massActorsImage.png",
                             @"choreographersImage.png", @"productionOperatorImage.png", @"actorsImage.png",
                             @"gamersImage.png", @"operatorsImage.png", @"designersImage.png",
                             @"dressersImage.png", @"massActorsImage.png", @"choreographersImage.png",
                             @"productionOperatorImage.png", @"actorsImage.png", @"gamersImage.png",
                             @"operatorsImage.png", @"designersImage.png", @"dressersImage.png",
                             @"massActorsImage.png", @"choreographersImage.png", @"productionOperatorImage.png",
                             @"dressersImage.png", @"actorsImage.png", @"actorsImage.png",@"actorsImage.png", @"gamersImage.png", @"operatorsImage.png",
                             @"designersImage.png", @"dressersImage.png",nil];
    
    NSArray * arrayNames = [NSArray arrayWithObjects:
                            @{@"name" : @"Актёр", @"id" : @"1"},
                             @{@"name" : @"Актер без образования", @"id" : @"2"},
                             @{@"name" : @"Актер массовых сцен", @"id" : @"3"},
                             @{@"name" : @"Каскадер", @"id" : @"4"},
                             @{@"name" : @"Режиссер", @"id" : @"5"},
                             @{@"name" : @"Второй режиссер", @"id" : @"6"},
                             @{@"name" : @"Второй режиссер планирование", @"id" : @"7"},
                             @{@"name" : @"Режиссер CG", @"id" : @"8"},
                             @{@"name" : @"Оператор постановщик", @"id" : @"9"},
                             @{@"name" : @"Оператор", @"id" : @"10"},
                             @{@"name" : @"Оператор Стедикам", @"id" : @"11"},
                             @{@"name" : @"1-й Ассистент – Механик", @"id" : @"12"},
                             @{@"name" : @"2-й Ассистент оператора (Хлопушка)", @"id" : @"13"},
                             @{@"name" : @"Долли", @"id" : @"14"},
                             @{@"name" : @"Фокус пулер", @"id" : @"15"},
                             @{@"name" : @"Плейбек", @"id" : @"16"},
                             @{@"name" : @"Сценарист", @"id" : @"17"},
                             @{@"name" : @"Редактор", @"id" : @"18"},
                             @{@"name" : @"Скрипт супервайзер", @"id" : @"19"},
                             @{@"name" : @"Креативный продюсер", @"id" : @"20"},
                             @{@"name" : @"Администратор", @"id" : @"21"},
                             @{@"name" : @"Директор", @"id" : @"22"},
                             @{@"name" : @"Исполнительный продюсер", @"id" : @"23"},
                            @{@"name" : @"Линейный продюсер", @"id" : @"24"},
                            @{@"name" : @"Кастинг директор", @"id" : @"25"},
                            @{@"name" : @"Режиссер монтажа", @"id" : @"26"},
                            @{@"name" : @"Монтажер", @"id" : @"27"},
                            @{@"name" : @"Композитор", @"id" : @"28"},
                            @{@"name" : @"Художник по костюмам", @"id" : @"29"},
                            @{@"name" : @"Костюмер", @"id" : @"30"},
                            @{@"name" : @"Художник по гриму", @"id" : @"31"},
                            @{@"name" : @"Гример", @"id" : @"32"},
                            @{@"name" : @"Ассистент  по актерам", @"id" : @"33"},
                            @{@"name" : @"Ассистент  по массовке", @"id" : @"34"},
                            @{@"name" : @"Водитель", @"id" : @"35"},
                            @{@"name" : @"Буфет", @"id" : @"36"},
                            @{@"name" : @"Художник постановщик", @"id" : @"37"},
                            @{@"name" : @"Декоратор", @"id" : @"38"},
                            @{@"name" : @"Гафер", @"id" : @"39"},
                            @{@"name" : @"Осветитель", @"id" : @"40"},
                            @{@"name" : @"Рабочий постановочного цеха", @"id" : @"41"},
                            @{@"name" : @"Звукорежиссер", @"id" : @"42"},
                            @{@"name" : @"Звукооператор", @"id" : @"43"},
                            @{@"name" : @"Микрофонщик (Boom)", @"id" : @"44"},
                            @{@"name" : @"Режиссёр звуковых эффектов", @"id" : @"45"},
                            @{@"name" : @"Звукооформитель", @"id" : @"46"},
                            @{@"name" : @"Реквизитор", @"id" : @"47"},
                            @{@"name" : @"Супервайзер по спецэффектам", @"id" : @"48"},
                            @{@"name" : @"Постановщик трюков ", @"id" : @"49"},
                            @{@"name" : @"Хореограф", @"id" : @"50"},
                            @{@"name" : @"Менеджер по локациям", @"id" : @"51"},
                            @{@"name" : @"Фотограф (портфолио)", @"id" : @"52"},
                            @{@"name" : @"Showreel (Портфолио)", @"id" : @"53"},nil];
    
    
    
    for (int i = 0; i < arrayNames.count; i++) {
        APIManger * apiManager = [[APIManger alloc] init];
        
        [apiManager getDataFromSeverWithMethod:@"user.countByProfessions" andParams:nil andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
            
            
            if([response objectForKey:@"error_code"]){
                
                NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                      [response objectForKey:@"error_msg"]);
                NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
            }else{
                
                NSArray *dictResponse = [response objectForKey:@"response"];
                NSLog(@"COUNT %@",response);
                NSDictionary * dictNames = [arrayNames objectAtIndex: i];
               
                NSPredicate *filter = [NSPredicate predicateWithFormat:
                                       @"profession_id = %@",[dictNames objectForKey:@"id"]];
                NSArray *filteredProf = [dictResponse filteredArrayUsingPredicate:filter];
                
            
                
                if(filteredProf.count>0){
                    NSDictionary * profDict = [filteredProf objectAtIndex:0];
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [arrayImages objectAtIndex:i], @"image",
                                           [dictNames objectForKey:@"name"], @"name",
                                           [dictNames objectForKey:@"id"], @"id",
                                           [profDict objectForKey:@"count"], @"number", nil];
                    
                    [array addObject:dict];
                    if((i == arrayNames.count -1)){
                       [self.delegate addObjectToDataArray:dict finish:YES];
                    }else{
                      [self.delegate addObjectToDataArray:dict finish:NO];
                    }
                    
                    
                }else{
                    
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [arrayImages objectAtIndex:i], @"image",
                                           [dictNames objectForKey:@"name"], @"name",
                                           [dictNames objectForKey:@"id"], @"id",
                                           @"0", @"number", nil];
                    
                    if(i == arrayNames.count -1){
                        [self.delegate addObjectToDataArray:dict finish:YES];
                    }else{
                        [self.delegate addObjectToDataArray:dict finish:NO];
                    }
                    
                }
            }
        }];
        
        
        
    }
    

    
}

+(NSArray *) getArrayProfessions {
    NSArray * arrayNames = [NSArray arrayWithObjects:
                            @{@"name" : @"Актёр", @"id" : @"1"},
                            @{@"name" : @"Актер без образования", @"id" : @"2"},
                            @{@"name" : @"Актер массовых сцен", @"id" : @"3"},
                            @{@"name" : @"Каскадер", @"id" : @"4"},
                            @{@"name" : @"Режиссер", @"id" : @"5"},
                            @{@"name" : @"Второй режиссер", @"id" : @"6"},
                            @{@"name" : @"Второй режиссер планирование", @"id" : @"7"},
                            @{@"name" : @"Режиссер CG", @"id" : @"8"},
                            @{@"name" : @"Оператор постановщик", @"id" : @"9"},
                            @{@"name" : @"Оператор", @"id" : @"10"},
                            @{@"name" : @"Оператор Стедикам", @"id" : @"11"},
                            @{@"name" : @"1-й Ассистент – Механик", @"id" : @"12"},
                            @{@"name" : @"2-й Ассистент оператора (Хлопушка)", @"id" : @"13"},
                            @{@"name" : @"Долли", @"id" : @"14"},
                            @{@"name" : @"Фокус пулер", @"id" : @"15"},
                            @{@"name" : @"Плейбек", @"id" : @"16"},
                            @{@"name" : @"Сценарист", @"id" : @"17"},
                            @{@"name" : @"Редактор", @"id" : @"18"},
                            @{@"name" : @"Скрипт супервайзер", @"id" : @"19"},
                            @{@"name" : @"Креативный продюсер", @"id" : @"20"},
                            @{@"name" : @"Администратор", @"id" : @"21"},
                            @{@"name" : @"Директор", @"id" : @"22"},
                            @{@"name" : @"Исполнительный продюсер", @"id" : @"23"},
                            @{@"name" : @"Линейный продюсер", @"id" : @"24"},
                            @{@"name" : @"Кастинг директор", @"id" : @"25"},
                            @{@"name" : @"Режиссер монтажа", @"id" : @"26"},
                            @{@"name" : @"Монтажер", @"id" : @"27"},
                            @{@"name" : @"Композитор", @"id" : @"28"},
                            @{@"name" : @"Художник по костюмам", @"id" : @"29"},
                            @{@"name" : @"Костюмер", @"id" : @"30"},
                            @{@"name" : @"Художник по гриму", @"id" : @"31"},
                            @{@"name" : @"Гример", @"id" : @"32"},
                            @{@"name" : @"Ассистент  по актерам", @"id" : @"33"},
                            @{@"name" : @"Ассистент  по массовке", @"id" : @"34"},
                            @{@"name" : @"Водитель", @"id" : @"35"},
                            @{@"name" : @"Буфет", @"id" : @"36"},
                            @{@"name" : @"Художник постановщик", @"id" : @"37"},
                            @{@"name" : @"Декоратор", @"id" : @"38"},
                            @{@"name" : @"Гафер", @"id" : @"39"},
                            @{@"name" : @"Осветитель", @"id" : @"40"},
                            @{@"name" : @"Рабочий постановочного цеха", @"id" : @"41"},
                            @{@"name" : @"Звукорежиссер", @"id" : @"42"},
                            @{@"name" : @"Звукооператор", @"id" : @"43"},
                            @{@"name" : @"Микрофонщик (Boom)", @"id" : @"44"},
                            @{@"name" : @"Режиссёр звуковых эффектов", @"id" : @"45"},
                            @{@"name" : @"Звукооформитель", @"id" : @"46"},
                            @{@"name" : @"Реквизитор", @"id" : @"47"},
                            @{@"name" : @"Супервайзер по спецэффектам", @"id" : @"48"},
                            @{@"name" : @"Постановщик трюков ", @"id" : @"49"},
                            @{@"name" : @"Хореограф", @"id" : @"50"},
                            @{@"name" : @"Менеджер по локациям", @"id" : @"51"},
                            @{@"name" : @"Фотограф (портфолио)", @"id" : @"52"},
                            @{@"name" : @"Showreel (Портфолио)", @"id" : @"53"},nil];
    return arrayNames;
}

+(NSArray *) getArrayProfessionsForVacancy {
    NSArray * arrayNames = [NSArray arrayWithObjects:
                            @{@"name" : @"Режиссер", @"id" : @"5"},
                            @{@"name" : @"Второй режиссер", @"id" : @"6"},
                            @{@"name" : @"Второй режиссер планирование", @"id" : @"7"},
                            @{@"name" : @"Режиссер CG", @"id" : @"8"},
                            @{@"name" : @"Оператор постановщик", @"id" : @"9"},
                            @{@"name" : @"Оператор", @"id" : @"10"},
                            @{@"name" : @"Оператор Стедикам", @"id" : @"11"},
                            @{@"name" : @"1-й Ассистент – Механик", @"id" : @"12"},
                            @{@"name" : @"2-й Ассистент оператора (Хлопушка)", @"id" : @"13"},
                            @{@"name" : @"Долли", @"id" : @"14"},
                            @{@"name" : @"Фокус пулер", @"id" : @"15"},
                            @{@"name" : @"Плейбек", @"id" : @"16"},
                            @{@"name" : @"Сценарист", @"id" : @"17"},
                            @{@"name" : @"Редактор", @"id" : @"18"},
                            @{@"name" : @"Скрипт супервайзер", @"id" : @"19"},
                            @{@"name" : @"Креативный продюсер", @"id" : @"20"},
                            @{@"name" : @"Администратор", @"id" : @"21"},
                            @{@"name" : @"Директор", @"id" : @"22"},
                            @{@"name" : @"Исполнительный продюсер", @"id" : @"23"},
                            @{@"name" : @"Линейный продюсер", @"id" : @"24"},
                            @{@"name" : @"Кастинг директор", @"id" : @"25"},
                            @{@"name" : @"Режиссер монтажа", @"id" : @"26"},
                            @{@"name" : @"Монтажер", @"id" : @"27"},
                            @{@"name" : @"Композитор", @"id" : @"28"},
                            @{@"name" : @"Художник по костюмам", @"id" : @"29"},
                            @{@"name" : @"Костюмер", @"id" : @"30"},
                            @{@"name" : @"Художник по гриму", @"id" : @"31"},
                            @{@"name" : @"Гример", @"id" : @"32"},
                            @{@"name" : @"Ассистент  по актерам", @"id" : @"33"},
                            @{@"name" : @"Ассистент  по массовке", @"id" : @"34"},
                            @{@"name" : @"Водитель", @"id" : @"35"},
                            @{@"name" : @"Буфет", @"id" : @"36"},
                            @{@"name" : @"Художник постановщик", @"id" : @"37"},
                            @{@"name" : @"Декоратор", @"id" : @"38"},
                            @{@"name" : @"Гафер", @"id" : @"39"},
                            @{@"name" : @"Осветитель", @"id" : @"40"},
                            @{@"name" : @"Рабочий постановочного цеха", @"id" : @"41"},
                            @{@"name" : @"Звукорежиссер", @"id" : @"42"},
                            @{@"name" : @"Звукооператор", @"id" : @"43"},
                            @{@"name" : @"Микрофонщик (Boom)", @"id" : @"44"},
                            @{@"name" : @"Режиссёр звуковых эффектов", @"id" : @"45"},
                            @{@"name" : @"Звукооформитель", @"id" : @"46"},
                            @{@"name" : @"Реквизитор", @"id" : @"47"},
                            @{@"name" : @"Супервайзер по спецэффектам", @"id" : @"48"},
                            @{@"name" : @"Постановщик трюков ", @"id" : @"49"},
                            @{@"name" : @"Хореограф", @"id" : @"50"},
                            @{@"name" : @"Менеджер по локациям", @"id" : @"51"},
                            @{@"name" : @"Фотограф (портфолио)", @"id" : @"52"},
                            @{@"name" : @"Showreel (Портфолио)", @"id" : @"53"},nil];
    return arrayNames;
}

+(NSArray *) getArrayProfessionsForCastings {
    NSArray * arrayNames = [NSArray arrayWithObjects:
                            @{@"name" : @"Актёр", @"id" : @"1"},
                            @{@"name" : @"Актер без образования", @"id" : @"2"},
                            @{@"name" : @"Актер массовых сцен", @"id" : @"3"},
                            @{@"name" : @"Каскадер", @"id" : @"4"}, nil];
    return arrayNames;
}





@end
