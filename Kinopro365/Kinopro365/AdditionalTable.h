//
//  AdditionalTable.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 23.01.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Realm/Realm.h>

@interface AdditionalTable : RLMObject
@property NSString *additionalID;
@property NSString *additionalName;
@property NSString *additionalValue;
@property NSString *isSendToServer;

+ (NSString *)primaryKey;

- (void)insertDataIntoDataBaseWithName: (NSArray *) addArray;
- (void)insertDataIntoDataBaseWithName: (NSString *) additionalID andAdditionalName:(NSString *) additionalName
                    andAdditionalValue: (NSString *) additionalValue;

@end
