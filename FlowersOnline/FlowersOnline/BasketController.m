//
//  BasketController.m
//  FlowersOnline
//
//  Created by Viktor on 13.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "BasketController.h"
#import "UIColor+HexColor.h"
#import "ButtonMenu.h"
#import "TitleClass.h"
#import "BasketView.h"
#import "CheckoutController.h"
#import "SingleTone.h"

@implementation BasketController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"alphaView" object:nil];
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [ButtonMenu createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=buttonMenu;
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"КОРЗИНА"];
    self.navigationItem.titleView = title;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushCheckout) name:NOTIFICATION_BASKET_CONTROLLER_PUSH_CHEKOUT_CONTROLLER object:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
#pragma mark - Initialization
    
    BasketView * mainView = [[BasketView alloc] initWithView:self.view andData:[[SingleTone sharedManager] arrayBouquets]];
    [self.view addSubview:mainView];

}

- (void) viewWillAppear:(BOOL)animated
{
    [[SingleTone sharedManager] viewBasketBar].alpha = 0;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [[SingleTone sharedManager] viewBasketBar]. alpha = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) pushCheckout
{
    CheckoutController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CheckoutController"];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
