//
//  AddVacanciesModel.m
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 06.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "AddVacanciesModel.h"
#import "APIManger.h"
#import "SingleTone.h"

@implementation AddVacanciesModel

- (void) addVacanciesName: (NSString *) name andLogoID: (NSString *) logoID andEndAt: (NSString *) endAt andProfessionID: (NSString *) professionID andCountryID: (NSString *) countryID andCityID: (NSString *) cityID andDescription: (NSString *) description complitionBlock: (void (^) (id response)) compitionBack{
    
    APIManger * apiManager = [[APIManger alloc] init];
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    name,@"name",
                                    logoID,@"logo_id",
                                    endAt,@"end_at",
                             professionID,@"profession_id",
                             countryID,@"country_id",
                             cityID,@"city_id",
                             description,@"description",nil];
    
    [apiManager postDataFromSeverWithMethod:@"vacancy.create" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        NSLog(@"Vacancies %@",response);
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            
        }else{
            compitionBack(response);
        }
    }];
}


@end
