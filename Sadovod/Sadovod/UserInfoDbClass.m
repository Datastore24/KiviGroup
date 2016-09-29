//
//  UserInfoDbClass.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 29.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "UserInfoDbClass.h"
#import "UserInfo.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation UserInfoDbClass

- (NSArray *) showAllUsersInfo{
    NSArray *users            = [UserInfo MR_findAll];
    return users;
}

- (void) addInfo: (NSString *) email phone: (NSString*) phone ord_name: (NSString*) ord_name
          us_fam: (NSString*) us_fam us_otch: (NSString*) us_otch
            us_type: (NSString*) us_type inn: (NSString*) inn
            kpp: (NSString*) kpp like_delivery: (NSString*) like_delivery
            like_tk: (NSString*) like_tk like_pay: (NSString*) like_pay
            doc_date: (NSString*) doc_date doc_vend: (NSString*) doc_vend
        doc_num: (NSString*) doc_num org_name: (NSString*) org_name
            addr_index: (NSString*) addr_index contact: (NSString*) contact
        address: (NSString*) address deli_start: (NSString*) deli_start
       deli_end: (NSString*) deli_end transport: (NSString*) transport

{
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    UserInfo *userInfo = [UserInfo MR_createEntityInContext:localContext];
    userInfo.uid=@"1";
    
    NSLog(@"TYPE USER %@",us_type);
    
    email.length != 0 ? userInfo.email=email : nil;
    phone.length != 0 ? userInfo.phone=phone : nil;
    ord_name.length != 0 ? userInfo.ord_name=ord_name : nil;
     us_fam.length != 0 ? userInfo.us_fam=us_fam : nil;
    us_otch.length != 0 ? userInfo.us_otch=us_otch : nil;
    us_type.length != 0 ? userInfo.us_type=us_type : nil;
    inn.length != 0 ? userInfo.inn=inn : nil;
    kpp.length != 0 ? userInfo.kpp=kpp : nil;
    like_delivery.length != 0 ? userInfo.like_delivery=like_delivery : nil;
    like_tk.length != 0 ? userInfo.like_tk=like_tk : nil;
    like_pay.length != 0 ? userInfo.like_pay=like_pay : nil;
    doc_date.length != 0 ? userInfo.doc_date=doc_date : nil;
    doc_vend.length != 0 ? userInfo.doc_vend=doc_vend : nil;
    doc_num.length != 0 ? userInfo.doc_num=doc_num : nil;
    org_name.length != 0 ? userInfo.org_name=org_name : nil;
    addr_index.length != 0 ? userInfo.addr_index=addr_index : nil;
    contact.length != 0 ? userInfo.contact=contact : nil;
    address.length != 0 ? userInfo.address=address : nil;
    deli_start.length != 0 ? userInfo.deli_start=deli_start : nil;
    deli_end.length != 0 ? userInfo.deli_end=deli_end : nil;
    transport.length != 0 ? userInfo.transport=transport : nil;
    

    
    [localContext MR_saveToPersistentStoreAndWait];
}

- (void)updateUserInfo: (NSString *) email phone: (NSString*) phone ord_name: (NSString*) ord_name
us_fam: (NSString*) us_fam us_otch: (NSString*) us_otch
us_type: (NSString*) us_type inn: (NSString*) inn
kpp: (NSString*) kpp like_delivery: (NSString*) like_delivery
like_tk: (NSString*) like_tk like_pay: (NSString*) like_pay
doc_date: (NSString*) doc_date doc_vend: (NSString*) doc_vend
doc_num: (NSString*) doc_num org_name: (NSString*) org_name
addr_index: (NSString*) addr_index contact: (NSString*) contact
address: (NSString*) address deli_start: (NSString*) deli_start
deli_end: (NSString*) deli_end transport: (NSString*) transport
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"uid ==[c] 1"];
    UserInfo *userInfo                   = [UserInfo MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (userInfo)
    {
        
        email.length != 0 ? userInfo.email=email : nil;
        phone.length != 0 ? userInfo.phone=phone : nil;
        ord_name.length != 0 ? userInfo.ord_name=ord_name : nil;
        us_fam.length != 0 ? userInfo.us_fam=us_fam : nil;
        us_otch.length != 0 ? userInfo.us_otch=us_otch : nil;
        us_type.length != 0 ? userInfo.us_type=us_type : nil;
        inn.length != 0 ? userInfo.inn=inn : nil;
        kpp.length != 0 ? userInfo.kpp=kpp : nil;
        like_delivery.length != 0 ? userInfo.like_delivery=like_delivery : nil;
        like_tk.length != 0 ? userInfo.like_tk=like_tk : nil;
        like_pay.length != 0 ? userInfo.like_pay=like_pay : nil;
        doc_date.length != 0 ? userInfo.doc_date=doc_date : nil;
        doc_vend.length != 0 ? userInfo.doc_vend=doc_vend : nil;
        doc_num.length != 0 ? userInfo.doc_num=doc_num : nil;
        org_name.length != 0 ? userInfo.org_name=org_name : nil;
        addr_index.length != 0 ? userInfo.addr_index=addr_index : nil;
        contact.length != 0 ? userInfo.contact=contact : nil;
        address.length != 0 ? userInfo.address=address : nil;
        deli_start.length != 0 ? userInfo.deli_start=deli_start : nil;
        deli_end.length != 0 ? userInfo.deli_end=deli_end : nil;
        transport.length != 0 ? userInfo.transport=transport : nil;
    
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}

- (BOOL) checkUserInfo:(NSString *) email phone: (NSString*) phone ord_name: (NSString*) ord_name
                us_fam: (NSString*) us_fam us_otch: (NSString*) us_otch
               us_type: (NSString*) us_type inn: (NSString*) inn
                   kpp: (NSString*) kpp like_delivery: (NSString*) like_delivery
               like_tk: (NSString*) like_tk like_pay: (NSString*) like_pay
              doc_date: (NSString*) doc_date doc_vend: (NSString*) doc_vend
               doc_num: (NSString*) doc_num org_name: (NSString*) org_name
            addr_index: (NSString*) addr_index contact: (NSString*) contact
               address: (NSString*) address deli_start: (NSString*) deli_start
              deli_end: (NSString*) deli_end transport: (NSString*) transport{
 
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    
    
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:
                                               @"uid ==[c] 1"];
    UserInfo *keyFounded                   = [UserInfo MR_findFirstWithPredicate:predicate inContext:localContext];
    
    // If a person was founded
    if (keyFounded)
    {
        [self updateUserInfo:email phone:phone ord_name:ord_name us_fam:us_fam us_otch:us_otch us_type:us_type inn:inn kpp:kpp like_delivery:like_delivery like_tk:like_tk like_pay:like_pay doc_date:doc_date doc_vend:doc_vend doc_num:doc_num org_name:org_name addr_index:addr_index contact:contact address:address deli_start:deli_start deli_end:deli_end transport:transport];
        return YES;
    }else{
        [self addInfo:email phone:phone ord_name:ord_name us_fam:us_fam us_otch:us_otch us_type:us_type inn:inn kpp:kpp like_delivery:like_delivery like_tk:like_tk like_pay:like_pay doc_date:doc_date doc_vend:doc_vend doc_num:doc_num org_name:org_name addr_index:addr_index contact:contact address:address deli_start:deli_start deli_end:deli_end transport:transport];
        
        return NO;
    }
}

- (void)deleteUserInfo
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_defaultContext];
    
  [UserInfo MR_truncateAllInContext:localContext];
}



@end
