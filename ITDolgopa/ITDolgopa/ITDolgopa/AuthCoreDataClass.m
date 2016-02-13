//
//  AuthCoreDataClass.m
//  ITDolgopa
//
//  Created by Кирилл Ковыршин on 13.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "AuthCoreDataClass.h"
#import <MagicalRecord/MagicalRecord.h>
#import "UserInfo.h"

@implementation AuthCoreDataClass

//Метод сохраняющий deviceToken для push уведомлений
-(void) putDeviceToken:(NSString *) deviceToken {
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"UserInfo.sqlite"];
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    UserInfo *userInfo = [UserInfo MR_createEntityInContext:localContext];
    userInfo.userID =@"1";
    userInfo.deviceToken=deviceToken;
    
    NSLog(@"SAVE DEVICE TOKEN");
    [localContext MR_saveToPersistentStoreAndWait];
    
}

//Проверка токена в CoreData
- (BOOL)checkDeviceToken:(NSString*) deviceToken{
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"deviceToken ==[c] %@ AND userId ==[c] 1",deviceToken];
    UserInfo *authFounded                   = [UserInfo MR_findFirstWithPredicate:predicate inContext:localContext];
    
    // If a person was founded
    if (authFounded)
    {
        return YES;
    }else{
        return NO;
    }
}


-(NSArray *) showAllUsers{
    NSArray *users            = [UserInfo MR_findAll];
    return users;
}


@end
