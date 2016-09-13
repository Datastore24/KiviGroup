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

@implementation AuthorizationController

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
    [self.view addSubview:mainView];
    
}

#pragma mark - Actions

- (void) buttonBackAction {
    CatalogController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogController"];
    [self.navigationController pushViewController:detail animated:NO];
}


@end
