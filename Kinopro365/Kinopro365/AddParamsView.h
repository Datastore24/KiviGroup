//
//  AddParamsView.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 24.01.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddParamsViewDelegate;

@interface AddParamsView : UIView

@property (strong, nonatomic) NSString * idString;
@property (strong, nonatomic) id mainObject;
@property (weak, nonatomic) id <AddParamsViewDelegate> deleagte;

- (instancetype)initWithFrame: (CGRect) frame endTetleText: (NSString*) titleText andIdString: (NSString*) idString andType: (NSString*) type endArrayData: (NSArray*) arrayData;

@end

@protocol AddParamsViewDelegate <NSObject>

- (void) actionButtonOn: (AddParamsView*) addParamsView andButton: (UIButton*) button andArrayViewPicker: (NSArray*) array;

@end
