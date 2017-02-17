//
//  ProfessionModel.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 13.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "ProfessionModel.h"
#import "APIManger.h"
#import "SingleTone.h"

@implementation ProfessionModel
@synthesize delegate;

-(void) loadProfessionFromServerOffset: (NSString *) offset
                              andCount: (NSString *) count
                             andProfID:(NSString *) profID {
    
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             offset,@"offset",
                             count,@"count",
                             profID,@"profession_id",nil];
    [apiManager getDataFromSeverWithMethod:@"user.search" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            [self.delegate loadProfession:[response objectForKey:@"response"]];
        }
        
        
    }];
    
    
}

@end
