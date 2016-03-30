//
//  RegistrationView.m
//  ITDolgopa
//
//  Created by Viktor on 15.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "RegistrationView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "FontSizeChanger.h"

@interface RegistrationView () <UITextFieldDelegate>

@end

@implementation RegistrationView
{
    UIScrollView * mainScrollView;
    UILabel * labelPlaceHolderPhone;
    UILabel * labelPlaceHolderSMS;
    UITextField * textFieldInputPhone;
    UITextField * textFieldInputSMS;
    BOOL isBool;
    BOOL isBoolSMS;
    
}

- (id)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        isBool = YES;
        isBoolSMS = YES;
        
        //Изменение размеров
        NSDictionary * fontSize = [FontSizeChanger changeFontSize];
        
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);        
        //Создание scrollView------------------------------------------------------------
        mainScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        mainScrollView.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
        [self addSubview:mainScrollView];
        
        
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
        [mainScrollView addSubview:imageViewLogo];
        
        
        //Создание полоски вью телефона--------------------------------------------------
        UIView * viewLoginPhone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthLogin, 0.5)];
        viewLoginPhone.center = self.center;
        viewLoginPhone.tag = 3021;
        viewLoginPhone.backgroundColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW];
        [mainScrollView addSubview:viewLoginPhone];
        
        //Плэйс холдер телефона----------------------------------------------------------
        labelPlaceHolderPhone = [[UILabel alloc] initWithFrame:CGRectMake(viewLoginPhone.frame.origin.x + 5, viewLoginPhone.frame.origin.y - 35, widthLogin, 40)];
        labelPlaceHolderPhone.tag = 3022;
        labelPlaceHolderPhone.text = @"Телефон";
        labelPlaceHolderPhone.textColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW];
        labelPlaceHolderPhone.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:[[fontSize objectForKey:@"textField"] intValue]];
        [mainScrollView addSubview:labelPlaceHolderPhone];
        
        //Ввод телефонного номера---------------------------------------------------------
        textFieldInputPhone = [[UITextField alloc] initWithFrame:CGRectMake(labelPlaceHolderPhone.frame.origin.x, labelPlaceHolderPhone.frame.origin.y, widthLogin, 40)];
        textFieldInputPhone.delegate = self;
        textFieldInputPhone.tag = 312;
        textFieldInputPhone.keyboardAppearance = UIKeyboardAppearanceDark;
        textFieldInputPhone.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldInputPhone.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textFieldInputPhone.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:[[fontSize objectForKey:@"textField"] intValue]];
        textFieldInputPhone.textColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelPhone:) name:UITextFieldTextDidChangeNotification object:textFieldInputPhone];
        [mainScrollView addSubview:textFieldInputPhone];
        
        //Создаем вью главы SMS--------------------------------------------------------------
        UIView * mainViewSMS = [[UIView alloc] initWithFrame:CGRectMake(viewLoginPhone.frame.origin.x, textFieldInputPhone.frame.origin.y + 50, widthLogin, 150)];
        mainViewSMS.tag = 305;
        [mainScrollView addSubview:mainViewSMS];
        
        //Создание полоски вью СМС-----------------------------------------------------------
        UIView * viewLoginSMS = [[UIView alloc] initWithFrame:CGRectMake(0, 40, widthLogin, 0.5)];
        viewLoginSMS.backgroundColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW];
        [mainViewSMS addSubview:viewLoginSMS];
        
        //Плэйс холдер СМС-------------------------------------------------------------------
        labelPlaceHolderSMS = [[UILabel alloc] initWithFrame:CGRectMake(viewLoginSMS.frame.origin.x + 5, viewLoginSMS.frame.origin.y - 35, widthLogin, 40)];
        labelPlaceHolderSMS.text = @"Фамилия Имя Отчество";
        labelPlaceHolderSMS.textColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW];
        labelPlaceHolderSMS.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:[[fontSize objectForKey:@"textField"] intValue]];
        [mainViewSMS addSubview:labelPlaceHolderSMS];
        
        //Ввод телефонного номера---------------------------------------------------------
        textFieldInputSMS = [[UITextField alloc] initWithFrame:CGRectMake(labelPlaceHolderSMS.frame.origin.x, labelPlaceHolderSMS.frame.origin.y, widthLogin, 40)];
        textFieldInputSMS.delegate = self;
        textFieldInputSMS.tag = 313;
        textFieldInputSMS.keyboardAppearance = UIKeyboardAppearanceDark;
        textFieldInputSMS.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldInputSMS.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textFieldInputSMS.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:[[fontSize objectForKey:@"textField"] intValue]];
        textFieldInputSMS.textColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelSMS:) name:UITextFieldTextDidChangeNotification object:textFieldInputSMS];
        [mainViewSMS addSubview:textFieldInputSMS];
        
        //Создание кнопки ввода ПОЛУЧИТЬ КОД----------------------------------------------
        UIButton * buttonRegistration = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonRegistration.frame = CGRectMake(0, textFieldInputSMS.frame.origin.y + 90, widthLogin, widthLogin / 7.8f);
        buttonRegistration.tag = 310;
        buttonRegistration.backgroundColor = [UIColor colorWithHexString:MAINCOLORBUTTONLOGIN];
        buttonRegistration.layer.borderColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW].CGColor;
        buttonRegistration.layer.borderWidth = 1.f;
        buttonRegistration.layer.cornerRadius = 13.f;
        [buttonRegistration setTitle:@"ЗАРЕГЕСТРИРОВАТЬСЯ" forState:UIControlStateNormal];
        [buttonRegistration setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonRegistration.titleLabel.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:[[fontSize objectForKey:@"buttonSize"] intValue]];
        [mainViewSMS addSubview:buttonRegistration];
        //Картинка конверта подвязанная у кнопке---------------------------------------------
        UIImageView * imageViewbuttonRegistration = [[UIImageView alloc] initWithFrame:CGRectMake(20, buttonRegistration.frame.size.height / 4, (buttonRegistration.frame.size.height / 2) / 1.15f, buttonRegistration.frame.size.height / 2)];
        imageViewbuttonRegistration.image = [UIImage imageNamed:@"iconUser.png"];
        [buttonRegistration addSubview:imageViewbuttonRegistration];
        
    }
    return self;
}

