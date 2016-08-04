//
//  UIView+BorderView.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 02/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BorderView)

+ (void) borderViewWithHeight: (CGFloat) height
                     andWight: (CGFloat) wight
                      andView: (UIView*) view
                     andColor: (NSString*) color;

+ (void) backgroundViewWithView: (UIView*) view
                   andImageName: (NSString*) imageName;

@end
