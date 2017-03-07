//
//  AdditionalTable.m
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 23.01.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "AdditionalTable.h"

@implementation AdditionalTable

+ (NSString *)primaryKey
{
    return @"additionalID";
}
- (void)insertDataIntoDataBaseWithName: (NSArray *) addArray{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    

        @try {
       
          
           [realm beginWriteTransaction];
            RLMArray * rlmArray = [[RLMArray alloc] initWithObjectClassName:@"AdditionalTable"];
            
            
            for(int i=0; i<addArray.count; i++){
                NSDictionary * dict= [addArray objectAtIndex:i];
                AdditionalTable * addTable = [[AdditionalTable alloc] init];
                
                addTable.additionalID = [dict objectForKey:@"additionalID"];
                addTable.additionalName  = [dict objectForKey:@"additionalName"];
                addTable.additionalValue  = [dict objectForKey:@"additionalValue"];
                addTable.additionalNameValue = [dict objectForKey:@"additionalNameValue"];
                
                
                [rlmArray addObject:addTable];
                
                
            }
            
             [realm addOrUpdateObjectsFromArray:rlmArray];
            
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"additionalValue BEGINSWITH %@",
                                 @"0"];
            
            RLMResults *additionalNULL = [AdditionalTable objectsWithPredicate:pred];
            
            [[RLMRealm defaultRealm] deleteObjects:additionalNULL];
            
            
           
            [realm commitWriteTransaction];
            
        
        }
    
        @catch (NSException *exception) {
            NSLog(@"exception %@",exception);
            if ([realm inWriteTransaction]) {
                [realm cancelWriteTransaction];
            }
        }
    
}

- (void)insertDataIntoDataBaseWithName: (NSString *) additionalID andAdditionalName:(NSString *) additionalName
                    andAdditionalValue: (NSString *) additionalValue{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    @try {
        
       
            [realm beginWriteTransaction];
            
            self.additionalID = additionalID;
            self.additionalName  = additionalName;
            self.additionalValue  = additionalValue;
        
            
            
            [realm addOrUpdateObject:self];
            [realm commitWriteTransaction];
        
        
        
    }
    
    @catch (NSException *exception) {
        NSLog(@"exception %@",exception);
        if ([realm inWriteTransaction]) {
            [realm cancelWriteTransaction];
        }
    }
}

-(NSString *) getNextID{
    
    RLMResults *tableDataArray = [[AdditionalTable allObjects] sortedResultsUsingProperty:@"additionalID" ascending:YES];
   
    NSString * resulID;
    if(tableDataArray.count>0){
        
        AdditionalTable * additionalTable = [tableDataArray lastObject];
        
        NSInteger lastAdditionalID = [additionalTable.additionalID integerValue];
        NSInteger nextID = lastAdditionalID+1;
      
       resulID = [NSString stringWithFormat:@"%ld",nextID];
        
    }else{
        resulID = @"1";
    }
    
    return resulID;
    
}

@end
