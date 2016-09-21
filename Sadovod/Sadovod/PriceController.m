//
//  PriceController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 09/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "PriceController.h"
#import "CatalogController.h"
#import "PriceView.h"
#import "SingleTone.h"
#import "FormalizationController.h"
#import "BasketController.h"
#import "AlertClassCustom.h"
#import "QuestionController.h"
#import "FAQController.h"
#import "CatalogController.h"


@interface PriceController () <BottomBasketViewDelegate, PriceViewDelegate>

@property (strong, nonatomic) BottomBasketView * basketView;

@end

@implementation PriceController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"Оплата" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
#pragma mark - View
    
    PriceView * mainView = [[PriceView alloc] initWithView:self.view andData:nil];
    mainView.delegate = self;
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
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
    CatalogController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogController"];
    [self.navigationController pushViewController:detail animated:NO];
    }
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

#pragma mark - PriceViewDelegate

- (void) pushToQuestion: (PriceView*) priceView {
    QuestionController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionController"];
    [self.navigationController pushViewController:detail animated:YES];
}
- (void) pushToFAQ: (PriceView*) priceView {
    FAQController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"FAQController"];
    [self.navigationController pushViewController:detail animated:YES];
}
- (void) backToMain: (PriceView*) priceView {
    CatalogController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogController"];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
