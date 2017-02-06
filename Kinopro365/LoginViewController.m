//
//  LoginViewController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 08.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "LoginViewController.h"
#import "VkLoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UserInformationTable.h"
#import "VKAPI.h"
#import "APIManger.h"
#import "UserInformationTable.h"
#import "SingleTone.h"

@interface LoginViewController ()

@property (assign, nonatomic) NSInteger timerStep; //Счетчик таймера
@property (strong, nonatomic) NSString * tempCode; //Пока смс не работает
@property (strong, nonatomic)  APIManger * apiManager;
@property (assign, nonatomic) BOOL animation; //Сля првоерки что анимация произойдет только один раз


@end

@implementation LoginViewController

- (void) loadView {
    [super loadView];
    self.isAuth = NO;
    self.buttonSendCode.layer.cornerRadius = 4.f;
    self.buttonEntrance.layer.cornerRadius = 4.f;
    self.apiManager = [[APIManger alloc] init];


    [self hideAllTextFildWithMainView:self.view];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timerStep = 25;
    self.animation = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.buttonEntrance.alpha = 0;
    self.buttonEntrance.userInteractionEnabled = NO;
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField.keyboardType == UIKeyboardTypeNumberPad) {
        if ([textField.text isEqualToString:@""]) {
            textField.text = @"+";
        }
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.keyboardType == UIKeyboardTypeNumberPad) {
        if ([textField.text isEqualToString:@"+"]) {
            textField.text = @"";
        }
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
                                                       replacementString:(NSString *)string {
    
    if (textField.keyboardType == UIKeyboardTypeNumberPad) {

        return [textField checkForPhoneWithTextField:textField shouldChangeCharactersInRange:range replacementString:string complitionBlock:^(NSString *response) {
            

            
        }];
    }
    return YES;
}

#pragma mark - Actions

//Получить код----------
- (IBAction)actionButtonSendCode:(UIButton *)sender {
    
    if (self.textFildPhone.text.length == 0) {
        [self showAlertWithMessage:@"\nВведите номер телефона!\n"];
    } else {
        
        BOOL isBool = NO; //Тестовая булька для Кирилла
        
        if (self.animation) {
            [UIView animateWithDuration:0.3 animations:^{
                
                if (!isBool) {
                    CGRect buttonFrame = self.buttonSendCode.frame;
                    buttonFrame.size.width /= 2.2;
                    buttonFrame.origin.x = CGRectGetMaxX(self.textFildPhone.bounds) - buttonFrame.size.width / 1.6;
                    self.buttonSendCode.frame = buttonFrame;
                } else {
                    self.buttonSendCode.alpha = 0.f;
                    CGRect rectCode = self.textFildPassword.frame;
                    rectCode.size.width = self.textFildPhone.frame.size.width;
                    self.textFildPassword.frame = rectCode;
                }
            }];
            
            self.animation = NO;
        }
        
               sender.userInteractionEnabled = NO;
        [self createActivitiIndicatorAlertWithView];
        NSLog(@"AUTH");
    [sender setTitle:@"" forState:UIControlStateNormal];
        
        NSString * sendPhoneNumber;
        sendPhoneNumber = [self.textFildPhone.text
                                        stringByReplacingOccurrencesOfString:@"(" withString:@""];
        sendPhoneNumber = [sendPhoneNumber
                                        stringByReplacingOccurrencesOfString:@")" withString:@""];
        sendPhoneNumber = [sendPhoneNumber
                                   stringByReplacingOccurrencesOfString:@"+" withString:@""];
                                   NSLog(@"PHONE %@",self.textFildPhone.text);
        
        NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"bvb2wtC1cWM0CFgH6YkE",@"app_token",
                                 sendPhoneNumber,@"phone",nil];
        NSLog(@"PARAMS %@",params);
        [self.apiManager postDataFromSeverWithMethod:@"account.sendSmsCode" andParams:params andToken:nil complitionBlock:^(id response) {
            [self deleteActivitiIndicator];
            if([[response objectForKey:@"response"] integerValue] == 1){
                
                self.buttonEntrance.alpha = 1.f;
                self.buttonEntrance.userInteractionEnabled = YES;
                self.textFildPassword.userInteractionEnabled = YES;
                
            }else{
                NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                      [response objectForKey:@"error_msg"]);
                NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
                if(errorCode == 211){
                    //[self pushControllerWithIdentifier:@"ErrorInputController"];
                }
                if(errorCode == 212){
                    [self showAlertWithMessage:@"Введите корректный номер\nтелефона"];
                }
                
            }
            
            
            
            NSLog(@"RESPONSE %@",response);

        }];
       
        
        
        

    
    [self startTimerOnButton:sender];
    }
}

