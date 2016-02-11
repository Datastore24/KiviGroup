//
//  APIPostClass.m
//  Leadoon
//
//  Created by Кирилл Ковыршин on 15.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "APIPostClass.h"

#define MAIN_URL @"http://weddup.ru/api.php"
#define API_KEY @"R6tYkBhREgYp6ioXDx7gAkzHfCZnGyxnsRbEhjlMr05lii9MF6"

@implementation APIPostClass
-(void) postDataToServerWithParams: (NSDictionary *) params method:(NSString*) method complitionBlock: (void (^) (id response)) compitionBack{
    NSString * url = [NSString stringWithFormat:@"%@?%@&api_key=%@",MAIN_URL,method,API_KEY];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    //Запрос
    [manager POST: url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Вызов блока
        compitionBack (responseObject);
        
        
        //Ошибки
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}
@end
