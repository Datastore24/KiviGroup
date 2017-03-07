//
//  AddVacanciesModel.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 06.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddVacanciesModel : NSObject

- (void) addVacanciesName: (NSString *) name andLogoID: (NSString *) logoID andEndAt: (NSString *) endAt andProfessionID: (NSString *) professionID andCountryID: (NSString *) countryID andCityID: (NSString *) cityID andDescription: (NSString *) description complitionBlock: (void (^) (id response)) compitionBack;
- (void) editVacanciesName: (NSString *) name andLogoID: (NSString *) logoID andEndAt: (NSString *) endAt andProfessionID: (NSString *) professionID andCountryID: (NSString *) countryID andCityID: (NSString *) cityID andDescription: (NSString *) description andVacancyID:(NSString *) vacancyID complitionBlock: (void (^) (id response)) compitionBack;

@end
