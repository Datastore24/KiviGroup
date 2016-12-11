//
//  UITextField+CheckNumber.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 11.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "UITextField+CheckNumber.h"

@implementation UITextField (CheckNumber)

- (BOOL)checkForNamberPhoneWithTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
                       replacementString:(NSString *)string
{
    
    NSCharacterSet * validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray * components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return NO;
    }
    
    NSString * newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray * validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    newString = [validComponents componentsJoinedByString:@""];
    
    static const int localNumberMaxLength = 7;
    static const int areaCodeMaxLength = 3;
    static const int countryCodeMaxLength = 1;
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
        return NO;
    }
    
    NSMutableString * resultString = [NSMutableString string];
    
    NSInteger localNumberLength = MIN((int)newString.length, localNumberMaxLength);
    
    if (localNumberLength > 0) {
        NSString * number = [newString substringFromIndex:(int)newString.length - localNumberLength];
        [resultString appendString:number];
        if ([resultString length] > 3) {
            [resultString insertString:@"-" atIndex:3];
        }
    }
    
    if ([newString length] > localNumberLength) {
        NSInteger areaCodeLength = MIN((int)newString.length - localNumberMaxLength, areaCodeMaxLength);
        NSRange areaRange = NSMakeRange((int)newString.length - localNumberMaxLength - areaCodeLength, areaCodeLength);
        NSString * area = [newString substringWithRange:areaRange];
        area = [NSString stringWithFormat:@"(%@) ", area];
        [resultString insertString:area atIndex:0];
    }
    
    if ([newString length] > localNumberLength + areaCodeMaxLength) {
        NSInteger countryCodeLength = MIN((int)newString.length - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
        NSRange countryRange = NSMakeRange(0, countryCodeLength);
        NSString * coutry = [newString substringWithRange:countryRange];
        coutry = [NSString stringWithFormat:@"+%@ ", coutry];
        [resultString insertString:coutry atIndex:0];
    }
    textField.text = resultString;
    
    return NO;
}

@end
