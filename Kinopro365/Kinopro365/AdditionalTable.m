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
- (void)insertDataIntoDataBaseWithName:(NSString *) additionalName
                    andAdditionalValue: (NSString *) additionalValue{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    @try {
        
        [realm beginWriteTransaction];

        self.additionalID = [self getNextID];
        self.additionalName  = additionalName;
        self.additionalValue  = additionalValue;
        self.isSendToServer = @"0";
        
        
        
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

-(NSString *) getNextID{
    
    RLMResults *tableDataArray = [[AdditionalTable allObjects] sortedResultsUsingProperty:@"additionalID" ascending:YES];
    NSString * resulID;
    if(tableDataArray.count>0){
        
        AdditionalTable * additionalTable = [tableDataArray lastObject];
        NSLog(@"LAST OBJECT %@",additionalTable.additionalID);
        NSInteger lastAdditionalID = [additionalTable.additionalID integerValue];
        NSInteger nextID = lastAdditionalID++;
       resulID = [NSString stringWithFormat:@"%ld",nextID];
        
    }else{
        resulID = @"0";
    }
    
    return resulID;
    
}

@end
