//
//  VacanciesListModel.m
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 06.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "VacanciesListModel.h"
#import "APIManger.h"
#import "SingleTone.h"

@implementation VacanciesListModel

-(void) loadVacanciesFromServerOffset: (NSString *) offset
                              andCount: (NSString *) count
                             andCountryID: (NSString *) countryID
                         andCityID: (NSString *) cityID{
    
    APIManger * apiManager = [[APIManger alloc] init];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                    offset,@"offset",
                                    count,@"count",
                                    countryID,@"country_id",
                                    cityID,@"city_id",nil];
    
    NSLog(@"PARAMS %@", params);
    
    
    [apiManager getDataFromSeverWithMethod:@"vacancy.getList" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        NSLog(@"Vacancies %@",response);
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            [self.delegate loadVacancies:[response objectForKey:@"response"]];
        }
        
        
    }];
    
    
}

-(void) loadCastingsFromServerOffset: (NSString *) offset
                             andCount: (NSString *) count
                         andCountryID: (NSString *) countryID
                            andCityID: (NSString *) cityID
                     andProfessionID: (NSString *) professionID
                    andProjectTypeID: (NSString *) profjectTypeID{
    
    APIManger * apiManager = [[APIManger alloc] init];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                    offset,@"offset",
                                    count,@"count",
                                    countryID,@"country_id",
                                    cityID,@"city_id",
                                    professionID,@"profession_id",
                                    profjectTypeID,@"project_type_id",nil];
    
    NSLog(@"PARAMS %@", params);
    
    
    [apiManager getDataFromSeverWithMethod:@"casting.search" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        NSLog(@"Vacancies %@",response);
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            [self.delegate loadVacancies:[response objectForKey:@"response"]];
        }
        
        
    }];
    
    
}




@end
