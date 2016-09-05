//
//  FormalizationController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 05/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "FormalizationController.h"

@implementation FormalizationController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"Оформление заказа" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    self.arrayData = [self setCustonArray];
    
#pragma mark - View
    
}

@end
