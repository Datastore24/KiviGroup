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
                             andProfID: (NSString *) profID
                        andFilterArray: (NSDictionary *) filterArray{
    
    APIManger * apiManager = [[APIManger alloc] init];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             offset,@"offset",
                             count,@"count",
                             profID,@"profession_id",nil];
    
    if(filterArray.count>0){
        for(NSString * key in filterArray){
            
            
            if([key isEqualToString:@"dopArray"]){
                NSArray * dopArray = [filterArray objectForKey:key];
                for(int i=0; i<dopArray.count; i++){
                    NSDictionary * dopDict = [dopArray objectAtIndex:i];
                    NSLog(@"DIPPP %@",dopDict);
                    
                    if([[dopDict objectForKey:@"languages"] isKindOfClass:[NSArray class]]){
                        NSLog(@"LANGUAGE");
                        NSArray * langArray = [dopDict objectForKey:@"languages"];
                        int l=0;
                        for(int k=0; k<langArray.count; k++){
                            NSDictionary * langDict = [langArray objectAtIndex:k];
                            NSString * resultStringKey = [NSString stringWithFormat:@"ex_languages[%d]",l];
                            [params setObject:[langDict objectForKey:@"id"] forKey:resultStringKey];
                            l++;
                        }
                    }else{
                        [params setObject:[dopDict objectForKey:@"additionalValue"] forKey:[dopDict objectForKey:@"additionalID"]];
                    }
                }
            }else{
               [params setObject:[filterArray objectForKey:key] forKey:key];
            }
        }
    }
    NSLog(@"PARAMS %@", params);
    
    
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

-(void) sendIsFavourite: (BOOL) isFavourite
           andProfileID:(NSString *) profileID
        complitionBlock: (void (^) (void)) compitionBack{
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
                compitionBack();
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
                compitionBack();
            }
        }];
        
    }
    
}

@end
