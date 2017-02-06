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
    NSArray * arrayImages = [NSArray arrayWithObjects:@"actorsImage.png", @"gamersImage.png", @"operatorsImage.png",
                             @"designersImage.png", @"dressersImage.png", @"massActorsImage.png",
                             @"choreographersImage.png", @"productionOperatorImage.png", nil];
    NSArray * arrayNames = [NSArray arrayWithObjects:
                            @"Актёр", @"Режиссер-постановщик", @"Сценарист",
                             @"Художник-Гримёр", @"Реквизитор", @"Актер без образования",
                             @"Актер массовых сцен", @"Ассистент по актерам",
                            @"Режиссер монтажа",@"Монтажер",
                            @"Второй режиссер (планирование)",@"Второй режиссер (площадка)",
                            @"Редактор",@"Кастинг-директор",
                            @"Скрипт супервайзер",@"Каскадер",
                            @"Оператор-постановщик",@"Художник-постановщик",
                            @"Композитор",@"Звукорежиссёр",
                            @"Постановщик трюков",@"Дрессировщик",
                            @"Оператор",@"Оператор Стэдикам",
                            @"Ассистент оператора (фокус-пуллер)",@"Хлопушка",
                            @"Location Менеджер",@"Бум оператор",nil];

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
                             @"designersImage.png", @"dressersImage.png", nil];
    
    NSArray * arrayNames = [NSArray arrayWithObjects:
                            @"Актёр", @"Режиссер-постановщик", @"Сценарист",
                            @"Художник-Гримёр", @"Реквизитор", @"Актер без образования",
                            @"Актер массовых сцен", @"Ассистент по актерам",
                            @"Режиссер монтажа",@"Монтажер",
                            @"Второй режиссер (планирование)",@"Второй режиссер (площадка)",
                            @"Редактор",@"Кастинг-директор",
                            @"Скрипт супервайзер",@"Каскадер",
                            @"Оператор-постановщик",@"Художник-постановщик",
                            @"Композитор",@"Звукорежиссёр",
                            @"Постановщик трюков",@"Дрессировщик",
                            @"Оператор",@"Оператор Стэдикам",
                            @"Ассистент оператора (фокус-пуллер)",@"Хлопушка",
                            @"Location Менеджер",@"Бум оператор",nil];
    
    
    for (int i = 0; i < arrayNames.count; i++) {
        int k = i+1;
        APIManger * apiManager = [[APIManger alloc] init];
        
        [apiManager getDataFromSeverWithMethod:@"user.countByProfessions" andParams:nil andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
            if([response objectForKey:@"error_code"]){
                
                NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                      [response objectForKey:@"error_msg"]);
                NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
            }else{
                
                NSArray *dictResponse = [response objectForKey:@"response"];
                
               
                NSString * searchString = [NSString stringWithFormat:@"%d",k];
                NSPredicate *filter = [NSPredicate predicateWithFormat:@"profession_id = %@",searchString];
                NSArray *filteredProf = [dictResponse filteredArrayUsingPredicate:filter];
                
            
                
                if(filteredProf.count>0){
                    NSDictionary * profDict = [filteredProf objectAtIndex:0];
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [arrayImages objectAtIndex:i], @"image",
                                           [arrayNames objectAtIndex:i], @"name",
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
                                           [arrayNames objectAtIndex:i], @"name",
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





@end
