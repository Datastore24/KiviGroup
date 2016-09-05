//
//  ColorButton.h
//  Sadovod
//
//  Created by Виктор Мишустин on 26/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorButton : UIButton

@property (assign, nonatomic) BOOL isBool;
@property (assign, nonatomic) NSString * customName;
@property (assign, nonatomic) NSString * customValue;

@end
