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
#import "Macros.h"

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
        
        //Создание лого--------------
        UIImageView * imageViewLogo = [[UIImageView alloc] initWithFrame: CGRectMake(self.frame.size.width / 2 - 150, 130, 300, 123)];
        imageViewLogo.image = [UIImage imageNamed:@"logo.png"];
        imageViewLogo.alpha = 0.6;
        [self addSubview:imageViewLogo];
        
        
        //Массивы с данными-------------
        NSArray * arrayImageName = [NSArray arrayWithObjects:@"UserNameImage.png", @"PasswordImage.png", nil];
        NSArray * arrayName = [NSArray arrayWithObjects:@"Имя", @"Пароль", nil];
        
        //Создание полей ввода текста----
        for (int i = 0; i < arrayImageName.count; i++) {
            InputTextView * inputText = [[InputTextView alloc] initWithView:self PointY:460 + 76 * i andImage:[arrayImageName objectAtIndex:i] andTextPlaceHolder:[arrayName objectAtIndex:i]];
            if (isiPhone6) {
                inputText.height = 400 + 76 * i;
            }
            [self addSubview:inputText];
        }
        //Создание кнопки----------------
        UIButton * buttonComeIn = [ButtonMenu createButtonRegistrationWithName:@"Войти" andColor:COLORGREEN andPointY:612 andView:self];
        [buttonComeIn addTarget:self action:@selector(buttonComeInAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonComeIn];
        
        //Содание кнопки регистрация------
        UIButton * buttonRegistration =[ButtonMenu createButtonTextWithName:@"Регистрация" andFrame:CGRectMake(20, 695, 100, 20) fontName:FONTLITE];
        buttonRegistration.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [buttonRegistration addTarget:self action:@selector(buttonRegistrationAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonRegistration];
        
        //Создание кнопки Нужна помощ----
        UIButton * buttonNeedHelp = [ButtonMenu createButtonTextWithName:@"Нужна помощ" andFrame:CGRectMake(293, 695, 100, 20) fontName:FONTREGULAR];
        buttonNeedHelp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [buttonNeedHelp addTarget:self action:@selector(buttonNeedHelpAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonNeedHelp];
        
        
        
        
    }
    return self;
}

#pragma mark - ActionMethods

- (void) buttonComeInAction
{
    NSLog(@"buttonComeInAction");
}

- (void) buttonRegistrationAction
{
    NSLog(@"buttonRegistrationAction");
}

- (void) buttonNeedHelpAction
{
    NSLog(@"buttonNeedHelpAction");
}

@end
