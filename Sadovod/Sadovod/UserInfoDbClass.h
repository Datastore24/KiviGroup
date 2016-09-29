//
//  UserInfoDbClass.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 29.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoDbClass : NSObject
- (NSArray *) showAllUsersInfo;
- (void)deleteUserInfo;
- (BOOL) checkUserInfo;
- (void) addInfo: (NSString *) email phone: (NSString*) phone ord_name: (NSString*) ord_name
          us_fam: (NSString*) us_fam us_otch: (NSString*) us_otch
         us_type: (NSString*) us_type inn: (NSString*) inn
             kpp: (NSString*) kpp like_delivery: (NSString*) like_delivery
         like_tk: (NSString*) like_tk like_pay: (NSString*) like_pay
        doc_date: (NSString*) doc_date doc_vend: (NSString*) doc_vend
         doc_num: (NSString*) doc_num org_name: (NSString*) org_name
      addr_index: (NSString*) addr_index contact: (NSString*) contact
         address: (NSString*) address deli_start: (NSString*) deli_start
        deli_end: (NSString*) deli_end transport: (NSString*) transport;

- (BOOL) checkUserInfo:(NSString *) email phone: (NSString*) phone ord_name: (NSString*) ord_name
                us_fam: (NSString*) us_fam us_otch: (NSString*) us_otch
               us_type: (NSString*) us_type inn: (NSString*) inn
                   kpp: (NSString*) kpp like_delivery: (NSString*) like_delivery
               like_tk: (NSString*) like_tk like_pay: (NSString*) like_pay
              doc_date: (NSString*) doc_date doc_vend: (NSString*) doc_vend
               doc_num: (NSString*) doc_num org_name: (NSString*) org_name
            addr_index: (NSString*) addr_index contact: (NSString*) contact
               address: (NSString*) address deli_start: (NSString*) deli_start
              deli_end: (NSString*) deli_end transport: (NSString*) transport;
@end
