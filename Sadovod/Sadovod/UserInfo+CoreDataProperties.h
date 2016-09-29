//
//  UserInfo+CoreDataProperties.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 29.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *us_type;
@property (nullable, nonatomic, retain) NSString *ord_name;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *us_fam;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *us_otch;
@property (nullable, nonatomic, retain) NSString *inn;
@property (nullable, nonatomic, retain) NSString *kpp;
@property (nullable, nonatomic, retain) NSString *like_delivery;
@property (nullable, nonatomic, retain) NSString *like_tk;
@property (nullable, nonatomic, retain) NSString *like_pay;
@property (nullable, nonatomic, retain) NSString *doc_date;
@property (nullable, nonatomic, retain) NSString *doc_vend;
@property (nullable, nonatomic, retain) NSString *doc_num;
@property (nullable, nonatomic, retain) NSString *org_name;
@property (nullable, nonatomic, retain) NSString *addr_index;
@property (nullable, nonatomic, retain) NSString *contact;
@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *deli_start;
@property (nullable, nonatomic, retain) NSString *deli_end;
@property (nullable, nonatomic, retain) NSString *transport;
@property (nullable, nonatomic, retain) NSString *uid;

@end

NS_ASSUME_NONNULL_END
