//
//  AddParamsView.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 24.01.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@protocol AddParamsViewDelegate;

@interface AddParamsView : UIView

@property (strong, nonatomic) NSString * idString;
@property (strong, nonatomic) id mainObject;
@property (strong, nonatomic) NSDictionary * mainDict;
@property (weak, nonatomic) id <AddParamsViewDelegate> deleagte;

- (instancetype)initWithFrame: (CGRect) frame andTitle:(NSString *) title andType: (NSString *) type
               andPlaceholder: (NSString *) placeholder
                        andId: (NSString *) fieldID
             andDefValueIndex: (NSString *) defValueIndex
                 andArrayData: (NSArray*) arrayData
                  andIsSearch: (BOOL) isSearch
                 andIsCasting: (BOOL) isCasting;

- (void) ChekButtonWithText: (NSString*) buttonText andBool: (BOOL) isbool;

@end

@protocol AddParamsViewDelegate <NSObject>



- (void) actionButtonOn: (AddParamsView*) addParamsView andButton: (UIButton*) button andArrayViewPicker: (NSArray*) array;

- (void) actionLangue: (AddParamsView*) addParamsView andButton: (CustomButton*) button andArrayViewPicker: (NSArray*) array;

@end
