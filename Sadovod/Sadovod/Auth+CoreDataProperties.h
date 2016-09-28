//
//  Auth+CoreDataProperties.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 22.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Auth.h"

NS_ASSUME_NONNULL_BEGIN

@interface Auth (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *catalogkey;
@property (nullable, nonatomic, retain) NSString *login;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *superkey;
@property (nullable, nonatomic, retain) NSString *token;
@property (nullable, nonatomic, retain) NSString *uid;
@property (nullable, nonatomic, retain) NSNumber *popUp;
@property (nullable, nonatomic, retain) NSString *enter;


@end

NS_ASSUME_NONNULL_END
