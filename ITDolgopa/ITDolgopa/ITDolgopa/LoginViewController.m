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
#import "AuthCoreDataClass.h"
#import "UserInfo.h"
#import "RegistrationViewController.h"
#import "AlertClass.h"

@implementation LoginViewController
{
    BOOL isBool;
    NSDictionary * responseSalt;
    AuthCoreDataClass * authCoreDataClass;
    UITextField * textFieldPhone;
    UIButton * buttonGetCode;
    UIView * viewLoginPhone;
    UILabel * labelPlaceHolderPhone;
    UIView * checkView;
    
}

- (void) viewDidLoad {
    [super viewDidLoad];
    authCoreDataClass = [[AuthCoreDataClass alloc] init];
    isBool = NO;

#pragma mark - initialization
    
//Добавляем UIЭлементы в приложение через кнтроллер-------------------------
    
    
    
    
    
    self.navigationController.navigationBar.hidden = YES; // спрятал navigation bar
    LoginView * loginView = [[LoginView alloc] initWithView:self.view];
    [self.view addSubview:loginView];
    //Создание кнопки ввода ПОЛУЧИТЬ КОД----------------------------------------------
    buttonGetCode = (UIButton*)[self.view viewWithTag:301];
    [buttonGetCode addTarget:self action:@selector(buttonGetCodeAction)
            forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * buttonLogin = (UIButton*)[self.view viewWithTag:304];
    [buttonLogin addTarget:self action:@selector(buttonLoginAction)
                      forControlEvents:UIControlEventTouchUpInside];
    
    //Убираем в 0 для вывода проверки
    buttonGetCode.alpha=0;
    
    textFieldPhone = (UITextField*)[self.view viewWithTag:302];
    textFieldPhone.alpha = 0;
    
    viewLoginPhone = (UIView*)[self.view viewWithTag:3021];
    viewLoginPhone.alpha = 0;
    
    labelPlaceHolderPhone = (UILabel*)[self.view viewWithTag:3022];
    labelPlaceHolderPhone.alpha = 0;
    
    checkView = (UIView*)[self.view viewWithTag:306];
    
    
    [self performSelector:@selector(checkAuth) withObject:nil afterDelay:3.0f]; //Запуск проверки с паузой
    //

    

    
}


#pragma mark - Buttons Methods

//Действие кнопки buttonGetCode
- (void) buttonGetCodeAction
{
    
    if (textFieldPhone.text.length <= 11) {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert showSuccess:@"Внимание" subTitle:@"Не верное колличество символов" closeButtonTitle:@"Ок" duration:0.0f];
    } else {
        [self getSalt:textFieldPhone.text andBlock:^{
            if ([[responseSalt objectForKey:@"error"]integerValue]==0) {
                if (!isBool) {
                    [UIView animateWithDuration:0.3 animations:^{
                        UIView * mainViewSMS = (UIView*)[self.view viewWithTag:305];
                        CGRect rect = mainViewSMS.frame;
                        rect.origin.x = rect.origin.x + 369;
                        mainViewSMS.frame = rect;
                    }];
                    isBool = YES;
                }
                [authCoreDataClass updateUser:[responseSalt objectForKey:@"contr_fio"] andSalt:[responseSalt objectForKey:@"salt"] andPhone:[responseSalt objectForKey:@"contr_phone"]];
            } else if ([[responseSalt objectForKey:@"error"]integerValue]==1) {
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert showSuccess:@"Внимание" subTitle:[responseSalt objectForKey:@"error_msg"] closeButtonTitle:@"Ок" duration:0.0f];
            } else if ([[responseSalt objectForKey:@"error"]integerValue]==2) {
                NSLog(@"Загеристрируйся");
            }
            
        }];

    }
}

//Реалезация действия кнопки войти------------------------------------------------------
- (void) buttonLoginAction {

    //Необходимо создать синглтон в котором будет храниться телефон и ключ--------------
    //И напистаь метод отправляющий на сервер девайс токен------------------------------
    //Запрос баланса сразу, и положить в SingleTONE
    
    UITextField * textFieldSMS = (UITextField*)[self.view viewWithTag:303];
    
    if ([authCoreDataClass checkSalt:textFieldSMS.text]) {
        RegistrationViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"registration"];
        [self.navigationController pushViewController:detail animated:YES];
    } else {
        
        [AlertClass showAlertViewWithMessage:@"Неверный пароль" view:self];
    }
}


#pragma mark - API

-(void) getSalt:(NSString *) phone andBlock:(void (^)(void))block
{
    
    NSString * phoneResult = [phone stringByReplacingOccurrencesOfString: @"+" withString: @""];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             phoneResult,@"phone",
                             nil];
    
    APIGetClass * getAPI = [[APIGetClass alloc] init];
    [getAPI getDataFromServerWithParams:params method:@"get_salt" complitionBlock:^(id response) {
        NSLog(@"%@", response);
        responseSalt = (NSDictionary*)response;
        block();

    }];
}


-(void) checkAuth
{
    if([authCoreDataClass showAllUsers].count>0){
    UserInfo * userInfo = [[authCoreDataClass showAllUsers] objectAtIndex:0];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             userInfo.phone,@"phone",
                             userInfo.salt, @"salt",
                             nil];
    
    APIGetClass * getInfo = [[APIGetClass alloc] init];
    [getInfo getDataFromServerWithParams:params method:@"get_info" complitionBlock:^(id response) {
        NSLog(@"%@", response);
        NSDictionary * responseInfo = (NSDictionary*)response;
        
        if ([[responseInfo objectForKey:@"error"] integerValue] == 0) {
            RegistrationViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"registration"];
            [self.navigationController pushViewController:detail animated:YES];
        } else {
            NSLog(@"%@", [responseInfo objectForKey:@"error_msg"]);
            
            [UIView animateWithDuration:2.0 animations:^{
                textFieldPhone.alpha=1;
                buttonGetCode.alpha=1;
                viewLoginPhone.alpha=1;
                labelPlaceHolderPhone.alpha=1;
                checkView.alpha=0;
                checkView=0;
            }];
            
        }
        
        
    }];
    }else{
        [UIView animateWithDuration:2.0 animations:^{
            textFieldPhone.alpha=1;
            buttonGetCode.alpha=1;
            viewLoginPhone.alpha=1;
            labelPlaceHolderPhone.alpha=1;
            checkView.alpha=0;
            checkView=0;
        }];
    }
}

@end
