//
//  MessagePopUp.m
//  FlowersOnline
//
//  Created by Кирилл Ковыршин on 15.08.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "MessagePopUp.h"
#import "Macros.h"

@implementation MessagePopUp
+ (void)showPopUpWithBlock:(NSString*)message view:(UIView *) view complitionBlock: (void (^) (void)) compitionBack
{
    UIView * successView = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width/2, view.frame.size.height/2-64, view.frame.size.width-60, 100)];
    successView.backgroundColor = [UIColor lightGrayColor];
    successView.alpha=0.0f;
    successView.center = CGPointMake(view.frame.size.width  / 2,
                                     view.frame.size.height / 2);
    successView.layer.cornerRadius = 20;
    successView.layer.masksToBounds = YES;
    
    UILabel * successLabel = [[UILabel alloc] initWithFrame:CGRectMake(successView.frame.size.width/2, successView.frame.size.height/2, successView.frame.size.width, 50)];
    
    
    [successLabel setCenter:CGPointMake(successView.frame.size.width / 2, successView.frame.size.height / 2)];
    successLabel.textAlignment = NSTextAlignmentCenter;
    successLabel.text = message;
    successLabel.textColor = [UIColor whiteColor];
    successLabel.font = [UIFont fontWithName:FONTREGULAR size:20];
    
    
    [successView addSubview:successLabel];
    [view addSubview:successView];
    [UIView animateWithDuration:1.0f animations:^{
        successView.alpha=0.9f;
    } completion:^(BOOL finished) {
        NSLog(@"ANIM STOP");
        compitionBack();
        successView.alpha=0.0f;
        
    }];
    
    
}

+ (void)showPopUpWithDelay:(NSString*)message view:(UIView *) view delay:(CGFloat) delay
{
    UIView * successView = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width/2, view.frame.size.height/2-64, view.frame.size.width-60, 100)];
    successView.backgroundColor = [UIColor lightGrayColor];
    successView.alpha=0.0f;
    successView.center = CGPointMake(view.frame.size.width  / 2,
                                     view.frame.size.height / 2);
    successView.layer.cornerRadius = 20;
    successView.layer.masksToBounds = YES;
    
    UILabel * successLabel = [[UILabel alloc] initWithFrame:CGRectMake(successView.frame.size.width/2, successView.frame.size.height/2, successView.frame.size.width, 50)];
    
    
    [successLabel setCenter:CGPointMake(successView.frame.size.width / 2, successView.frame.size.height / 2)];
    successLabel.textAlignment = NSTextAlignmentCenter;
    successLabel.text = message;
    successLabel.textColor = [UIColor whiteColor];
    successLabel.font = [UIFont fontWithName:FONTREGULAR size:20];
    
    
    [successView addSubview:successLabel];
    [view addSubview:successView];
    [UIView animateWithDuration:1.0f animations:^{
        successView.alpha=0.9f;
    } completion:^(BOOL finished) {
        NSLog(@"ANIM STOP");
        sleep(delay);
        [UIView animateWithDuration:1.0f animations:^{
            successView.alpha=0.0f;
        }];
        
        
    }];
    
    
}
@end
