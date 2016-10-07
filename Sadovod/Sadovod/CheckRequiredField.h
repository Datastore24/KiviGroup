//
//  CheckRequiredField.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 07.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckRequiredField : NSObject
+ (BOOL) validateEmail: (NSString *) candidate ;
+ (BOOL) checkField: (NSString *) field andFieldTwo: (NSString *) filedTwo countText: (int) count andType:(NSString *) type
    andErrorMessage:(NSString *) message;
@end
