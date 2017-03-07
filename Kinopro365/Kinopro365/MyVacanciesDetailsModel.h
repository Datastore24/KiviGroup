//
//  MyVacanciesDetailsModel.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 07.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyVacanciesDetailsModelDelegate <NSObject>

-(void) loadMyVacancies:(NSDictionary *) vacanciesDict;

@end

@interface MyVacanciesDetailsModel : NSObject

@property (strong, nonatomic) id <MyVacanciesDetailsModelDelegate> delegate;

-(void) loadVacancies: (NSString *) vacancyID;
-(void) loadOffersProfile:(NSString *) vacancyID andOffset: (NSString *) offset andCount: (NSString *) count complitionBlock: (void (^) (id response)) compitionBack;

@end
