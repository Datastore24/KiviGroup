//
//  VacanciesDetailsModel.m
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 06.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "VacanciesDetailsModel.h"
#import "APIManger.h"
#import "SingleTone.h"

@implementation VacanciesDetailsModel

-(void) loadVacancies: (NSString *) vacancyID{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             vacancyID,@"vacancy_id",nil];
    
    [apiManager getDataFromSeverWithMethod:@"vacancy.get" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        NSLog(@"PROFILE %@",response);
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            [self.delegate loadMyVacancies:[response objectForKey:@"response"]];
            
        }
    }];
}

-(void)sendVacancy: (NSString *) vacancyID complitionBlock: (void (^) (id response)) compitionBack{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             vacancyID,@"vacancy_id",nil];
    
    [apiManager getDataFromSeverWithMethod:@"vacancy.apply" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        NSLog(@"PROFILE %@",response);
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
            compitionBack(response);
        }else{
            compitionBack(response);
            
        }
    }];

    
}

@end
