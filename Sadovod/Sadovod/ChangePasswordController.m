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


@implementation ChangePasswordController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
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
    [self.view addSubview:mainView];
    

}

#pragma mark - Actions

- (void) buttonBackAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
