//
//  ChooseProfessionalModel.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 16.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChooseProfessionalModelDelegate <NSObject>

@optional

@property (strong, nonatomic) NSArray * mainArrayData;
@property (strong, nonatomic) NSMutableString * professianString;
- (void) reloadTable;
- (void) addObjectToDataArray:(NSDictionary *) dict finish:(BOOL) isFinish;
- (void) creationStringWithString: (NSString*) string andChooseParams: (BOOL) chooseParams andString: (NSMutableString *) proffesianString;



@end

@interface ChooseProfessionalModel : NSObject
@property (assign, nonatomic) id <ChooseProfessionalModelDelegate> delegate;


- (void) getProfessionalArrayToTableView;
- (void) getArrayToTableView;
+ (NSArray *) getArrayProfessions;
+ (NSArray *) getArrayProfessionsForVacancy;
+ (NSArray *) getArrayProfessionsForCastings;
@end
