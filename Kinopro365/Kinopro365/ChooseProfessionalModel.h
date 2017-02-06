//
//  ChooseProfessionalModel.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 16.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChooseProfessionalModelDelegate <NSObject>

@required

@property (strong, nonatomic) NSArray * mainArrayData;
@property (strong, nonatomic) NSMutableString * professianString;
- (void) reloadTable;
- (void) creationStringWithString: (NSString*) string andChooseParams: (BOOL) chooseParams andString: (NSMutableString *) proffesianString;



@end

@interface ChooseProfessionalModel : NSObject
@property (assign, nonatomic) id <ChooseProfessionalModelDelegate> delegate;

+ (NSArray*) getArrayToTableView;
- (void) getProfessionalArrayToTableView;

@end
