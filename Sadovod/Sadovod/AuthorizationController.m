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

@interface AuthorizationController () <AuthorizationViewDelegate, BottomBasketViewDelegate>

@property (strong, nonatomic) BottomBasketView * basketView;

@end

@implementation AuthorizationController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
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
    
    self.basketView = [[BottomBasketView alloc] initBottomBasketViewWithPrice:@"700" andCount:[[SingleTone sharedManager] countType] andView:self.view];
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


@end
