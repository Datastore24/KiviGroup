//
//  SizeWebController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 21.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SizeWebController.h"
#import "CatalogController.h"
#import "SizesView.h"
#import "SingleTone.h"
#import "FormalizationController.h"
#import "BasketController.h"
#import "AlertClassCustom.h"
#import "PopAnimator.h"
#import "PushAnimator.h"

@interface SizeWebController ()

@end

@implementation SizeWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomTitle:@"Таблица размеров" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
