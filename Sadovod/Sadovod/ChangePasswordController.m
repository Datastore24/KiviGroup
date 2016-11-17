//
//  ChangePasswordController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 20.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ChangePasswordController.h"
#import "CatalogController.h"
#import "AuthorizationView.h"
#import "SingleTone.h"
#import "CatalogController.h"
#import "ChangePasswordView.h"
#import "PopAnimator.h"
#import "PushAnimator.h"
#import "APIGetClass.h"
#import "AlertClassCustom.h"

@interface ChangePasswordController () <UINavigationControllerDelegate,ChangePasswordViewDelegate>

@end


@implementation ChangePasswordController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.delegate = self;
}

- (void) viewDidLoad {
    [super viewDidLoad];

        [self setCustomTitle:@"Напомнить пароль" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка

    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
#pragma mark - View
    
    ChangePasswordView * mainView = [[ChangePasswordView alloc] initWithView:self.view andData:nil];
    mainView.delegate = self;
    [self.view addSubview:mainView];
    

}

#pragma mark - CHANGEPASSWORDVIEW DELEGATE

-(void) getApiPassword: (ChangePasswordView*) changePasswordView andblock:(void (^)(void))block
                  andEmail: (NSString *) email
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             email,@"email",
                             [[SingleTone sharedManager] catalogKey], @"key",
                             @"ios_sadovod",@"appname",
                             nil];
    
    NSLog(@"PARAMS %@",params);
    
    [api getDataFromServerWithParams:params method:@"password" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
            NSLog(@"AUTO %@",respDict);
            
            
            //            self.regDict = respDict;
            
            if([[respDict objectForKey:@"status"] integerValue] == 1){
                    block();
            }else{
                [AlertClassCustom createAlertWithMessage:@"Email не найден. Возможно Вы не зарегистрированы"];
                NSLog(@"MESSAGE %@",[respDict objectForKey:@"message"]);
            }
            
        }
        
    }];
    
}

- (void) buttonBackActionDelegate:(ChangePasswordView*) changePasswordView {
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Actions

- (void) buttonBackAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ANIMATION POP PUSH
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
    if (operation == UINavigationControllerOperationPush)
        return [[PushAnimator alloc] init];
    
    if (operation == UINavigationControllerOperationPop)
        return [[PopAnimator alloc] init];
    
    return nil;
}

@end
