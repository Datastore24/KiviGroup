//
//  BouquetsController.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 05.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "BouquetsController.h"
#import "UIColor+HexColor.h"
#import "ButtonMenu.h"
#import "TitleClass.h"
#import "BouquetsView.h"
#import "BasketController.h"
#import "SingleTone.h"

@interface BouquetsController ()

@end

@implementation BouquetsController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [ButtonMenu createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=buttonMenu;
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"БУКЕТЫ"];
    self.navigationItem.titleView = title;
    
    //Кнопка корзины---------------------------------------------
    UIButton * buttonBasket = [ButtonMenu createButtonBasket];
    [buttonBasket addTarget:self action:@selector(buttonBasketAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:buttonBasket];
    self.navigationItem.rightBarButtonItem = mailbutton;
    
    UIView * countOrdersView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 75, 10, 30, 20)];
    countOrdersView.backgroundColor = [UIColor clearColor];
    countOrdersView.layer.borderColor = [UIColor whiteColor].CGColor;
    countOrdersView.tag = 240;
    countOrdersView.layer.borderWidth = 1.5f;
    countOrdersView.layer.cornerRadius = 7.f;
    [self.navigationController.navigationBar addSubview:countOrdersView];
    [[SingleTone sharedManager] setViewBasketBar:countOrdersView];
    
    
    UILabel * labelBasket = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    labelBasket.text = @"0";
    labelBasket.textColor = [UIColor whiteColor];
    labelBasket.font = [UIFont fontWithName:FONTREGULAR size:14];
    labelBasket.textAlignment = NSTextAlignmentCenter;
    [countOrdersView addSubview:labelBasket];
    [[SingleTone sharedManager] setLabelCountBasket:labelBasket];
    
#pragma mark - View
    
    BouquetsView * mainView = [[BouquetsView alloc] initWithView:self.view];
    [self.view addSubview:mainView];

}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
