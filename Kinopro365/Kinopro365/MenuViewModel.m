//
//  MenuViewModel.m
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 02.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MenuViewModel.h"
#import "UserInformationTable.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "APIManger.h"
#import "SingleTone.h"

@implementation MenuViewModel
@synthesize delegate;

-(void) loadUserInformation{
    RLMResults * userInformationArray = [UserInformationTable allObjects];
    APIManger * apiManager = [[APIManger alloc] init];
    if(userInformationArray.count>0){
        UserInformationTable * userInfo = [userInformationArray objectAtIndex:0];
        
        NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 userInfo.photo,@"id", nil];
        [apiManager getDataFromSeverWithMethod:@"photo.getById" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
            if([response objectForKey:@"error_code"]){
                
                NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                      [response objectForKey:@"error_msg"]);
                NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
            }else{
                
                NSDictionary * respDict = [response objectForKey:@"response"];
                NSLog(@"respDict %@",respDict);
                
                [self.delegate userFLName].text = userInfo.first_name;
                [self.delegate labelName].text = userInfo.last_name;
                
                [apiManager getDataFromSeverWithMethod:@"account.getCounters" andParams:nil andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
                    if([response objectForKey:@"error_code"]){
                        
                        NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                              [response objectForKey:@"error_msg"]);
                        NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
                    }else{
                        NSDictionary * respDictCount = [response objectForKey:@"response"];
                        [self.delegate countRewardsLabel].text = [respDictCount objectForKey:@"rewards"];
                        [self.delegate countLikesLabel].text = [respDictCount objectForKey:@"likes"];
                        [self.delegate countViewsLabel].text = [respDictCount objectForKey:@"views"];
                        [[SingleTone sharedManager] setMyCountViews:[respDictCount objectForKey:@"views"]];
                        if([[respDictCount objectForKey:@"notifications"] integerValue]>0){
                            [self.delegate countAlertLabel].text = [respDictCount objectForKey:@"notifications"];
                        }else{
                            [[self.delegate countAlertLabel] setAlpha:0.f];
                        }
                        
                        
                    }
                }];
                
                NSURL *imgURL = [NSURL URLWithString:[respDict objectForKey:@"url"]];
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                [manager downloadImageWithURL:imgURL
                                      options:0
                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                         // progression tracking code
                                     }
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished,
                                                NSURL *imageURL) {
                                        
                                        if(image){
                                           
                                            [[self.delegate userPhoto]  setImage:image forState:UIControlStateNormal];
                                            [self.delegate userPhoto].layer.cornerRadius = 5.f;
                                            [self.delegate userPhoto].clipsToBounds = YES;
                            
                                            
                                            
                                            
                                            
                                            
                                        }else{
                                            //Тут обработка ошибки загрузки изображения
                                        }
                                    }];
                
                
                
            }
            
        }];
        
    }
}

@end
