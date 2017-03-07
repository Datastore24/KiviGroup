//
//  MyVacanciesDetailsModel.m
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 07.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MyVacanciesDetailsModel.h"
#import "APIManger.h"
#import "SingleTone.h"

@implementation MyVacanciesDetailsModel
@synthesize delegate;

-(void) loadVacancies: (NSString *) vacancyID{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             vacancyID,@"vacancy_id",nil];
    
    [apiManager getDataFromSeverWithMethod:@"vacancy.getAsAuthor" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
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

-(void) loadOffersProfile:(NSString *) vacancyID andOffset: (NSString *) offset andCount: (NSString *) count complitionBlock: (void (^) (id response)) compitionBack{
    
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             count,@"count",
                             offset,@"offset",
                             vacancyID,@"vacancy_id",nil];
    
    [apiManager getDataFromSeverWithMethod:@"vacancy.getOffers" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        NSLog(@"OFFERS %@",response);
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            compitionBack([response objectForKey:@"response"]);
            
        }
    }];
    
}
@end
