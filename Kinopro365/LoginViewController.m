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

@interface LoginViewController ()

@property (assign, nonatomic) NSInteger timerStep; //Счетчик таймера
@property (strong, nonatomic) UserInformationTable * selectedDataObject;
@property (strong, nonatomic) RLMResults *tableDataArray;
@property (strong, nonatomic) NSDictionary * dictResponse;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end

@implementation LoginViewController

- (void) loadView {
    [super loadView];
    self.isAuth = NO;
    self.buttonSendCode.layer.cornerRadius = 4.f;
    self.buttonEntrance.layer.cornerRadius = 4.f;
    [self checkAuthVK];
    [self checkAuthFB];
    
    [self hideAllTextFildWithMainView:self.view];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timerStep = 25;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
                                                       replacementString:(NSString *)string {
    
    if (textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {

        return [textField checkForNamberPhoneWithTextField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

#pragma mark - Actions

//Получить код----------
- (IBAction)actionButtonSendCode:(UIButton *)sender {
    
    if (self.textFildPhone.text.length == 0) {
        [self showAlertWithMessage:@"\nВведите номер телефона!\n"];
    } else {
    
    sender.userInteractionEnabled = NO;
    [sender setTitle:@"" forState:UIControlStateNormal];
    
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
        PersonalDataController * tmpViewController = [self.storyboard
                                                      instantiateViewControllerWithIdentifier:@"PersonalDataController"];
        [self.navigationController pushViewController:tmpViewController animated:YES];
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

-(void) checkAuthFB{
    if ([FBSDKAccessToken currentAccessToken]) {
        [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
        [self authComplete];
    }else{
        NSLog(@"ERROR ENTER FB");
    }
}

-(void) checkAuthVK {
    
    self.tableDataArray=[UserInformationTable allObjects];
    if (self.tableDataArray.count >0 ){
        
    
        self.selectedDataObject = [self.tableDataArray objectAtIndex:0];
        NSLog(@"FETCH %@",self.selectedDataObject);
        NSString * userID = self.selectedDataObject.vkID;
        NSString * vkToken = self.selectedDataObject.vkToken;
        
        VKAPI * vkAPI = [[VKAPI alloc] init];
        [vkAPI getUserWithParams:userID andVkToken:vkToken complitionBlock:^(id response) {
            self.dictResponse = (NSDictionary*) response;
            
            if (![[self.dictResponse objectForKey:@"error"] isKindOfClass: [NSDictionary class]]){
                NSLog(@"DICT %@",self.dictResponse);
                [self authComplete];
            }else{
                NSLog(@"ERROR AUTH VK");
            }
            
        }];
    
//    //Теперь попробуем вытяныть некую информацию
   

  }
}
@end
