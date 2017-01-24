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
@end
