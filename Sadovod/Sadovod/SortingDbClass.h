//
//  SortingDbClass.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 31.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sorting+CoreDataClass.h"

@interface SortingDbClass : NSObject
- (Sorting *) sortCatID: (NSString *) catID;
- (void)deleteSort:(NSString*) catID;
- (BOOL)checkSort:(NSString*) catID
       andSort: (NSString*) sort;

- (void)updateSort:(NSString*) catID
         andSort: (NSString*) sort;

@end
