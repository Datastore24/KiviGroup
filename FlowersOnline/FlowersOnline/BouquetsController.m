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

@interface BouquetsController ()

@end

@implementation BouquetsController
{
    UIView * view;
}

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
    
    view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 75, 10, 30, 20)];
    view.backgroundColor = [UIColor clearColor];
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = 1.5f;
    view.layer.cornerRadius = 7.f;
    [self.navigationController.navigationBar addSubview:view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewNotificationAlpha) name:@"alphaView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewNotificationAlphaTrue) name:@"viewNotificationAlpha" object:nil];
    
    UILabel * labelBasket = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    labelBasket.text = @"3";
    labelBasket.textColor = [UIColor whiteColor];
    labelBasket.font = [UIFont fontWithName:FONTREGULAR size:14];
    labelBasket.textAlignment = NSTextAlignmentCenter;
    [view addSubview:labelBasket];
    
#pragma mark - View
    
    BouquetsView * mainView = [[BouquetsView alloc] initWithView:self.view];
    [self.view addSubview:mainView];
    
    
    
}

- (void) viewNotificationAlpha
{
    view.alpha = 0.f;
}

- (void) viewNotificationAlphaTrue
{
    view.alpha = 1.f;
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
