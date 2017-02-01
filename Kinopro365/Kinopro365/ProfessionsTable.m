//
//  ProfessionsTable.m
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 23.01.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "ProfessionsTable.h"

@implementation ProfessionsTable

+ (NSString *)primaryKey
{
    return @"professionID";
}

-(void)insertDataIntoDataBaseWithName:(NSString *)professionID andProfessionName:(NSString *)professionName{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    @try {
        
        [realm beginWriteTransaction];
        
        self.professionID = professionID;
        self.professionName  = professionName;
        
        
        [realm addOrUpdateObject:self];
        [realm commitWriteTransaction];
        
    }
    
    @catch (NSException *exception) {
        NSLog(@"exception");
        if ([realm inWriteTransaction]) {
            [realm cancelWriteTransaction];
        }
    }
}

- (void)insertDataIntoDataBaseWithName: (NSArray *) addArray{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    
    
    @try {
        
        
        [realm beginWriteTransaction];
        RLMArray * rlmArray = [[RLMArray alloc] initWithObjectClassName:@"ProfessionsTable"];
        
        
        for(int i=0; i<addArray.count; i++){
            NSDictionary * dict= [addArray objectAtIndex:i];
            ProfessionsTable * addTable = [[ProfessionsTable alloc] init];
            
            addTable.professionID = [dict objectForKey:@"additionalID"];
            addTable.professionName  = [dict objectForKey:@"additionalName"];
            
            
            [rlmArray addObject:addTable];
            
            
        }
        
        
        [realm addOrUpdateObjectsFromArray:rlmArray];
        [realm commitWriteTransaction];
        
        
    }
    
    @catch (NSException *exception) {
        NSLog(@"exception %@",exception);
        if ([realm inWriteTransaction]) {
            [realm cancelWriteTransaction];
        }
    }
    
}

@end
