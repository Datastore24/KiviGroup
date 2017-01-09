//
//  SingleTone.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SingleTone : NSObject

@property (strong, nonatomic) NSString * country_citi;
@property (strong, nonatomic) NSString * professionControllerCode; //0 - Выбо профессии 1 - Выбор языка
@property (strong, nonatomic) NSString * stringAletForWebView;
@property (strong, nonatomic) NSString * token;


+ (id)sharedManager;

@end