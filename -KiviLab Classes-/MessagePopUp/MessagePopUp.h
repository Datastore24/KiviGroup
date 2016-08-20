//
//  MessagePopUp.h
//  FlowersOnline
//
//  Created by Кирилл Ковыршин on 15.08.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagePopUp : NSObject
+ (void)showPopUpWithBlock:(NSString*)message view:(UIView *) view complitionBlock: (void (^) (void)) compitionBack;
+ (void)showPopUpWithDelay:(NSString*)message view:(UIView *) view delay:(CGFloat) delay;
@end
