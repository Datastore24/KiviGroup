//
//  DeliveryController.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 10.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "DeliveryController.h"
#import "UIColor+HexColor.h"
#import "ButtonMenu.h"
#import "TitleClass.h"
#import "DeliveryView.h"
#import "BasketController.h"
#import "SingleTone.h"

@interface DeliveryController ()

@end

@implementation DeliveryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark - Header
    
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [ButtonMenu createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=buttonMenu;
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ДОСТАВКА"];
    self.navigationItem.titleView = title;
    
    //Кнопка корзины---------------------------------------------
    UIButton * buttonBasket = [ButtonMenu createButtonBasket];
    [buttonBasket addTarget:self action:@selector(buttonBasketAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:buttonBasket];
    self.navigationItem.rightBarButtonItem = mailbutton;
    if ([[SingleTone sharedManager] arrayBouquets].count == 0) {
        mailbutton.enabled = NO;
    }
    
#pragma mark - Initialization
    
    DeliveryView * mainView = [[DeliveryView alloc] initWithView:self.view];
    [self.view addSubview:mainView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Buttons Action

- (void) buttonBasketAction
{
    BasketController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BasketController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
