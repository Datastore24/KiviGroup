//
//  AddCastingModel.m
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 13.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "AddCastingModel.h"
#import "APIManger.h"
#import "SingleTone.h"

@implementation AddCastingModel


- (void) addCastingsName: (NSString *) name andParams: (NSDictionary *) params complitionBlock: (void (^) (id response)) compitionBack{
    
    APIManger * apiManager = [[APIManger alloc] init];
    
    
    [apiManager postDataFromSeverWithMethod:@"casting.create" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        NSLog(@"Vacancies %@",response);
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            
        }else{
            compitionBack(response);
        }
    }];
}

- (void) editVacanciesName: (NSString *) name andParams: (NSDictionary *) params complitionBlock: (void (^) (id response)) compitionBack{
    
    APIManger * apiManager = [[APIManger alloc] init];
    
    
    
    [apiManager postDataFromSeverWithMethod:@"casting.edit" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
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
