//
//  VideoDetailsModel.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/6/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "VideoDetailsModel.h"

@implementation VideoDetailsModel
@synthesize delegate;


- (void) getVideoArrayWithOffset: (NSString *) offset andCount: (NSString *) count {
    
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             offset, @"offset",
                             count, @"count",nil];
    [apiManager getDataFromSeverWithMethod:@"video.getProfile" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            NSLog(@"RESPONSE VIDEO %@",response);
            
            NSDictionary *dictResponse = [response objectForKey:@"response"];
            NSArray *itemsArray = [dictResponse objectForKey:@"items"];
            [self.delegate loadVideo:itemsArray];
        }
        
    }];
}


@end
