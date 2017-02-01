//
//  PhonesTable.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 23.01.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Realm/Realm.h>

@interface PhonesTable : RLMObject

@property NSString *phoneID;
@property NSString *phoneNumber;

+ (NSString *)primaryKey;

-(void)insertDataIntoDataBaseWithName:(NSString *)phoneID andPhoneNumber:(NSString *)phoneNumber ;

@end
