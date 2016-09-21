//
//  ContactsController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 09/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ContactsController.h"
#import "CatalogController.h"
#import "ContactsView.h"
#import "SingleTone.h"
#import "FormalizationController.h"
#import "BasketController.h"
#import "AlertClassCustom.h"

@interface ContactsController () <BottomBasketViewDelegate>

@property (strong, nonatomic) BottomBasketView * basketView;

@end

@implementation ContactsController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"Контакты" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
#pragma mark - View
    
    ContactsView * mainView = [[ContactsView alloc] initWithView:self.view andData:nil];
    [self.view addSubview:mainView];
    

    self.basketView = [[BottomBasketView alloc] initBottomBasketViewWithPrice:@"700" andCount:[[SingleTone sharedManager] countType] andView:self.view];
    self.basketView.delegate = self;
    if ([[[SingleTone sharedManager] countType] integerValue] != 0) {
        self.basketView.alpha = 1.f;
    }
    [self.view addSubview:self.basketView];
    
}

#pragma mark - Actions

- (void) buttonBackAction {
    CatalogController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogController"];
    [self.navigationController pushViewController:detail animated:NO];
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
