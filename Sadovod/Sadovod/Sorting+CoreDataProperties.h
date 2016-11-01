//
//  Sorting+CoreDataProperties.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 31.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "Sorting+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Sorting (CoreDataProperties)

@property (nullable, nonatomic, copy) NSString *catID;
@property (nullable, nonatomic, copy) NSString *sort;

@end

NS_ASSUME_NONNULL_END
