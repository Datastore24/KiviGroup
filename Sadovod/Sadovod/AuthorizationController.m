//
//  AuthorizationController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 08/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AuthorizationController.h"
#import "CatalogController.h"
#import "AuthorizationView.h"
#import "SingleTone.h"
#import "CatalogController.h"
#import "RegistrationController.h"
#import "FormalizationController.h"
#import "BasketController.h"
#import "ChangePasswordController.h"
#import "AlertClassCustom.h"
#import "PopAnimator.h"
#import "PushAnimator.h"
#import "APIGetClass.h"
#import "AuthDbClass.h"
#import "Auth.h"
#import "Macros.h"


@interface AuthorizationController () <AuthorizationViewDelegate, BottomBasketViewDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) BottomBasketView * basketView;

@end

@implementation AuthorizationController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.delegate = self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    if ([[[SingleTone sharedManager] typeMenu] isEqualToString:@"0"]) {
    [self setCustomTitle:@"Войти" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    } else {
       [self setCustomTitle:@"Профиль" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка 
    }
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
#pragma mark - View
    
    AuthorizationView * mainView = [[AuthorizationView alloc] initWithView:self.view andData:nil];
    mainView.delegate = self;
    [self.view addSubview:mainView];
    
    self.basketView = [[BottomBasketView alloc] initBottomBasketViewWithPrice:[[SingleTone sharedManager] priceType] andCount:[[SingleTone sharedManager] countType] andView:self.view];
    
    
    self.basketView.delegate = self;

    if ([[[SingleTone sharedManager] typeMenu] integerValue] != 0) {
    if ([[[SingleTone sharedManager] countType] integerValue] != 0) {
        self.basketView.alpha = 1.f;
    }
    }
    [self.view addSubview:self.basketView];
    
}

#pragma mark - Actions

- (void) buttonBackAction {
        CatalogController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogController"];
        [self.navigationController pushViewController:detail animated:NO];
}

#pragma mark - AuthorizationViewDelegate

- (void) methodInput: (AuthorizationView*) authorizationView {
    [self buttonBackAction];
}

- (void) methodRegistration: (AuthorizationView*) authorizationView {
    RegistrationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationController"];
    [self.navigationController pushViewController:detail animated:NO];
}

- (void) pushChangePassWork: (AuthorizationView*) authorizationView {
    ChangePasswordController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordController"];
    [self.navigationController pushViewController:detail animated:YES];
}

-(void) getApiAutorisation: (AuthorizationView*) registrationView andblock:(void (^)(void))block
         andEmail: (NSString *) email
        andPassword: (NSString *) password
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                      
                             email,@"login",
                             password,@"password",
                             [[SingleTone sharedManager] catalogKey], @"key",
                             @"ios_sadovod",@"appname",
                             nil];
    
    NSLog(@"PARAMS %@",params);
    
    [api getDataFromServerWithParams:params method:@"auth" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
            NSLog(@"AUTO %@",respDict);
            
            
//            self.regDict = respDict;
            
            if([[respDict objectForKey:@"status"] integerValue] == 1){
                AuthDbClass * authDbClass = [[AuthDbClass alloc] init];
                [authDbClass checkKey:[respDict objectForKey:@"token"] andCatalogKey:[respDict objectForKey:@"token"]];
                
                
                [[SingleTone sharedManager] setSuperKey:[respDict objectForKey:@"super_key"]];
                [[SingleTone sharedManager] setCatalogKey:[respDict objectForKey:@"catalog_key"]];
                [authDbClass changeEnter:@"1"];
                [[SingleTone sharedManager] setTypeMenu:@"1"]; //Меняем синглтон авторизации
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_AUTORIZATION object:nil]; //Производим оповещение требуемых окон
                //    

                 block();
            }else{
                NSLog(@"MESSAGE %@",[respDict objectForKey:@"message"]);
            }
            
          
            
           
            
            
        }
        
    }];
    
}

#pragma mark - BottomBasketViewDelegate

- (void) actionBasket: (BottomBasketView*) bottomBasketView {
    BasketController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BasketController"];
    [self.navigationController pushViewController:detail animated:YES];
}
- (void) actionFormalization: (BottomBasketView*) bottomBasketView {
    if ([[[SingleTone sharedManager] priceType] integerValue] < 1990) {
        [AlertClassCustom createAlertMinPrice];
    } else {
        FormalizationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"FormalizationController"];
        [self.navigationController pushViewController:detail animated:YES];
    }
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
