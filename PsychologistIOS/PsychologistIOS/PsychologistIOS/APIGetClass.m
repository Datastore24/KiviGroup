//
//  APIClass.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "APIGetClass.h"
#import <AFNetworking/AFNetworking.h>
#import "SingleTone.h"


#define MAIN_URL @"http://psy.kivilab.ru/API/api.php" //Адрес сервера
#define API_KEY @"ww5CkGQpkFInVEkGceLxJUZ32BxYQZQqBk53spf" //Ключ API

@implementation APIGetClass


//Запрос на сервер
-(void) getDataFromServerWithParams: (NSDictionary *) params method:(NSString*) method complitionBlock: (void (^) (id response)) compitionBack{
//-----------
    NSString * url = [NSString stringWithFormat:@"%@?api_key=%@&action=%@",MAIN_URL,API_KEY,method];
    
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

//Запрос на сервер
-(void) getDataFromServerWithAudioParams: (NSDictionary *) params andAudioURL: (NSURL*) audioUrl method:(NSString*) method complitionBlock: (void (^) (id response)) compitionBack
{
    //-----------
    NSString * url = [NSString stringWithFormat:@"%@?api_key=%@&action=%@",MAIN_URL,API_KEY,method];
    NSData *voiceData = [[NSData alloc]initWithContentsOfURL:audioUrl];
    //-------------------
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFileData:voiceData name:@"userfile" fileName:@"audio.caf" mimeType:@"audio/x-caf"];
     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         compitionBack (responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@ ***** %@", operation.responseString, error);
     }];
    
}
@end
