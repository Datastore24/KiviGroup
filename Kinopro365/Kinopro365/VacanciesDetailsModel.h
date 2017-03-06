//
//  VacanciesDetailsModel.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 06.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VacanciesDetailsModelDelegate <NSObject>

-(void) loadMyVacancies:(NSDictionary *) vacanciesDict;

@end

@interface VacanciesDetailsModel : NSObject

@property (strong, nonatomic) id <VacanciesDetailsModelDelegate> delegate;

-(void) loadVacancies: (NSString *) vacancyID;
-(void)sendVacancy: (NSString *) vacancyID complitionBlock: (void (^) (id response)) compitionBack;

@end
