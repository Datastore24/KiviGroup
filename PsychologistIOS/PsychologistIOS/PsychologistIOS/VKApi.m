//
//  VKApi.m
//  PsychologistIOS
//
//  Created by Кирилл Ковыршин on 14.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "VKApi.h"
#import <AFNetworking/AFNetworking.h>
#import "SingleTone.h"

@implementation VKApi

//Информация о пользователе
-(void) getUserWithParams: (NSDictionary *) params complitionBlock: (void (^) (id response)) compitionBack{
    
    NSString* user_id = [params objectForKey:@"user_id"];
    NSString* access_token = [params objectForKey:@"access_token"];
    
    //-----------
    NSString * url = [NSString stringWithFormat:@"https://api.vk.com/method/users.get?uid=%@&access_token=%@&fields=verified,sex,bdate,city,has_mobile,contacts", user_id, access_token];
    
    //    NSLog(@"URL: %@",url);
    NSString * encodedURL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    //-------------------
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    //Запрос
    [manager GET: encodedURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Вызов блока
        compitionBack (responseObject);
        
        
        //Ошибки
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

//Поделиться
-(void) getUserWithParams: (NSDictionary *) params message: (NSString *) message andLinkAttach: (NSString*) link complitionBlock: (void (^) (id response)) compitionBack{
    
    NSString* user_id = [params objectForKey:@"user_id"];
    NSString* access_token = [params objectForKey:@"access_token"];
    
    
    //-----------
    NSString * url = [NSString stringWithFormat:@"https://api.vk.com/method/wall.post?uid=%@&message=%@&attachments=https://pp.vk.me/c623316/v623316359/3e441/f8U_GvVIOXo.jpg&access_token=%@", user_id, message,access_token];
    
    //    NSLog(@"URL: %@",url);
    NSString * encodedURL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    //-------------------
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    //Запрос
    [manager GET: encodedURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Вызов блока
        compitionBack (responseObject);
        
        
        //Ошибки
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
