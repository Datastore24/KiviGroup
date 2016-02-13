//
//  LoginViewController.m
//  ITDolgopa
//
//  Created by Viktor on 04.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "Macros.h"
#import "RegistrationViewController.h"
#import "UIColor+HexColor.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "APIGetClass.h"

@implementation LoginViewController
{
    BOOL isBool;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    isBool = NO;

#pragma mark - initialization
    
//Добавляем UIЭлементы в приложение через кнтроллер-------------------------
    
    self.navigationController.navigationBar.hidden = YES; // спрятал navigation bar
    LoginView * loginView = [[LoginView alloc] initWithView:self.view];
    [self.view addSubview:loginView];
    //Создание кнопки ввода ПОЛУЧИТЬ КОД----------------------------------------------
    UIButton * buttonGetCode = (UIButton*)[self.view viewWithTag:301];
    [buttonGetCode addTarget:self action:@selector(buttonGetCodeAction)
            forControlEvents:UIControlEventTouchUpInside];
    
    APIGetClass * getAPI = [[APIGetClass alloc] init];
    [getAPI getDataFromServerWithParams:nil method:@"phone=89186198564" complitionBlock:^(id response) {
        NSLog(@"%@", response);
    }];
    
    
    
}


#pragma mark - Buttons Methods

//Действие кнопки buttonGetCode
- (void) buttonGetCodeAction
{
    UITextField * textField = (UITextField*)[self.view viewWithTag:302];
    if (textField.text.length <= 11) {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert showSuccess:@"Внимание" subTitle:@"Не верное колличество символов" closeButtonTitle:@"Ок" duration:0.0f];
    } else {
        
        if (!isBool) {
            [UIView animateWithDuration:0.3 animations:^{
                UIView * mainViewSMS = (UIView*)[self.view viewWithTag:305];
                CGRect rect = mainViewSMS.frame;
                rect.origin.x = rect.origin.x + 369;
                mainViewSMS.frame = rect;
            }];
            
            isBool = YES;
        }
        

                
//Сюда передаем данные--------------------------------------------------------------------
    }
}

@end
