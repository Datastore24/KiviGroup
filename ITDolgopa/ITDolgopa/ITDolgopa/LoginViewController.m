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
    NSDictionary * responseInfo;
    AuthCoreDataClass * authCoreDataClass;
    UITextField * textFieldPhone;
    UIButton * buttonGetCode;
    UIView * viewLoginPhone;
    UILabel * labelPlaceHolderPhone;
    UIView * checkView;
    UIActivityIndicatorView *loadIndicator;
    
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
    
    loadIndicator=(UIActivityIndicatorView*)[self.view viewWithTag:307];
    [loadIndicator stopAnimating];
    [loadIndicator setHidden:YES];
    
    if([authCoreDataClass showAllUsers].count>0){
         UserInfo * userInfo = [[authCoreDataClass showAllUsers] objectAtIndex:0];
        NSLog(@"userInfo.salt: %@",userInfo.salt);
        if(userInfo.salt.length != 0 && userInfo.phone.length != 0){
            [self performSelector:@selector(checkAuth) withObject:nil afterDelay:1.8f]; //Запуск проверки с паузой
        }else{
            [self showLoginWith:NO];
        }
    }else{
        [self showLoginWith:NO];
    }
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
        buttonGetCode.userInteractionEnabled=NO;
        buttonGetCode.alpha=0.5;
        [self getSalt:textFieldPhone.text andBlock:^{
            NSLog(@"ERROR: %@",[responseSalt objectForKey:@"error"]);
            if ([[responseSalt objectForKey:@"error"]integerValue]==0) {
                if (!isBool) {
                    [UIView animateWithDuration:0.3 animations:^{
                        UIView * mainViewSMS = (UIView*)[self.view viewWithTag:305];
                        CGRect rect = mainViewSMS.frame;
                        rect.origin.x = rect.origin.x + 369;
                        mainViewSMS.frame = rect;
                    }];
                    [loadIndicator setHidden:YES];
                    [loadIndicator stopAnimating];
                    isBool = YES;
                }
            } else if ([[responseSalt objectForKey:@"error"]integerValue]==1) {
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert showSuccess:@"Внимание" subTitle:[responseSalt objectForKey:@"error_msg"] closeButtonTitle:@"Ок" duration:0.0f];
                [loadIndicator setHidden:YES];
                [loadIndicator stopAnimating];
            } else if ([[responseSalt objectForKey:@"error"]integerValue]==2) {
                NSLog(@"Загеристрируйся");
                [loadIndicator setHidden:YES];
                [loadIndicator stopAnimating];
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
    
    
    [self getInfo:textFieldPhone.text andSalt:textFieldSMS.text andBlock:^{
        NSLog(@"ERROR2: %@",[responseInfo objectForKey:@"error_msg"]);
        
        if ([[responseInfo objectForKey:@"error"]integerValue]==0) {
            [authCoreDataClass updateUser:[responseInfo objectForKey:@"contr_fio"] andSalt:[responseInfo objectForKey:@"salt"] andPhone:[responseInfo objectForKey:@"contr_phone"]];
            RegistrationViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"registration"];
            [self.navigationController pushViewController:detail animated:YES];
        } else if ([[responseInfo objectForKey:@"error"]integerValue]==1) {
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert showSuccess:@"Внимание" subTitle:[responseInfo objectForKey:@"error_msg"] closeButtonTitle:@"Ок" duration:0.0f];
            [loadIndicator setHidden:YES];
            [loadIndicator stopAnimating];
        }
        
        
    }];

}


#pragma mark - API

-(void) getSalt:(NSString *) phone andBlock:(void (^)(void))block
{
    
    NSString * phoneResult = [phone stringByReplacingOccurrencesOfString: @"+" withString: @""];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             phoneResult,@"phone",
                             nil];
    
    [loadIndicator setHidden:NO];
    [loadIndicator startAnimating];
    
    
    APIGetClass * getAPI = [[APIGetClass alloc] init];
    [getAPI getDataFromServerWithParams:params method:@"get_salt" complitionBlock:^(id response) {
        NSLog(@"%@", response);
        
        responseSalt = (NSDictionary*)response;
        block();

    }];
}

-(void) getInfo:(NSString *) phone andSalt:(NSString*) salt andBlock:(void (^)(void))block
{
    
    NSString * phoneResult = [phone stringByReplacingOccurrencesOfString: @"+" withString: @""];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             phoneResult,@"phone",
                             salt,@"salt",
                             nil];
    
    [loadIndicator setHidden:NO];
    [loadIndicator startAnimating];
    
    
    APIGetClass * getAPI = [[APIGetClass alloc] init];
    [getAPI getDataFromServerWithParams:params method:@"get_info" complitionBlock:^(id response) {
        NSLog(@"%@", response);
        
        responseInfo = (NSDictionary*)response;
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
    
        if(userInfo.salt.length != 0 && userInfo.phone.length != 0){
    [getInfo getDataFromServerWithParams:params method:@"get_info" complitionBlock:^(id response) {
        NSLog(@"%@", response);

        
        NSDictionary * responseCheckInfo = (NSDictionary*)response;
        
        if ([[responseCheckInfo objectForKey:@"error"] integerValue] == 0) {
            [self showLoginWith:YES];
            
            RegistrationViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"registration"];
            [self.navigationController pushViewController:detail animated:YES];
        } else {
            NSLog(@"%@", [responseCheckInfo objectForKey:@"error_msg"]);
            
            [self showLoginWith:YES];
            
        }
        
        
    }];
        }else{
            [self showLoginWith:NO];

        }
    }
}

-(void)showLoginWith:(BOOL) animation{
    if(animation){
    [UIView animateWithDuration:2.0 animations:^{
        textFieldPhone.alpha=1;
        buttonGetCode.alpha=1;
        viewLoginPhone.alpha=1;
        labelPlaceHolderPhone.alpha=1;
        checkView.alpha=0;
    }];
    }else{
        textFieldPhone.alpha=1;
        buttonGetCode.alpha=1;
        viewLoginPhone.alpha=1;
        labelPlaceHolderPhone.alpha=1;
        checkView.alpha=0;
    }
}


@end
