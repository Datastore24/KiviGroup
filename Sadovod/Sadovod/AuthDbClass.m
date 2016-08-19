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

@implementation AuthDbClass




- (void)addKey: (NSString *) superKey andCatalogKey: (NSString*) catalogKey{
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Auth.sqlite"];
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    Auth *auth = [Auth MR_createEntityInContext:localContext];
    auth.superkey=superKey;
    auth.catalogkey=catalogKey;
    auth.uid=@"1";
    [localContext MR_saveToPersistentStoreAndWait];
}

- (BOOL)checkKey:(NSString*) superKey andCatalogKey: (NSString*) catalogKey{
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Auth.sqlite"];
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:
                                               @"superkey ==[c] %@ AND catalogkey == [c] %@ AND uid ==[c] 1",                superKey,catalogKey];
    Auth *keyFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    // If a person was founded
    if (keyFounded)
    {
        return YES;
    }else{
        [self addKey:superKey andCatalogKey:catalogKey];
        return NO;
    }
}

- (void)deleteAuth
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
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
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
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
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
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
