//
//  CoutryModel.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 15.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CoutryModelDelegate <NSObject>

@required

@property (strong, nonatomic) NSArray * countryArray;
-(void) reloadTable;


@end

@interface CoutryModel : NSObject

@property (assign, nonatomic) id <CoutryModelDelegate> delegate;

- (void) getCountryArrayToTableView: (void (^) (void)) compitionBack;
- (void) putCountryIdToProfle: (NSString *) countryID;
- (void) putCityIdToProfle: (NSString *) cityID;
- (void) getCityArrayToTableView: (NSString *) countryID block: (void (^) (void)) compitionBack;


@end
