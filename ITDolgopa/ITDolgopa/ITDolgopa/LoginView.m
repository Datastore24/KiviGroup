//
//  LoginView.m
//  ITDolgopa
//
//  Created by Viktor on 05.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "LoginView.h"
#import "LoginViewController.h"
#import "Macros.h"

NSString* const LoginViewAnimationLeftNotification = @"LoginViewAnimationLeftNotification";
NSString* const LoginViewAnimationWriteNotification = @"LoginViewAnimationWriteNotification";

@interface LoginView () <UITextFieldDelegate>

@end


@implementation LoginView
{
    UIView* mainView;
}

#pragma mark - Initialization

//Метод инициализации вью для отображения окна логина---------------------
- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {        
        self.frame = view.frame;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        //Привязываем доп элементы к нашему вью---------------------------
        [self addSubview:[self addLabelPhone]];
        [self addSubview:[self addPhoneView]];
        
        
        //Инициализируем вью для анимации и подвязываем две нотификации---
        mainView = [[UIView alloc] initWithFrame:CGRectMake([self addLabelPhone].frame.origin.x - 70, [self addLabelPhone].frame.origin.y, 60, 40)];
        mainView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        mainView.alpha = 0.5;
        [self addSubview:mainView];
        [self animationMethodOnLeft];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationMethodOnLeft) name:LoginViewAnimationWriteNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationMethodOnWrite) name:LoginViewAnimationLeftNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testMethod) name:UITextFieldTextDidChangeNotification object:nil];
      
    }
    return self;
}

//Инициализирует заголовок "Введите номер телефона"----------------------
- (UILabel*) addLabelPhone {
    UILabel * labelPhoneTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (self.frame.size.width / 3) * 2, 40)];
    
    //Кастомное местоположение для определение центра и смещения его вверх
    CGPoint point = self.center;
    point.y = point.y - 150;
    labelPhoneTitle.center = point;
    labelPhoneTitle.text = @"Введите номер телефона";
    labelPhoneTitle.textAlignment = NSTextAlignmentCenter;
    labelPhoneTitle.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:17];
    return labelPhoneTitle;
}


//Инициализация UIView для ввода номера------------------------------
- (UIView*) addPhoneView {
    UIView * viewPhone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (self.frame.size.width / 2), 35)];
    //Кастомное местоположение для определение центра и смещения его вверх
    CGPoint point = self.center;
    point.y = point.y - 50;
    viewPhone.backgroundColor = [UIColor whiteColor];
    viewPhone.center = point;
    viewPhone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    viewPhone.layer.borderWidth = 1.f;
    viewPhone.layer.cornerRadius = 10.f;
    
    //Добавляем элементы TextField------------------------------------
    [viewPhone addSubview:[self addTextFieldPhone]];
    [viewPhone addSubview:[self addLabelTextPhone]];
    [viewPhone addSubview:[self addCustomPlaceholderTextFieldPhone]];
    return viewPhone;
}

//Инициализация UITextField для ввода номера------------------------------
- (UITextField*) addTextFieldPhone {
    UITextField * textFieldPhone = [[UITextField alloc] initWithFrame:CGRectMake(35, 0, (self.frame.size.width / 2) - 15, 40)];
//    textFieldPhone.backgroundColor = [UIColor blueColor];
    textFieldPhone.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:16];
    textFieldPhone.delegate = self;
    return textFieldPhone;
}

//Инициализация label +7-------------------------------------------------
- (UILabel*) addLabelTextPhone {
    UILabel * labelPhone = [[UILabel alloc] initWithFrame:CGRectMake(5, -1, 30, 40)];
    labelPhone.text = @"+7";
    labelPhone.textAlignment = NSTextAlignmentCenter;
    labelPhone.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:16];
    return labelPhone;
}

//Лейбл для placeholder -------------------------------------------------
-(UILabel*) addCustomPlaceholderTextFieldPhone {
    UILabel * placeholderPhoneLoginView = [[UILabel alloc] initWithFrame:CGRectMake(35, -1, (self.frame.size.width / 2) - 15, 40)];
    placeholderPhoneLoginView.text = @"(xxx) xxx-xxxx";
    placeholderPhoneLoginView.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:16];
//    placeholderPhoneLoginView.textAlignment = NSTextAlignmentCenter;
    placeholderPhoneLoginView.alpha = 0.4;
    return placeholderPhoneLoginView;
}

#pragma mark - MethodsAnimation

//Метод анимации передвигающий вью в права-------------------------------------
-(void)animationMethodOnLeft {
    [UIView animateWithDuration:1.5f animations:^{
        CGRect rect;
        rect = mainView.frame;
        rect.origin.x = rect.origin.x + 300;
        mainView.frame = rect;
    } completion:^(BOOL finished) {
        mainView.alpha = 0.f;
        [[NSNotificationCenter defaultCenter] postNotificationName:LoginViewAnimationLeftNotification object:nil];
    }];
}

//Метод анимации передвигающий вью в лево--------------------------------------
-(void)animationMethodOnWrite {
    [UIView animateWithDuration:0.1f animations:^{
        CGRect rect;
        rect = mainView.frame;
        rect.origin.x = rect.origin.x - 300;
        mainView.frame = rect;
    } completion:^(BOOL finished) {
        mainView.alpha = 0.5f;
        [[NSNotificationCenter defaultCenter] postNotificationName:LoginViewAnimationWriteNotification object:nil];
    }];
    
}

#pragma mark - UITextFieldDelegate

//Сворачивание клавиатуры----------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//Шаблон для ввода телефонного номера------------------------------------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{    
    int length = (int)[self getLength:textField.text];
    if(length == 10)
    {
        if(range.length == 0)
            return NO;
    }
    if(length == 3)
    {
        NSString *num = [self formatNumber:textField.text];
        textField.text = [NSString stringWithFormat:@"(%@) ",num];
        if(range.length > 0)
            textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
    }
    else if(length == 6)
    {
        NSString *num = [self formatNumber:textField.text];
        textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
        if(range.length > 0)
            textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
    }
    return YES;
}

- (NSString *)formatNumber:(NSString *)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    int length = (int)[mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
    }
    return mobileNumber;
}

- (int)getLength:(NSString *)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    int length = (int)[mobileNumber length];
    return length;
}

//При вводе текст в UITextField------------------------------------------------------------
- (void) testMethod {
    if ([self addTextFieldPhone].text.length == 0) {
        [self addCustomPlaceholderTextFieldPhone].alpha = 0.f;
    }
}

@end



