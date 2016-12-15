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

@interface MainViewController : UIViewController

//Алерты----
- (void) showAlertWithMessage: (NSString*) message;
- (void) showDataPickerBirthdayWithButton: (UIButton*) button;

//Джестер на скрытие всех textFilds
- (void) hideAllTextFildWithMainView: (UIView*) view;

@end
