//
//  ButtonMenu.h
//  FlowersOnline
//
//  Created by Viktor on 30.04.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+HexColor.h"
#import "Macros.h"

@interface ButtonMenu : UIButton

+ (UIButton*) createButtonMenu;
+ (UIButton*) createButtonRegistrationWithName: (NSString*) title
                                      andColor: (NSString*) color
                                     andPointY: (CGFloat) pointY
                                       andView: (UIView*) view;

@end
