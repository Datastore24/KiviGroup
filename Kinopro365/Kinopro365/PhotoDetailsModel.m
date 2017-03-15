//
//  PhotoDetailsModel.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/6/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "PhotoDetailsModel.h"
#import "PhotoDetailView.h"

@implementation PhotoDetailsModel


- (void) getPhotosArrayWithOffset: (NSString *) offset andCount: (NSString *) count{
    
    APIManger * apiManager = [[APIManger alloc] init];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             offset, @"offset",
                             count, @"count",nil];
    [apiManager getDataFromSeverWithMethod:@"photo.getProfile" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
           NSLog(@"RESPONSE PHOTOS %@",response);
            
            NSDictionary *dictResponse = [response objectForKey:@"response"];
            NSArray *itemsArray = [dictResponse objectForKey:@"items"];
            [self.delegate desableActivityIndicator];
            [self.delegate loadPhotos:itemsArray];
        }
        
    }];
    
}

-(void) deletePhotos:(NSMutableArray *) arrayView{
    
    APIManger * apiManager = [[APIManger alloc] init];
    for (int i=0; i<arrayView.count; i++){
        PhotoDetailView * detailView = [arrayView objectAtIndex:i];
        NSLog(@"DELETE PHOTO %@",detailView.stringID);
    
        NSString * stringID = detailView.stringID;
        NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 stringID,@"photo_id", nil];
        [apiManager getDataFromSeverWithMethod:@"photo.removeFromProfile" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
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
