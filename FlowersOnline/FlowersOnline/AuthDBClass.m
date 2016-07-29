//
//  AuthDbClass.m
//  PsychologistIOS
//
//  Created by Кирилл Ковыршин on 14.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "AuthDbClass.h"
#import "Auth.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation AuthDBClass



//Проверка токена в CoreData
- (BOOL)checkRegistration{
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"uid ==[c] 1"];
    Auth *authFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    // If a person was founded
    if (authFounded)
    {
        return YES;
    }else{
        return NO;
    }
}




//Обновление данных пользователя
- (void)registerUser:(NSString *) name
        andEmail: (NSString*) email
        andAddress: (NSString*) address
       andPhone: (NSString*) phone

{
    
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Auth.sqlite"];
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    Auth *auth = [Auth MR_createEntityInContext:localContext];
    auth.uid =@"1";

    auth.name = name;
    auth.email = email;
    auth.address = address;
    auth.phone = phone;
    
    NSLog(@"REGISTRATION COMPLETE");
    [localContext MR_saveToPersistentStoreAndWait];
    
  
}





-(NSArray *) showAllUsers{
    NSArray *users            = [Auth MR_findAll];
    return users;
}

-(void) deleteAll{
    
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


@end
