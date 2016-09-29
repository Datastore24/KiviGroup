//
//  AuthDbClass.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 19.08.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AuthDbClass.h"
#import "Auth.h"
#import <MagicalRecord/MagicalRecord.h>
#import "SingleTone.h"
#import "Macros.h"

@implementation AuthDbClass


- (void)addKey: (NSString *) superKey andCatalogKey: (NSString*) catalogKey{
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    Auth *auth = [Auth MR_createEntityInContext:localContext];
    auth.superkey=superKey;
    auth.catalogkey=catalogKey;
    auth.uid=@"1";
    auth.enter=@"0";
    [localContext MR_saveToPersistentStoreAndWait];
}

- (BOOL)checkKey:(NSString*) superKey andCatalogKey: (NSString*) catalogKey{
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    
    
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:
                                               @"superkey ==[c] %@ AND catalogkey == [c] %@ AND uid ==[c] 1",                superKey,catalogKey];
    Auth *keyFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    // If a person was founded
    if (keyFounded)
    {
       
        return YES;
    }else{
        [self deleteAuth];
         [[SingleTone sharedManager] setTypeMenu:@"0"]; //Меняем синглтон авторизации
        [self addKey:superKey andCatalogKey:catalogKey];
        return NO;
    }
}

- (BOOL)checkPopUp{
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    
    
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:
                                               @"popUp == 1 AND uid ==[c] 1"];
    Auth *keyFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    // If a person was founded
    if (keyFounded)
    {
        return YES;
    }else{
        
        return NO;
    }
}

- (void)updatePopUp
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"uid ==[c] 1"];
    Auth *authFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (authFounded)
    {
        
        authFounded.popUp = [NSNumber numberWithUnsignedInt:1];
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}

- (void)changeEnter:(NSString *) enter
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"uid ==[c] 1"];
    Auth *authFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (authFounded)
    {
        
        authFounded.enter = enter;
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}

- (BOOL)checkEnter{
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    
    
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:
                                               @"enter ==[c] 1 AND uid ==[c] 1"];
    Auth *keyFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    // If a person was founded
    if (keyFounded)
    {
        
        return YES;
    }else{

        return NO;
    }
}

- (void)deleteAuth
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"uid ==[c] 1"];
    Auth *authFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (authFounded)
    {
        // Delete the person found
        [authFounded MR_deleteEntityInContext:localContext];
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}

- (void)updateToken:(NSString *)token
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"uid ==[c] 1"];
    Auth *authFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (authFounded)
    {
        
        authFounded.token = token;
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}

- (void)DeleteUserWithOutKey
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"uid ==[c] 1"];
    Auth *authFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (authFounded)
    {
        
        authFounded.token = @"";
        authFounded.login = @"";
        authFounded.password = @"";
        
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}




-(NSArray *) showAllUsers{
    NSArray *users            = [Auth MR_findAll];
    return users;
}


@end