//Отвязка от всех нотификаций------------------------------
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - UITextFieldDelegate

//Скрытие клавиатуры----------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//Метод ввода тоьлко чисел-----------------------------------
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    /* for backspace */
    if([string length]==0){
        return YES;
    }
    
    /*  limit to only numeric characters  */
    
    if ([textField isEqual:textFieldInputPhone]) {
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if ([myCharSet characterIsMember:c]) {
                
                
                /*  limit the users input to only 9 characters  */
                NSUInteger newLength = [textField.text length] + [string length] - range.length;
                return (newLength > 12) ? NO : YES;
            }
        }
        return NO;
    } else {
        /*  limit the users input to only 9 characters  */
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 40) ? NO : YES;
    }
    
    return NO;
}

//Анимация Лейблов при вводе Телефона------------------------
- (void) animationLabelPhone: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    
    if (testField.text.length < 3) {
        testField.text = @"+7";
    }
    
    
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

//Анимация Лейблов при вводе SMS-------------------------
- (void) animationLabelSMS: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    if (testField.text.length != 0 && isBoolSMS) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderSMS.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderSMS.frame = rect;
            labelPlaceHolderSMS.alpha = 0.f;
            isBoolSMS = NO;
        }];
    } else if (testField.text.length == 0 && !isBoolSMS) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderSMS.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderSMS.frame = rect;
            labelPlaceHolderSMS.alpha = 1.f;
            isBoolSMS = YES;
        }];
    }
}

//Поднимаем текст вверх--------------------------------------
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:textFieldInputPhone]) {
        if ([textField.text isEqualToString:@""]) {
            textField.text = @"+7";
            if (textField.text.length != 0 && isBool) {
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect rect;
                    rect = labelPlaceHolderPhone.frame;
                    rect.origin.x = rect.origin.x + 100.f;
                    labelPlaceHolderPhone.frame = rect;
                    labelPlaceHolderPhone.alpha = 0.f;
                    isBool = NO;
                }];
            }
            
        }
    }
    mainScrollView.contentOffset = (CGPoint){
        0, // ось x нас не интересует
        80 // Скроллим скролл к верхней границе текстового поля - Вы можете настроить эту величину по своему усмотрению
    };
    textField.textAlignment = NSTextAlignmentLeft;
}

//Восстанавливаем стандартный размер-----------------------
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:textFieldInputPhone]) {
        if ([textField.text isEqualToString:@"+7"]) {
            textField.text = @"";
            if (textField.text.length == 0 && !isBool) {
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
    }
    mainScrollView.contentOffset = (CGPoint){0, 0}; // Возвращаем скролл в начало, так как редактирование текстового поля закончено
    textField.textAlignment = NSTextAlignmentCenter;
}

@end
