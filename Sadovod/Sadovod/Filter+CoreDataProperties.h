//
//  Filter+CoreDataProperties.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 06.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Filter.h"

NS_ASSUME_NONNULL_BEGIN

@interface Filter (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *catID;
@property (nullable, nonatomic, retain) NSString *min_cost;
@property (nullable, nonatomic, retain) NSString *max_cost;
@property (nullable, nonatomic, retain) NSString *o;

@end

NS_ASSUME_NONNULL_END
