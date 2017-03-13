//
//  CastingDetailsModel.m
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 10.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "CastingDetailsModel.h"
#import "APIManger.h"
#import "SingleTone.h"

@implementation CastingDetailsModel
@synthesize delegate;

-(void) loadCasting: (NSString *) castingID{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             castingID,@"casting_id",nil];
    
    [apiManager getDataFromSeverWithMethod:@"casting.get" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        NSLog(@"CASTING %@",response);
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{

            [self.delegate loadCasting:[response objectForKey:@"response"]];
            
        }
    }];
}

-(void)sendCastings: (NSString *) castingID complitionBlock: (void (^) (id response)) compitionBack{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             castingID,@"casting_id",nil];
    
    [apiManager getDataFromSeverWithMethod:@"casting.apply" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        NSLog(@"CASTING %@",response);
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
