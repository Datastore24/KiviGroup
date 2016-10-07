//
//  CheckRequiredField.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 07.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CheckRequiredField.h"
#import "InputTextView.h"
#import "AlertClassCustom.h"

@implementation CheckRequiredField

+ (BOOL) checkField: (NSString *) field andFieldTwo: (NSString *) filedTwo countText: (int) count andType:(NSString *) type
    andErrorMessage:(NSString *) message{
    
    NSLog(@"%@",[field class]);
   
        
        if([type isEqualToString:@"email"]){
            NSLog(@"VALIDATE %@",field);
            if(![self validateEmail:field]){
               [AlertClassCustom createAlertWithMessage:message];
                return YES;
            }
        }
        if([type isEqualToString:@"text"]){
            if (field.length<=count) {
               [AlertClassCustom createAlertWithMessage:message];
                return YES;
            }
            
        }
        if([type isEqualToString:@"phone"]){
            if (field.length<=count && field.length != 0) {
                [AlertClassCustom createAlertWithMessage:message];
                return YES;
            }
            
        }
        

        if([type isEqualToString:@"password"]){
            if(![field isEqualToString: filedTwo] || field.length==0 || filedTwo.length==0){
            [AlertClassCustom createAlertWithMessage:message];
                return YES;
           
            }
        }
        
    
    
   return NO;
}

+ (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

@end
