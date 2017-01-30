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
@property NSString *last_name;
@property NSString *first_name;
@property NSString *last_name_inter;
@property NSString *first_name_inter;
@property NSString *sex;
@property NSString *email;
@property NSString *user_comment;
@property NSString *country_id;
@property NSString *city_id;
@property NSString *birthday;
@property NSString *photo;
@property NSString *is_public_contacts;
@property NSString *isSendToServer;




+ (NSString *)primaryKey;
-(void)insertDataIntoDataBaseWithName:(NSString *)vkToken andVkID:(NSString *)vkID siteToken:(NSString *) siteToken;
-(void) updateDataInDataBase;
-(void) deleteDataInDataBase:(id) array;

@end
