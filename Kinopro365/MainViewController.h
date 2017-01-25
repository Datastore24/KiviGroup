//
//  MainViewController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 08.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HexColors.h"
#import "Macros.h"
#import "UILabel+TitleCategory.h"
#import "CustomButton.h"

@interface MainViewController : UIViewController

//Алерты----
- (void) showAlertWithMessage: (NSString*) message;
- (void) showAlertWithMessageWithBlock: (NSString*) message block: (void (^)(void)) compilationBack;
- (void) showDataPickerBirthdayWithButton: (UIButton*) button;
- (void) showViewPickerWithButton: (CustomButton*) button andTitl: (NSString*) message andArrayData: (NSArray *) arrayData andKeyTitle:(NSString *) dictKeyTitle andKeyID:(NSString *) dictKeyID andDefValueIndex: (NSString *) defValueIndex;

//Джестер на скрытие всех textFilds
- (void) hideAllTextFildWithMainView: (UIView*) view;

//Переход к новому контроллеру---
- (void) pushCountryControllerWithIdentifier: (NSString*) identifier;

//Создание и удаление Активити
- (void) createActivitiIndicatorAlertWithView;
- (void) deleteActivitiIndicator;

@end
