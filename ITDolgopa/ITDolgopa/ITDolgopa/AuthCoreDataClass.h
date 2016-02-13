//
//  AuthCoreDataClass.h
//  ITDolgopa
//
//  Created by Кирилл Ковыршин on 13.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthCoreDataClass : NSObject
- (void) putDeviceToken:(NSString *) deviceToken;
- (BOOL)checkDeviceToken:(NSString*) deviceToken;
- (void)updateToken:(NSString *)deviceToken;
- (NSArray *) showAllUsers;
- (void)updateUser:(NSString *) user
           andSalt: (NSString*) salt
          andPhone: (NSString*) phone;
- (BOOL)checkSalt:(NSString*) salt;

@end
