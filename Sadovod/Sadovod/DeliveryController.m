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
#import "SingleTone.h"
#import "FormalizationController.h"
#import "BasketController.h"

@interface DeliveryController () <BottomBasketViewDelegate>

@property (strong, nonatomic) BottomBasketView * basketView;

@end

@implementation DeliveryController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

}

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
    FormalizationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"FormalizationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
