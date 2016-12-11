//
//  UITextField+CheckNumber.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 11.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CheckNumber)

- (BOOL)checkForNamberPhoneWithTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
                       replacementString:(NSString *)string;

@end
