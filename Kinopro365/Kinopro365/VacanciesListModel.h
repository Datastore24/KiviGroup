//
//  VacanciesListModel.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 06.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VacanciesListModelDelegate <NSObject>

- (void) loadVacancies:(NSDictionary *) vacanDict;

@end

@interface VacanciesListModel : NSObject

@property (assign, nonatomic) id <VacanciesListModelDelegate> delegate;

-(void) loadVacanciesFromServerOffset: (NSString *) offset
                             andCount: (NSString *) count
                         andCountryID: (NSString *) countryID
                            andCityID: (NSString *) cityID;

-(void) loadCastingsFromServerOffset: (NSString *) offset
                            andCount: (NSString *) count
                        andCountryID: (NSString *) countryID
                           andCityID: (NSString *) cityID
                     andProfessionID: (NSString *) professionID
                    andProjectTypeID: (NSString *) profjectTypeID;
@end