//Кнопка входа-------
- (IBAction)actionButtonEntrance:(UIButton *)sender {
    
    if (self.textFildPhone.text.length == 0) {
        [self showAlertWithMessage:@"\nВведите номер телефона!\n"];
    } else if (self.textFildPassword.text.length == 0) {
        [self showAlertWithMessage:@"\nВведите пароль!\n"];
    } else {
        
            
            NSString * sendPhoneNumber;
            sendPhoneNumber = [self.textFildPhone.text
                               stringByReplacingOccurrencesOfString:@"(" withString:@""];
            sendPhoneNumber = [sendPhoneNumber
                               stringByReplacingOccurrencesOfString:@")" withString:@""];
            sendPhoneNumber = [sendPhoneNumber
                               stringByReplacingOccurrencesOfString:@"+" withString:@""];

            NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     @"2",@"os_type",
                                     sendPhoneNumber,@"phone",
                                     @"GUID",@"device_token",
                                     self.textFildPassword.text,@"sms_code",nil];
            NSLog(@"PARAMS %@",params);
            [self createActivitiIndicatorAlertWithView];
            [self.apiManager postDataFromSeverWithMethod:@"account.authBySmsCode" andParams:params andToken:nil complitionBlock:^(id response) {
                 [self deleteActivitiIndicator];
                //ПРОВЕРКА НА ТИП АВТОРИЗАЦИИ
                
                if([response objectForKey:@"error_code"]){
                    [self deleteActivitiIndicator];
                    NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                          [response objectForKey:@"error_msg"]);
                    NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
                    if(errorCode == 221){
                        [self showAlertWithMessage:@"Вы ввели не верный\nSMS код"];
                    }
                    if(errorCode == 222){
                        [self showAlertWithMessage:@"Введенный код не верен.\nЗапросите код повторно"];
                        [UIView animateWithDuration:0.3 animations:^{
                            self.buttonSendCode.alpha = 1.f;
                        }];
                        self.textFildPassword.text = @"";
                        self.textFildPassword.userInteractionEnabled = NO;
                       
                    }
                    if(errorCode == 223){
                        [self showAlertWithMessage:@"Вам ограничили доступ к сервису"];
                        
                        self.textFildPhone.userInteractionEnabled = NO;
                        self.textFildPassword.userInteractionEnabled = NO;
                        self.buttonEntrance.userInteractionEnabled = NO;
                        self.buttonSendCode.userInteractionEnabled = NO;
                       
                        
                    }
                    
                    
                }else{
                   
                    
                        NSDictionary * dictResp = [response objectForKey:@"response"];
                     NSLog(@"RESPONSE %@",dictResp);
                        UserInformationTable * userInfoTable   = [[UserInformationTable alloc] init];
                        [userInfoTable  insertDataIntoDataBaseWithName:nil andVkID:nil siteToken:[dictResp objectForKey:@"token"]];
                        [[SingleTone sharedManager] setToken:[dictResp objectForKey:@"token"]];
                    
                    if([[dictResp objectForKey:@"status"] integerValue] == 0){
                        PersonalDataController * tmpViewController = [self.storyboard
                                                                      instantiateViewControllerWithIdentifier:@"PersonalDataController"];
                        [self.navigationController pushViewController:tmpViewController animated:YES];
                        
                    }else if([[dictResp objectForKey:@"status"] integerValue] == 10){
                        PersonalDataController * tmpViewController = [self.storyboard
                                                                      instantiateViewControllerWithIdentifier:@"KinoproViewController"];
                        [self.navigationController pushViewController:tmpViewController animated:YES];
                        
                    }
                        
                    
                    

                }
                
                
            }];
            
            
            
        
        
    }
}

//Вход через фейсбук
- (IBAction)actionButtonFacebook:(UIButton *)sender {
    
    NSLog(@"actionButtonFacebook");
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
//             FBSDKProfile * currentProfile = [[FBSDKProfile alloc] init];
//             NSLog(@"NAME: %@",currentProfile.firstName);
             [self authComplete];
         }
     }];
}


//Вход через VK
- (IBAction)actionButtonVK:(UIButton *)sender {
    
    NSLog(@"actionButtonVK");
    VkLoginViewController *vk = [[VkLoginViewController alloc] init];
    vk.appID = @"5773251";
    vk.delegate = self;
    [self presentViewController:vk animated:YES completion:nil];

}

#pragma mark - Timer

//Запуск таймера
- (void) startTimerOnButton: (UIButton*) button {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.labelTimerActive.alpha = 1.f;
        self.labelTimerDontActive.alpha = 1.f;
    }];
        [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(actionTimer:) userInfo:nil repeats:YES];
}

//Действие таймера
- (void) actionTimer: (NSTimer*) timer {
    
    self.timerStep -= 1;
    self.labelTimerActive.text = [NSString stringWithFormat:@"%ld сек.", (long)self.timerStep];
    
    if (self.timerStep == 0) {
        [timer invalidate];
        timer = nil;
        self.labelTimerActive.alpha = 0.f;
        self.labelTimerDontActive.alpha = 0.f;
        self.labelTimerActive.text = @"25 сек.";
        self.timerStep = 25;
        [UIView animateWithDuration:0.3 animations:^{
            [self.buttonSendCode setTitle:@"Выслать код" forState:UIControlStateNormal];
            self.buttonSendCode.userInteractionEnabled = YES;
        }];        
    }
}

#pragma mark - Autorization

- (void) authComplete {
    self.isAuth = YES;
    PersonalDataController * tmpViewController = [self.storyboard
                                                  instantiateViewControllerWithIdentifier:@"PersonalDataController"];
    [self.navigationController pushViewController:tmpViewController animated:YES];
    NSLog(@"isAuth: YES");
}



@end
