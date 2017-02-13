//
//  VideoDetailsModel.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/6/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "VideoDetailsModel.h"
#import "VideoDetailsView.h"

@implementation VideoDetailsModel
@synthesize delegate;


- (void) getVideoArrayWithOffset: (NSString *) offset andCount: (NSString *) count {
    
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             offset, @"offset",
                             count, @"count",nil];
    [apiManager getDataFromSeverWithMethod:@"video.getProfile" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        
        NSLog(@"RESPONSE VIDEO %@",response);
        
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            
            
            NSDictionary *dictResponse = [response objectForKey:@"response"];
            NSArray *itemsArray = [dictResponse objectForKey:@"items"];
            [self.delegate loadVideo:itemsArray];
            
        }
        
    }];
}

-(void) deleteVideos:(NSMutableArray *) arrayView{
    
    APIManger * apiManager = [[APIManger alloc] init];
    for (int i=0; i<arrayView.count; i++){
        VideoDetailsView * detailView = [arrayView objectAtIndex:i];
        NSLog(@"DELETE PHOTO %@",detailView.stringID);
        
        NSString * stringID = detailView.stringID;
        NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 stringID,@"video_id", nil];
        [apiManager getDataFromSeverWithMethod:@"video.removeFromProfile" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
            NSLog(@"RESP PHOTOS %@",response);
            if([response objectForKey:@"error_code"]){
                
                NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                      [response objectForKey:@"error_msg"]);
                NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
            }else{
                if(i == arrayView.count - 1){
                    [self.delegate desableActivityIndicator];
                    [self.delegate loadViewCustom];
                }
            }
        }];
        
        
    }
}


@end
