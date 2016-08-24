//
//  MessagePopUp.h
//  FlowersOnline
//
//  Created by Кирилл Ковыршин on 15.08.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckDataServer : NSObject
+ (void)checkDataServerWithBlock: (id)object andMessage:(NSString*)message view:(UIView *) view complitionBlock: (void (^) (void)) block;

+ (void)checkDataServer: (id)object andMessage:(NSString*)message view:(id) view;

@end
