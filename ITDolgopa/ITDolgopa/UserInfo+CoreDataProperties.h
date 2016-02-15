//
//  UserInfo+CoreDataProperties.h
//  ITDolgopa
//
//  Created by Кирилл Ковыршин on 13.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *deviceToken;
@property (nullable, nonatomic, retain) NSString *salt;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *userId;
@property (nullable, nonatomic, retain) NSString *serverId;
@property (nullable, nonatomic, retain) NSString *fio;

@end

NS_ASSUME_NONNULL_END
