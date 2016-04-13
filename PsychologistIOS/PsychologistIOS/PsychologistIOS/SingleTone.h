//
//  SingleTone.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleTone : NSObject

@property (strong, nonatomic) NSString * titleSubCategory;
@property (strong, nonatomic) NSString * titleCategory;
@property (strong, nonatomic) NSString * titleSubject;
@property (strong, nonatomic) NSString * titleInstruction;



+ (id)sharedManager;

@end
