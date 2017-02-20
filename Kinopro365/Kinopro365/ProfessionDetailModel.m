//
//  ProfessionDetailModel.m
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 17.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "ProfessionDetailModel.h"
#import "APIManger.h"
#import "SingleTone.h"

@implementation ProfessionDetailModel
@synthesize delegate;

-(void) loadProfile: (NSString *) profileID andProffesionID:(NSString *) profID{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             profileID,@"user_id",
                             profID,@"profession_id",nil];
   
    [apiManager getDataFromSeverWithMethod:@"user.get" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
         NSLog(@"PROFILE %@",response);
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            [self.delegate loadProfile:[response objectForKey:@"response"]];
        
        }
    }];
}


-(void) loadPhoto:(NSString *) profileID
        andOffset: (NSString *) offset
         andCount: (NSString *) count
        complitionBlock: (void (^) (id response)) compitionBack{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             profileID,@"owner_id",
                             offset,@"offset",
                             count,@"count",nil];
    [apiManager getDataFromSeverWithMethod:@"photo.getProfile" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            NSLog(@"RESPONSEPHOTO %@",response);
            compitionBack([response objectForKey:@"response"]);
        }
    }];
    
    
}

-(void) loadVideo:(NSString *) profileID
        andOffset: (NSString *) offset
         andCount: (NSString *) count
  complitionBlock: (void (^) (id response)) compitionBack{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             profileID,@"owner_id",
                             offset,@"offset",
                             count,@"count",nil];
    [apiManager getDataFromSeverWithMethod:@"video.getProfile" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            NSLog(@"RESPONSEVIDEO %@",response);
            compitionBack([response objectForKey:@"response"]);
        }
    }];
    
    
}
@end
