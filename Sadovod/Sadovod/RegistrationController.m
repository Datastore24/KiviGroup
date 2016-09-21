//
//  RegistrationController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 08/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "RegistrationController.h"
#import "CatalogController.h"
#import "RegistrationView.h"
#import "SingleTone.h"
#import "FormalizationController.h"
#import "BasketController.h"
#import "AlertClassCustom.h"

@interface RegistrationController () <BottomBasketViewDelegate, RegistrationViewDelegate>

@property (strong, nonatomic) BottomBasketView * basketView;

@end

@implementation RegistrationController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

}

- (void) viewDidLoad {
    [super viewDidLoad];
    if ([[[SingleTone sharedManager] typeMenu] isEqualToString:@"0"]) {
    [self setCustomTitle:@"Регистрация" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    } else {
    [self setCustomTitle:@"Мои заказы" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    }
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
#pragma mark - View
    
    RegistrationView * mainView = [[RegistrationView alloc] initWithView:self.view andData:[self createArray]];
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
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        CatalogController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogController"];
        [self.navigationController pushViewController:detail animated:NO];
    }
}

- (NSArray *) createArray {
    NSMutableArray * arrayData = [[NSMutableArray alloc] init];
    
    NSArray * numberArray = [NSArray arrayWithObjects:@"843", @"236", @"346", @"824", @"148", @"534", nil];
    NSArray * dateArray = [NSArray arrayWithObjects:
                           @"13 Апреля в 18:34", @"24 Сентября в 10:34", @"10 Июля в 20:34",
                           @"13 Мая в 13:50", @"30 Сентября в 10:00", @"13 Августа в 18:34", nil];
    NSArray * arrayPrice = [NSArray arrayWithObjects:@"877", @"2470", @"3574", @"905", @"1746", @"780", nil];
    NSArray * arrayStatus = [NSArray arrayWithObjects:
                             @"В обработке", @"Собирается", @"Ожидает оплаты",
                             @"Готов в отправке", @"Отправлен", @"Отменен", nil];
    
    for (int i = 0; i < numberArray.count; i++) {
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [numberArray objectAtIndex:i], @"number",
                               [dateArray objectAtIndex:i], @"date",
                               [arrayPrice objectAtIndex:i], @"price",
                               [arrayStatus objectAtIndex:i], @"status", nil];
//        [arrayData addObject:dict];
    
    }
    NSArray * mainArray = [NSArray arrayWithArray:arrayData];
    
    return mainArray;
    
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

#pragma mark - RegistrationViewDelegate

- (void) backToMainView: (RegistrationView*) registrationView {
    CatalogController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogController"];
    [self.navigationController pushViewController:detail animated:NO];
}

@end
