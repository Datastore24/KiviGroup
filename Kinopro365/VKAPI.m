//
//  VKAPI.m
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 21.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "VKAPI.h"
#import <AFNetworking/AFNetworking.h>

@implementation VKAPI
//Информация о пользователе
- (void) getUserWithParams: (NSString *) userId andVkToken: (NSString *) vkToken complitionBlock: (void (^) (id response)) compitionBack{
    

    
    //-----------
    NSString * url = [NSString stringWithFormat:@"https://api.vk.com/method/users.get?uid=%@&access_token=%@&fields=verified,sex,bdate,city,has_mobile,contacts", userId, vkToken];
    
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
