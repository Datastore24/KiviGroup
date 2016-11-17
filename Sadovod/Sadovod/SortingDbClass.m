//
//  SortingDbClass.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 31.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SortingDbClass.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation SortingDbClass

- (void)addSort: (NSString *) catID
       andSort: (NSString*) sort {
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    Sorting *sorting = [Sorting MR_createEntityInContext:localContext];
    sorting.catID = catID;
    sorting.sort = sort;

    
    [localContext MR_saveToPersistentStoreAndWait];
}

- (BOOL)checkSort:(NSString*) catID
        andSort: (NSString*) sort{
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:
                                               @"catID ==[c] %@", catID];
    Sorting *keyFounded                   = [Sorting MR_findFirstWithPredicate:predicate inContext:localContext];
    
    // If a person was founded
    if (keyFounded)
    {
        NSLog(@"UPDATE");
        [self updateSort:catID andSort:sort];
        return YES;
        
    }else{
        NSLog(@"ADD");
        [self addSort:catID andSort:sort];
        return NO;
    }
}

//Обновление
- (void)updateSort:(NSString*) catID
          andSort:(NSString *) sort
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"catID ==[c] %@",catID];
    Sorting *sortingFounded                   = [Sorting MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (sortingFounded)
    {
        
        sortingFounded.catID = catID;
        sortingFounded.sort = sort;
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}
//


//

- (void)deleteSort:(NSString *)catID
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"catID ==[c] %@",catID];
    Sorting *authFounded                   = [Sorting MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (authFounded)
    {
        // Delete the person found
        [authFounded MR_deleteEntityInContext:localContext];
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}





-(Sorting *) sortCatID: (NSString *) catID{
    
    Sorting *sorting = [Sorting MR_findFirstByAttribute:@"catID"
                                           withValue:catID];
    return sorting;
}


@end
