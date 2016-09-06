//
//  FormalizationController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 05/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "FormalizationController.h"
#import "FormalizationView.h"

@interface FormalizationController()

@end

@implementation FormalizationController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"Оформление заказа" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
#pragma mark - View
    
    FormalizationView * mainView = [[FormalizationView alloc] initWithView:self.view andData:nil];
    [self.view addSubview:mainView];
    
}

#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:NO];
}

@end
