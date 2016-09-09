//
//  DeliveryController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 09/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "DeliveryController.h"
#import "CatalogController.h"
#import "DeliveryView.h"

@implementation DeliveryController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"Доставка" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
#pragma mark - View
    
    DeliveryView * mainView = [[DeliveryView alloc] initWithView:self.view andData:nil];
    [self.view addSubview:mainView];
    
}

#pragma mark - Actions

- (void) buttonBackAction {
    CatalogController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogController"];
    [self.navigationController pushViewController:detail animated:NO];
}

@end
