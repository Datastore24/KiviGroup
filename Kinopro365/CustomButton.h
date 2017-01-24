//
//  CustomButton.h
//  Hookah Manager
//
//  Created by Виктор Мишустин on 20.01.17.
//  Copyright © 2017 Viktor Mishustin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

@property (assign, nonatomic) BOOL isBool;
@property (assign, nonatomic) CGFloat size;
@property (strong, nonatomic) NSString * customFullName;
@property (strong, nonatomic) NSString * customName;
@property (strong, nonatomic) NSString * customID;
@property (strong, nonatomic) NSString * customDescription;
@property (strong, nonatomic) NSString * customImageURL;
@property (strong, nonatomic) NSArray * customArray;
@property (strong, nonatomic) NSArray * customArrayTwo;

@end
