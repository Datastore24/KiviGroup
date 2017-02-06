//
//  ProfessionsTable.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 23.01.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Realm/Realm.h>

@interface ProfessionsTable : RLMObject
@property NSString *professionID;
@property NSString *professionName;


+ (NSString *)primaryKey;
- (void)insertDataIntoDataBaseWithName: (NSArray *) addArray;
- (void)insertDataIntoDataBaseWithName:(NSString *)professionID andProfessionName:(NSString *)professionName;
@end
