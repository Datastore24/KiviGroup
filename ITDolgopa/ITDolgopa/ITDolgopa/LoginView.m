//
//  LoginView.m
//  ITDolgopa
//
//  Created by Viktor on 05.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "LoginView.h"
#import "Macros.h"
#import "UIColor+HexColor.h"

@interface LoginView () <UITextFieldDelegate>

@end

@implementation LoginView
{
    UILabel * labelPlaceHolderPhone;
    BOOL isBool;
}

- (id)initWithView: (UIView*) view andFont: (NSString*) font
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        isBool = YES;
        //Создание Logo------------------------------------------------------------------
        //Создаем кастомную ширину лого--------------------------------------------------
        CGFloat widthLogin = (self.frame.size.width / 3) * 2;
        UIImageView * imageViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, widthLogin, widthLogin / 3.5)];
        imageViewLogo.image = [UIImage imageNamed:@"Logo.png"];
        imageViewLogo.center = self.center;
        //Создаем кастомный центр лого---------------------------------------------------
        CGPoint centerLogo = imageViewLogo.center;
        centerLogo.y = (centerLogo.y - imageViewLogo.frame.origin.y) + (imageViewLogo.frame.size.height * 2);
        imageViewLogo.center = centerLogo;
        [self addSubview:imageViewLogo];
        
        //Создание полоски вью телефона--------------------------------------------------
        UIView * viewLoginPhone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthLogin, 0.5)];
        viewLoginPhone.center = self.center;
        viewLoginPhone.backgroundColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW];
        [self addSubview:viewLoginPhone];
        
        //Плэйс холдер телефона----------------------------------------------------------
        labelPlaceHolderPhone = [[UILabel alloc] initWithFrame:CGRectMake(viewLoginPhone.frame.origin.x + 5, viewLoginPhone.frame.origin.y - 40, widthLogin, 40)];
        labelPlaceHolderPhone.text = @"Телефон";
        labelPlaceHolderPhone.textColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW];
        labelPlaceHolderPhone.font = [UIFont fontWithName:font size:20];
        [self addSubview:labelPlaceHolderPhone];
        
        //Ввод телефонного номера---------------------------------------------------------
        UITextField * textFieldInputPhone = [[UITextField alloc] initWithFrame:CGRectMake(labelPlaceHolderPhone.frame.origin.x, labelPlaceHolderPhone.frame.origin.y, widthLogin, 40)];
        textFieldInputPhone.delegate = self;
        textFieldInputPhone.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textFieldInputPhone.textColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testMethos:) name:UITextFieldTextDidChangeNotification object:textFieldInputPhone];
        [self addSubview:textFieldInputPhone];
        
    }
    return self;
}



#pragma mark - UITextFieldDelegate

//Скрытие клавиатуры----------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];    
    return YES;
}

//Анимация Лейблов при вводе текста-------------------------
- (void) testMethos: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    if (testField.text.length != 0 && isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderPhone.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderPhone.frame = rect;
            labelPlaceHolderPhone.alpha = 0.f;
            isBool = NO;
        }];
    } else if (testField.text.length == 0 && !isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderPhone.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderPhone.frame = rect;
            labelPlaceHolderPhone.alpha = 1.f;
            isBool = YES;
        }];
    }
}


@end



