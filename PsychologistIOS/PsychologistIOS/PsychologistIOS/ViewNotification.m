//
//  ViewNotification.m
//  PsychologistIOS
//
//  Created by Виктор Мишустин on 19.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "ViewNotification.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation ViewNotification
{
    bool isBool;
}

- (instancetype)initWithView: (UIView*) view andIDDel: (id) object
{
    self = [super init];
    if (self) {
        
        isBool = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upNotificationView) name:NOTIFICATION_UP_VIEW_NOTIFICATION object:nil];
        
        //Всплывающее вью нотификации-------------------------------------
        self.frame = CGRectMake(20, view.frame.size.height - 40, view.frame.size.width - 40, 80);
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.f;
        
        UIImageView * imageViewNotification = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        imageViewNotification.image = [UIImage imageNamed:@"notificationAlert.png"];
        [self addSubview:imageViewNotification];
        
        UIButton * buttonSend = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSend.frame = CGRectMake(imageViewNotification.frame.size.width - 80, 0, 80, 80);
        [buttonSend setTitle:@"Перейти" forState:UIControlStateNormal];
        [buttonSend setTitleColor:[UIColor colorWithHexString:@"a3a2a2"] forState:UIControlStateNormal];
        buttonSend.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:13];
        [buttonSend addTarget:self action:@selector(testMethod) forControlEvents:UIControlEventTouchUpInside];
        [imageViewNotification addSubview:buttonSend];

    }
    return self;
}

- (void) upNotificationView {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(backAnimation) withObject:nil afterDelay:10];
    }];
}

- (void) testMethod
{
    NSLog(@"testMethod");
}

- (void) backAnimation
{
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0.f;
        } completion:^(BOOL finished) {
        }];
}


- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
