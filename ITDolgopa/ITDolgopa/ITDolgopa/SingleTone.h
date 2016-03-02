//
//  SingleTone.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleTone : NSObject

@property (strong,nonatomic) NSMutableArray* deviceToken;
@property (strong, nonatomic) NSString* phone;
@property (strong, nonatomic) NSString* billingBalance;
@property (assign, nonatomic) BOOL tableChange;
@property (strong, nonatomic) NSDictionary * dictDevice;
@property (strong, nonatomic) NSString* stringFIO;


+ (id)sharedManager;

@end
