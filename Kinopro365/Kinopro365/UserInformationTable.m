//
//  UserInformationTable.m
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 21.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "UserInformationTable.h"

@implementation UserInformationTable

+ (NSString *)primaryKey
{
    return @"userID";
}

-(void)insertDataIntoDataBaseWithName:(NSString *)vkToken andVkID:(NSString *)vkID siteToken:(NSString *) siteToken{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    @try {
        
        [realm beginWriteTransaction];
        
        self.userID = @"1";
        self.vkToken = vkToken;
        self.vkID = vkID;
        self.siteToken = siteToken;
        self.isSendToServer = @"0";
        self.is_public_contacts = @"1";
        
        
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

-(void) updateDataInDataBase {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    //    selectedDataObject.name=name;
    //    selectedDataObject.city=city;
    [realm commitWriteTransaction];
    
}

-(void) deleteDataInDataBase:(id) array {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] deleteObjects:array];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

@end
