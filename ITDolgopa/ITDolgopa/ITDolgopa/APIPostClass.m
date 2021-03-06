//
//  APIPostClass.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "APIPostClass.h"
#import <AFNetworking/AFNetworking.h>

#define MAIN_URL @"http://ceo.aqaholding.ru/API/api.php" //Адрес сервера
#define API_KEY @"ww5CkGQ_-ofxRnYmoJrqxkEd* pkFInVEkGc_eLxJUZ32^BxYQZQqBk53spf" //Ключ API


@implementation APIPostClass
-(void) postDataToServerWithParams: (NSDictionary *) params method:(NSString*) method complitionBlock: (void (^) (id response)) compitionBack{
    NSString * url = [NSString stringWithFormat:@"%@?%@&api_key=%@",MAIN_URL,method,API_KEY];
    NSString * encodedURL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    //Запрос
    [manager POST: encodedURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Вызов блока
        compitionBack (responseObject);
        
        
        //Ошибки
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
@end
