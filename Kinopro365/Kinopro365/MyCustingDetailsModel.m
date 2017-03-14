//
//  MyCustingDetailsModel.m
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 10.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MyCustingDetailsModel.h"
#import "APIManger.h"
#import "SingleTone.h"

@implementation MyCustingDetailsModel
@synthesize delegate;

-(void) loadCastings: (NSString *) castingID{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             castingID,@"casting_id",nil];
    
    [apiManager getDataFromSeverWithMethod:@"casting.getAsAuthor" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        NSLog(@"PROFILE %@",response);
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            [self.delegate loadMyCastings:[response objectForKey:@"response"]];
            
        }
    }];
}

-(void) loadOffersProfile:(NSString *) castingID andOffset: (NSString *) offset andCount: (NSString *) count complitionBlock: (void (^) (id response)) compitionBack{
    
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             count,@"count",
                             offset,@"offset",
                             castingID,@"casting_id",nil];
    
    [apiManager getDataFromSeverWithMethod:@"casting.getOffers" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
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

-(void) loadApprovedProfile:(NSString *) castingID andOffset: (NSString *) offset andCount: (NSString *) count complitionBlock: (void (^) (id response)) compitionBack{
    
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             count,@"count",
                             offset,@"offset",
                             castingID,@"casting_id",nil];
    
    [apiManager getDataFromSeverWithMethod:@"casting.getApproved" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
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

- (void) decideCastings: (NSString *) castingID andDecision: (NSString *) decision complitionBlock: (void (^) (id response)) compitionBack{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             castingID,@"casting_offer_id",
                             decision,@"decision",nil];
    
    [apiManager getDataFromSeverWithMethod:@"casting.decide" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            compitionBack(response);
        }else{
            compitionBack(response);
            
        }
    }];
}

- (void) deleteCasting: (NSString *) castingID complitionBlock: (void (^) (id response)) compitionBack{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             castingID,@"casting_id",nil];
    
    [apiManager getDataFromSeverWithMethod:@"casting.delete" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            compitionBack(response);
        }else{
            compitionBack(response);
            
        }
    }];
}
@end
