//
//  FilterDB.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 06.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Filter.h"

@interface FilterDbClass : NSObject

- (Filter *) filterCatID: (NSString *) catID;
- (void)deleteFilter:(NSString*) catID;
- (BOOL)checkFilter:(NSString*) catID
         andMinCost: (NSString*) minCost andMaxCost: (NSString*) maxCost andO: (NSString*) o;

- (void)updateFilter:(NSString*) catID
          andMinCost: (NSString*) minCost andMaxCost: (NSString*) maxCost andO: (NSString*) o;


@end
