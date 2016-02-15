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
#import <SCLAlertView-Objective-C/SCLAlertView.h>

@interface LoginView () <UITextFieldDelegate>

@end

@implementation LoginView
{
    UILabel * labelPlaceHolderPhone;
    UILabel * labelPlaceHolderSMS;
    UIScrollView * mainScrollView;
    UITextField * textFieldInputPhone;
    UITextField * textFieldInputSMS;
    BOOL isBool;
    BOOL isBoolSMS;
}

- (id)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        isBool = YES;
        isBoolSMS = YES;
        
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
        labelPlaceHolderPhone.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:20];
        [mainScrollView addSubview:labelPlaceHolderPhone];
        
        //Ввод телефонного номера---------------------------------------------------------
        textFieldInputPhone = [[UITextField alloc] initWithFrame:CGRectMake(labelPlaceHolderPhone.frame.origin.x, labelPlaceHolderPhone.frame.origin.y, widthLogin, 40)];
        textFieldInputPhone.delegate = self;
        textFieldInputPhone.tag = 302;
        textFieldInputPhone.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldInputPhone.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textFieldInputPhone.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:20];
        textFieldInputPhone.textColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelPhone:) name:UITextFieldTextDidChangeNotification object:textFieldInputPhone];
        [mainScrollView addSubview:textFieldInputPhone];
        
        //Создание кнопки ввода ПОЛУЧИТЬ КОД----------------------------------------------
        UIButton * buttonGetCode = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonGetCode.frame = CGRectMake(viewLoginPhone.frame.origin.x, textFieldInputPhone.frame.origin.y + 45, widthLogin, widthLogin / 7.8f);
        buttonGetCode.tag = 301;
        buttonGetCode.backgroundColor = [UIColor colorWithHexString:MAINCOLORGREENBUTTON];
        buttonGetCode.layer.borderColor = [UIColor colorWithHexString:BORDERCOLORGREENBUTTON].CGColor;
        buttonGetCode.layer.borderWidth = 1.f;
        buttonGetCode.layer.cornerRadius = 13.f;
        [buttonGetCode setTitle:@"ПОЛУЧИТЬ КОД" forState:UIControlStateNormal];
        [buttonGetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonGetCode.titleLabel.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:MAINBUTTONFONTSIZE];
        [mainScrollView addSubview:buttonGetCode];
        //Картинка конверта подвязанная у кнопке---------------------------------------------
        UIImageView * imageViewButtonGetCode = [[UIImageView alloc] initWithFrame:CGRectMake(20, buttonGetCode.frame.size.height / 4, (buttonGetCode.frame.size.height / 2) * 1.4f, buttonGetCode.frame.size.height / 2)];
        imageViewButtonGetCode.image = [UIImage imageNamed:@"iconButtonReg.png"];
        [buttonGetCode addSubview:imageViewButtonGetCode];
        
        //Создаем вью главы SMS--------------------------------------------------------------
        UIView * mainViewSMS = [[UIView alloc] initWithFrame:CGRectMake(-300, buttonGetCode.frame.origin.y + 40, widthLogin, 100)];
        mainViewSMS.tag = 305;
        [mainScrollView addSubview:mainViewSMS];
        
        //Создание полоски вью СМС-----------------------------------------------------------
        UIView * viewLoginSMS = [[UIView alloc] initWithFrame:CGRectMake(0, 40, widthLogin, 0.5)];
        viewLoginSMS.backgroundColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW];
        [mainViewSMS addSubview:viewLoginSMS];
        
        //Плэйс холдер СМС-------------------------------------------------------------------
        labelPlaceHolderSMS = [[UILabel alloc] initWithFrame:CGRectMake(viewLoginSMS.frame.origin.x + 5, viewLoginSMS.frame.origin.y - 35, widthLogin, 40)];
        labelPlaceHolderSMS.text = @"Код из СМС";
        labelPlaceHolderSMS.textColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW];
        labelPlaceHolderSMS.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:20];
        [mainViewSMS addSubview:labelPlaceHolderSMS];
        
        //Ввод телефонного номера---------------------------------------------------------
        textFieldInputSMS = [[UITextField alloc] initWithFrame:CGRectMake(labelPlaceHolderSMS.frame.origin.x, labelPlaceHolderSMS.frame.origin.y, widthLogin, 40)];
        textFieldInputSMS.delegate = self;
        textFieldInputSMS.tag = 303;
        textFieldInputSMS.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldInputSMS.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textFieldInputSMS.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:20];
        textFieldInputSMS.textColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelSMS:) name:UITextFieldTextDidChangeNotification object:textFieldInputSMS];
        [mainViewSMS addSubview:textFieldInputSMS];
        
        //Создание кнопки ввода ПОЛУЧИТЬ КОД----------------------------------------------
        UIButton * buttonLogin = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonLogin.frame = CGRectMake(0, textFieldInputSMS.frame.origin.y + 45, widthLogin, widthLogin / 7.8f);
        buttonLogin.tag = 304;
        buttonLogin.backgroundColor = [UIColor colorWithHexString:MAINCOLORBUTTONLOGIN];
        buttonLogin.layer.borderColor = [UIColor colorWithHexString:BACKGROUNDCOLORLIGINVIEW].CGColor;
        buttonLogin.layer.borderWidth = 1.f;
        buttonLogin.layer.cornerRadius = 13.f;
        [buttonLogin setTitle:@"ВОЙТИ" forState:UIControlStateNormal];
        [buttonLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonLogin.titleLabel.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:MAINBUTTONFONTSIZE];
        [mainViewSMS addSubview:buttonLogin];
        //Картинка конверта подвязанная у кнопке---------------------------------------------
        UIImageView * imageViewButtonLogin = [[UIImageView alloc] initWithFrame:CGRectMake(20, buttonLogin.frame.size.height / 4, (buttonLogin.frame.size.height / 2) / 1.15f, buttonLogin.frame.size.height / 2)];
        imageViewButtonLogin.image = [UIImage imageNamed:@"lockImage.png"];
        [buttonLogin addSubview:imageViewButtonLogin];
        
        //Вью регистрации--------------------------------------------------------------------
        UIView * viewRegistration = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthLogin, 40)];
        viewRegistration.center = self.center;
        CGPoint pointviewRegistration = viewRegistration.center;
        pointviewRegistration.y = pointviewRegistration.y + 200;
        viewRegistration.center = pointviewRegistration;
        viewRegistration.backgroundColor = nil;
        [self addSubview:viewRegistration];
        
        //Строка регистрации-----------------------------------------------------------------
        UILabel * labelRegistration = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, widthLogin, 40)];
        labelRegistration.text = @"Номер не зарегестирован?";
        labelRegistration.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:14];
        labelRegistration.textColor = [UIColor whiteColor];
        [labelRegistration sizeToFit];
        CGRect rect = labelRegistration.frame;
        rect.size.height = 40;
        labelRegistration.frame = rect;
        [viewRegistration addSubview:labelRegistration];
        
        //Кнопка регистрации------------------------------------------------------------------
        UIButton * buttonRegistration = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonRegistration.frame = CGRectMake(labelRegistration.frame.size.width, 0, viewRegistration.frame.size.width - labelRegistration.frame.size.width, 40);
        buttonRegistration.backgroundColor = nil;
        [buttonRegistration setTitle:@"Регистрация" forState:UIControlStateNormal];
        [buttonRegistration setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonRegistration.titleLabel.font = [UIFont fontWithName:@"SFUIDisplay-Bold" size:15];
        [viewRegistration addSubview:buttonRegistration];
        
        
        
        
        
        
        //СТЕКЛО!!!
        
        //Нужно прописать логику, что пока идет проверка, с экрана все убираем в alpha=0 кроме этого окна
        
        //Проверка телефона и кода
        UIView * checkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 189)];
        checkView.center = self.center;
        checkView.tag = 306;
        
        UIImageView * imageGlassCheck = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 189)];
        imageGlassCheck.image = [UIImage imageNamed:@"Glass90.png"];
        imageGlassCheck.alpha=0.8;
        
        
        UILabel * labelCheckPhone = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 290, 40)];
        labelCheckPhone.text = @"Проверка телефона...";
        labelCheckPhone.textColor = [UIColor blackColor];
        labelCheckPhone.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:17];
        
        UILabel * labelCheckCode = [[UILabel alloc] initWithFrame:CGRectMake(40, 60, 290, 40)];
        labelCheckCode.text = @"Проверка кода...";
        labelCheckCode.textColor = [UIColor blackColor];
        labelCheckCode.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:17];
        labelCheckCode.alpha=0;
        
        UILabel * labelCheckInformation = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 290, 40)];
        labelCheckInformation.text = @"Загрузка информации...";
        labelCheckInformation.textColor = [UIColor blackColor];
        labelCheckInformation.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:17];
        labelCheckInformation.alpha=0;
        
    
        [UIView animateWithDuration:1.0 animations:^{
            labelCheckCode.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 animations:^{
                labelCheckInformation.alpha = 1;
            }];
        }];

        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.tag=666;
        activityIndicator.center=CGPointMake(checkView.frame.size.width/2,checkView.frame.size.height/2+60);
        [activityIndicator startAnimating];
        
        
        
        [checkView addSubview:imageGlassCheck];
        
        [checkView addSubview:labelCheckPhone];
        [checkView addSubview:labelCheckCode];
        [checkView addSubview:labelCheckInformation];
        
        [checkView addSubview:activityIndicator];
        [mainScrollView addSubview:checkView];
        //
        
        //Индикатор загрузки
        UIActivityIndicatorView *loadIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        loadIndicator.center=CGPointMake(self.center.x,self.center.y+160);
        [loadIndicator startAnimating];
        loadIndicator.tag=307;
        [mainScrollView addSubview:loadIndicator];
        
        //
        
        
        
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
        return (newLength > 5) ? NO : YES;
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



