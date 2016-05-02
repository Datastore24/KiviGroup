//
//  LoginView.m
//  FlowersOnline
//
//  Created by Viktor on 30.04.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "LoginView.h"
#import "InputTextView.h"
#import "ButtonMenu.h"

@implementation LoginView

- (instancetype)initBackGroundWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        UIImageView * imageBackGround = [[UIImageView alloc] initWithFrame:self.frame];
        imageBackGround.image = [UIImage imageNamed:@"BGImage.png"];
        [self addSubview:imageBackGround];
    }
    return self;
}

- (instancetype)initContentWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        NSArray * arrayImageName = [NSArray arrayWithObjects:@"UserNameImage.png", @"PasswordImage.png", nil];
        NSArray * arrayName = [NSArray arrayWithObjects:@"Имя", @"Пароль", nil];
        //Создание полей ввода текста----
        for (int i = 0; i < arrayImageName.count; i++) {
            InputTextView * inputText = [[InputTextView alloc] initWithView:self PointY:460 + 76 * i andImage:[arrayImageName objectAtIndex:i] andTextPlaceHolder:[arrayName objectAtIndex:i]];
            [self addSubview:inputText];
        }
        //Создание кнопки----------------
        UIButton * buttonRegistration = [ButtonMenu createButtonRegistrationWithName:@"Войти" andColor:COLORGREEN andPointY:612 andView:self];
        [buttonRegistration addTarget:self action:@selector(buttonRegistrationAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonRegistration];
        
    }
    return self;
}

#pragma mark - ActionMethods

- (void) buttonRegistrationAction
{
    NSLog(@"buttonRegistrationAction");
}

@end
