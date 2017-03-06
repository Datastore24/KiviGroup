//
//  MyVacanciesModel.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 06.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol MyVacanciesModelDelegate <NSObject>

- (void) loadMyVacancies:(NSDictionary *) myVacanDict;

@end

@interface MyVacanciesModel : NSObject
@property (assign, nonatomic) id <MyVacanciesModelDelegate> delegate;

-(void) loadVacanciesFromServerOffset: (NSString *) offset
                             andCount: (NSString *) count
                          andIsActive: (NSString *) isActive;

@end
