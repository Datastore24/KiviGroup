//
//  RegistrationViewController.m
//  ITDolgopa
//
//  Created by Viktor on 12.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "RegistrationViewController.h"
#import "Macros.h"
#import "RegistrationView.h"
#import "APIGetClass.h"
#import "AlertClass.h"

@implementation RegistrationViewController
{
    APIGetClass * apiGetClass;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    apiGetClass = [[APIGetClass alloc] init];
    
    RegistrationView * registrationView = [[RegistrationView alloc] initWithView:self.view];
    [self.view addSubview:registrationView];
    
    //Кнопка назад----------------------------------------------------------------
    UIButton * buttonBack = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonBack.frame = CGRectMake(20, 30, 15.4f, 27.4f);
    [buttonBack addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * imageButtonBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15.4, 27.4)];
    imageButtonBack.image = [UIImage imageNamed:@"buttonBack.png"];
    [buttonBack addSubview:imageButtonBack];
    [registrationView addSubview:buttonBack];
    
    UIButton * buttonRegistration = (UIButton*)[self.view viewWithTag:310];
    [buttonRegistration addTarget:self action:@selector(buttonRegistrationAction)
                             forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - Buttons Methods

//Метод активации
- (void) buttonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Метод действия кнопки зарегистрироваться
- (void) buttonRegistrationAction{
    UITextField * textFieldPhone = (UITextField*)[self.view viewWithTag:312];
    UITextField * textFieldFIO = (UITextField*)[self.view viewWithTag:313];
    if (textFieldPhone.text.length < 12) {
        [AlertClass showAlertViewWithMessage:@"Вы ввел слишком мало символов" view:self];
    } else {
    [self getRegistrationWithFIO:textFieldFIO.text andPhone:textFieldPhone.text];
}
}
#pragma mark - API

- (void) getRegistrationWithFIO:(NSString*) fio
                        andPhone: (NSString*) phone
{
    NSString * phoneResult = [phone stringByReplacingOccurrencesOfString: @"+" withString: @""];
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:phoneResult, @"phone", fio, @"fio",  nil];
    [apiGetClass getDataFromServerWithParams:params method:@"registration" complitionBlock:^(id response) {
        NSDictionary * responseResult = (NSDictionary*) response;
        if ([[responseResult objectForKey:@"error"] integerValue] == 1) {
            [AlertClass showAlertViewWithMessage:[responseResult objectForKey:@"error_msg"] view:self];
        } else {
            [AlertClass showAlertViewWithMessage:@"Регистрация прошла успешно" view:self];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}



@end
