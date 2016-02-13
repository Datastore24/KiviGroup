//
//  AuthCoreDataClass.h
//  ITDolgopa
//
//  Created by Кирилл Ковыршин on 13.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthCoreDataClass : NSObject
-(void) putDeviceToken:(NSString *) deviceToken;
- (BOOL)checkDeviceToken:(NSString*) deviceToken;
-(NSArray *) showAllUsers;

@end
