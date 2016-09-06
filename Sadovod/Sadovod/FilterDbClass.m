//
//  FilterDB.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 06.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "FilterDbClass.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation FilterDbClass





- (void)addFilter: (NSString *) catID
       andMinCost: (NSString*) minCost andMaxCost: (NSString*) maxCost andO: (NSString*) o {
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Auth.sqlite"];
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    Filter *filter = [Filter MR_createEntityInContext:localContext];
    filter.catID = catID;
    filter.min_cost = minCost;
    filter.max_cost = maxCost;
    filter.o = o;
    
    [localContext MR_saveToPersistentStoreAndWait];
}

- (BOOL)checkFilter:(NSString*) catID
         andMinCost: (NSString*) minCost andMaxCost: (NSString*) maxCost andO: (NSString*) o{
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Auth.sqlite"];
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:
                                               @"catID ==[c] %@", catID];
    Filter *keyFounded                   = [Filter MR_findFirstWithPredicate:predicate inContext:localContext];
    
    // If a person was founded
    if (keyFounded)
    {
        return YES;
    }else{
        [self addFilter:catID andMinCost:minCost andMaxCost:maxCost andO:o];
        return NO;
    }
}

//Обновление
- (void)updateFilter:(NSString*) catID
          andMinCost: (NSString*) minCost andMaxCost: (NSString*) maxCost andO: (NSString*) o
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"catID ==[c] %@",catID];
    Filter *filterFounded                   = [Filter MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (filterFounded)
    {
        
        filterFounded.catID = catID;
        filterFounded.min_cost = minCost;
        filterFounded.max_cost = maxCost;
        filterFounded.o = o;
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}
//


//

- (void)deleteFilter:(NSString*) catID
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"catID ==[c] %@",catID];
    Filter *authFounded                   = [Filter MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (authFounded)
    {
        // Delete the person found
        [authFounded MR_deleteEntityInContext:localContext];
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}





-(Filter *) filterCatID: (NSString *) catID{
    
    Filter *filter = [Filter MR_findFirstByAttribute:@"catID"
                                           withValue:catID];
    return filter;
}

@end
