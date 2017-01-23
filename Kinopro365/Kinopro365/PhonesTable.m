//
//  PhonesTable.m
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 23.01.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "PhonesTable.h"

@implementation PhonesTable

+ (NSString *)primaryKey
{
    return @"phoneID";
}

-(void)insertDataIntoDataBaseWithName:(NSString *)phoneID andPhoneNumber:(NSString *)phoneNumber{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    @try {
        
        [realm beginWriteTransaction];
        
        self.phoneID = phoneID;
        self.phoneNumber  = phoneNumber;
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
