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

@implementation LoginViewController

- (void) viewDidLoad {
    [super viewDidLoad];

#pragma mark - initialization
    
//Добавляем UIЭлементы в приложение через кнтроллер-------------------------
    
    self.navigationController.navigationBar.hidden = YES; // спрятал navigation bar
    
    LoginView * loginView = [[LoginView alloc] initWithView:self.view];
    [self.view addSubview:loginView];
    
    //Создание кнопки ввода ПОЛУЧИТЬ КОД----------------------------------------------

    UIButton * buttonGetCode = (UIButton*)[self.view viewWithTag:301];
    [buttonGetCode addTarget:self action:@selector(buttonGetCodeAction)
            forControlEvents:UIControlEventTouchUpInside];
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
    RegistrationViewController * detail = [self.storyboard
                                 instantiateViewControllerWithIdentifier:@"registration"];
    [self.navigationController pushViewController:detail animated:YES];
    }
}

@end
