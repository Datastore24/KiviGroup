//
//  APIManger.m
//  Hookah Manager
//
//  Created by Кирилл Ковыршин on 26.12.16.
//  Copyright © 2016 Viktor Mishustin. All rights reserved.
//

#import "APIManger.h"
#import <AFNetworking/AFNetworking.h>
#import "SingleTone.h"

@implementation APIManger
- (void) getDataFromSeverWithMethod: (NSString *) method andParams: (NSDictionary *) params andToken: (NSString *) token complitionBlock: (void (^) (id response)) compitionBack{
    
    
    
    //-----------
    NSString * url = [NSString stringWithFormat:@"http://api.kinopro365.com/v1/%@?token=%@",method,token];
    
    //    NSLog(@"URL: %@",url);
    NSString * encodedURL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    //-------------------
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager.requestSerializer setValue:[[SingleTone sharedManager] localization] forHTTPHeaderField:@"Accept-Language"];
    //Запрос
    [manager GET: encodedURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Вызов блока
        compitionBack (responseObject);
        //Ошибки
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void) postDataFromSeverWithMethod: (NSString *) method andParams: (NSDictionary *) params andToken: (NSString *) token complitionBlock: (void (^) (id response)) compitionBack{
    
    
    
    //-----------
    NSString * url = [NSString stringWithFormat:@"http://api.kinopro365.com/v1/%@?token=%@",method,token];
    
    //    NSLog(@"URL: %@",url);
    NSString * encodedURL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    //-------------------
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager.requestSerializer setValue:[[SingleTone sharedManager] localization] forHTTPHeaderField:@"Accept-Language"];
    //Запрос
    [manager POST:encodedURL parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        compitionBack (responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
    
}

-(void) postImageDataFromSeverWithMethod: (NSString *) method
                               andParams: (NSDictionary *) params
                                andToken: (NSString *) token
                                andImage: (UIImage*) image
                         complitionBlock: (void (^) (id response)) compitionBack
{
    

    NSString * url = [NSString stringWithFormat:@"http://api.kinopro365.com/v1/%@?token=%@",method,token];
    
    NSString * encodedURL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    NSData *imageLoad = UIImageJPEGRepresentation(image,0.8);
    
    NSUInteger imageSize = [imageLoad length];
    NSLog(@"SIZE %lu",imageSize);
    //-------------------
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager.requestSerializer setValue:[[SingleTone sharedManager] localization] forHTTPHeaderField:@"Accept-Language"];
    [manager POST:encodedURL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         
         NSString * randomFile= [self randomStringWithLength:8];
         NSString * filename = [NSString stringWithFormat:@"%@.jpg",randomFile];
         [formData appendPartWithFileData:imageLoad name:@"file1" fileName:filename mimeType:@"image/jpeg"];
     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         compitionBack (responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
    
}

-(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

@end
