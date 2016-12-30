//
//  UserInformationTable.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 21.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import <Realm/Realm.h>

@interface UserInformationTable : RLMObject

@property NSString *userID;
@property NSString *vkToken;
@property NSString *vkID;
@property NSString *siteToken;
@property NSString *expiresSiteToken;

+ (NSString *)primaryKey;
-(void)insertDataIntoDataBaseWithName:(NSString *)vkToken andVkID:(NSString *)vkID siteToken:(NSString *) siteToken andExpiresSiteToken: (NSString *) expiresSiteToken;
-(void) updateDataInDataBase;
-(void) deleteDataInDataBase:(id) array;

@end
