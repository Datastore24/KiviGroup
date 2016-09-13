//
//  AuthorizationView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 08/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AuthorizationView.h"
#import "InputTextView.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "HexColors.h"
#import "UIView+BorderView.h"
#import "SingleTone.h"

@implementation AuthorizationView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64);
        
        if ([[[SingleTone sharedManager] typeMenu] isEqualToString:@"0"]) { //Если окно авторизации
            self.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            
            UIView * viewCentre = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 130.f, self.frame.size.height / 2 - 164.f, 260.f, 160.f)];
            viewCentre.backgroundColor = [UIColor whiteColor];
            [viewCentre.layer setBorderColor:[UIColor colorWithWhite:0.8f alpha:0.6f].CGColor];
            viewCentre.layer.borderWidth = 1.5f;
            viewCentre.layer.cornerRadius = 5.f;
            [self addSubview:viewCentre];
            ;
            NSArray * arrayName = [NSArray arrayWithObjects:@"Email", @"Пароль", nil];
            for (int i = 0; i < 2; i++) {
                InputTextView * inputText = [[InputTextView alloc] initInputTextWithView:viewCentre
                                                                                 andRect:CGRectMake(15.f, 10.f + 40 * i, viewCentre.frame.size.width - 30.f, 40) andImage:nil
                                                                      andTextPlaceHolder:[arrayName objectAtIndex:i] colorBorder:nil];
                if (i == 0) {
                    inputText.textFieldInput.keyboardType = UIKeyboardTypeEmailAddress;
                } else if (i == 1) {
                    inputText.textFieldInput.secureTextEntry = YES;
                }
                inputText.textFieldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
                inputText.textFieldInput.textColor = [UIColor blackColor];
                inputText.labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
                inputText.labelPlaceHoldInput.textColor = [UIColor lightGrayColor];
                [viewCentre addSubview:inputText];
                [UIView borderViewWithHeight:39.f andWight:10.f andView:inputText andColor:@"efeff4" andHieghtBorder:1.f];
            }
            
            
            UIButton * buttonEntrance = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonEntrance.frame = CGRectMake(15.f, 105.f, viewCentre.frame.size.width - 30.f, 40);
            buttonEntrance.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
            [buttonEntrance setTitle:@"Войти" forState:UIControlStateNormal];
            [buttonEntrance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            buttonEntrance.layer.cornerRadius = 3.f;
            buttonEntrance.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:16];
            [viewCentre addSubview:buttonEntrance];
            
            UIButton * buttonRegistration = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonRegistration.frame = CGRectMake(30.f, 260.f, 100, 20);
            [buttonRegistration setTitle:@"Регистрация" forState:UIControlStateNormal];
            [buttonRegistration setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800] forState:UIControlStateNormal];
            buttonRegistration.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:16];
            [self addSubview:buttonRegistration];
            
            
            UIButton * buttonPassword = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonPassword.frame = CGRectMake(140.f, 260.f, 150, 20);
            [buttonPassword setTitle:@"Напомнить пароль" forState:UIControlStateNormal];
            [buttonPassword setTitleColor:[UIColor hx_colorWithHexRGBAString:@"5C5C5C"] forState:UIControlStateNormal];
            buttonPassword.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:16];
            [self addSubview:buttonPassword];
        } else { //Если мой профиль
            
//            NSArray * arrayNames = [NSArray arrayWithObjects:@"Имя", @"Email", @"Пароль", @"Платежный счет", nil];
//            for (int i = 0; i < 4; i++) {
//                CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:370.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:@"000000"
//                                                                                 andText:@"Обратите внимание:"];
//                labelTitl.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
//                labelTitl.textAlignment = NSTextAlignmentLeft;
//                labelTitl.numberOfLines = 1;
//                [self.mainScrollView addSubview:labelTitl];
//            }
            
            
            
            
        }
        
    }
    return self;
}

@end
