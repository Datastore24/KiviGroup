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
    NSLog(@"PARAMS %@",params);
    
    [apiManager getDataFromSeverWithMethod:@"user.get" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
         NSLog(@"PROFILE %@",response);
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            NSMutableDictionary * tempDict = [[NSMutableDictionary alloc] init];
            
            for(NSString * key in [response objectForKey:@"response"]){
                if(![[[response objectForKey:@"response"] objectForKey:key] isKindOfClass:[NSArray class]]){
                    NSString * value = [NSString stringWithFormat:@"%@",[[response objectForKey:@"response"] objectForKey:key]];
                    
                    if ([key rangeOfString:@"ex_"].location != NSNotFound) {
                        if(![value isEqualToString:@"0"]){
                            [tempDict setObject:value forKey:key];
                        }
                    }else if ([key rangeOfString:@"languages"].location != NSNotFound) {
                        [tempDict setObject:[[response objectForKey:@"response"] objectForKey:@"languages"] forKey:@"languages"];
                    }else{
                        if([[[response objectForKey:@"response"] objectForKey:key] isEqual:[NSNull null]]){
                            [tempDict setObject:[NSNull null] forKey:key];
                        }else{
                            [tempDict setObject:value forKey:key];
                        }
                        
                    }
                }else{
                    [tempDict setObject:[[response objectForKey:@"response"] objectForKey:key] forKey:key];
                }
                
            }
            
            NSDictionary * resultDict = [[NSDictionary alloc] initWithDictionary:tempDict];
            NSLog(@"RESULTDICT %@",resultDict);
            [self.delegate loadProfile:resultDict];
        
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

-(void) sendIsFavourite: (BOOL) isFavourite
           andProfileID:(NSString *) profileID
        complitionBlock: (void (^) (id response)) compitionBack{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             profileID,@"user_id",nil];
    if(isFavourite){
        [apiManager getDataFromSeverWithMethod:@"user.removeFromFavourite" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
            NSLog(@"RESPFAV %@",response);
            if([response objectForKey:@"error_code"]){
                
                NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                      [response objectForKey:@"error_msg"]);
                NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
            }else{
                compitionBack(response);
            }
        }];
        
    }else{
        [apiManager getDataFromSeverWithMethod:@"user.addToFavourite" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
            NSLog(@"RESPFAV %@",response);
            if([response objectForKey:@"error_code"]){
                
                NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                      [response objectForKey:@"error_msg"]);
                NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
            }else{
                compitionBack(response);
            }
        }];
        
    }
    
}

- (void) sendIsReward: (BOOL) isReward
           andProfileID:(NSString *) profileID
        complitionBlock: (void (^) (id response)) compitionBack{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             profileID,@"user_id",nil];
    if(isReward){
        [apiManager getDataFromSeverWithMethod:@"user.pickReward" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
            NSLog(@"RESPFAV %@",response);
            if([response objectForKey:@"error_code"]){
                
                NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                      [response objectForKey:@"error_msg"]);
               compitionBack(response);
            }else{
               compitionBack(response);
            }
        }];
        
    }else{
        [apiManager getDataFromSeverWithMethod:@"user.giveReward" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
            NSLog(@"RESPFAV %@",response);
            if([response objectForKey:@"error_code"]){
                
                NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                      [response objectForKey:@"error_msg"]);
                compitionBack(response);
            }else{
                compitionBack(response);
            }
        }];
        
    }
    
}

-(void) sendIsLike: (BOOL) isReward
        andProfileID:(NSString *) profileID
     complitionBlock: (void (^) (id response)) compitionBack{
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             profileID,@"user_id",nil];
    if(isReward){
        [apiManager getDataFromSeverWithMethod:@"user.unlike" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
            NSLog(@"RESPFAV %@",response);
            if([response objectForKey:@"error_code"]){
                
                NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                      [response objectForKey:@"error_msg"]);
                
                compitionBack(response);
            }else{
                compitionBack(response);
            }
        }];
        
    }else{
        [apiManager getDataFromSeverWithMethod:@"user.like" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
            NSLog(@"RESPFAV %@",response);
            if([response objectForKey:@"error_code"]){
                
                NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                      [response objectForKey:@"error_msg"]);
               compitionBack(response);
            }else{
                compitionBack(response);
            }
        }];
        
    }
    
}

@end
