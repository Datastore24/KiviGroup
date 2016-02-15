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
    userInfo.userId =@"1";
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

//Обновление токена
- (void)updateToken:(NSString *)deviceToken
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"userId ==[c] 1"];
    UserInfo *authFounded                   = [UserInfo MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (authFounded)
    {
        
        authFounded.deviceToken = deviceToken;
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}
//

//Обновление данных пользователя
- (void)updateUser:(NSString *) user
           andSalt: (NSString*) salt
          andPhone: (NSString*) phone
       andServerId: (NSString*) serverId

{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"userId ==[c] 1"];
    UserInfo *authFounded                   = [UserInfo MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (authFounded)
    {
        
        authFounded.fio = user;
        authFounded.salt = salt;
        authFounded.phone = phone;
        authFounded.serverId = serverId;
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}


//Проверка токена в CoreData
- (BOOL)checkSalt:(NSString*) salt{
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"salt ==[c] %@ AND userId ==[c] 1",salt];
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
